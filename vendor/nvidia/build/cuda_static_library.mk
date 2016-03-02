#
# Copyright (c) 2013-2014, NVIDIA CORPORATION.  All rights reserved.
#
# Nvidia CUDA target static library
#
LOCAL_MODULE_CLASS            := STATIC_LIBRARIES
LOCAL_MODULE_SUFFIX           := .a
LOCAL_SYSTEM_SHARED_LIBRARIES :=
LOCAL_UNINSTALLABLE_MODULE    := true
LOCAL_MULTILIB                := 32

# CUDA tools.  HACK!  These paths all need adjusting when we
# get the real CUDA toolkit in place.
ANDROID_CUDA_PATH=$(TOP)/vendor/nvidia/tegra/cuda-toolkit-7.0
CUDA_EABI=armv7-linux-androideabi
CUDA_TOOLKIT_ROOT=$(ANDROID_CUDA_PATH)/targets/$(CUDA_EABI)
LOCAL_CC := $(ANDROID_CUDA_PATH)/bin/nvcc
TMP_NDK := $(TOP)/prebuilts/ndk/9/
ifeq ($(PLATFORM_IS_AFTER_KITKAT),1)
    TMP_GCC_VER:=4.8
else
    TMP_GCC_VER:=4.7
endif

TMP_GPP := $(TOP)/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-$(TMP_GCC_VER)

# Override standard C flags
_local_cuda_cflags :=
_local_cuda_cflags += -target-cpu-arch=ARM
_local_cuda_cflags += -m32
_local_cuda_cflags += -gencode arch=compute_32,code=sm_32
_local_cuda_cflags += -gencode arch=compute_53,code=sm_53
_local_cuda_cflags += --use_fast_math
_local_cuda_cflags += -O3
_local_cuda_cflags += -Xptxas '-dlcm=ca'
_local_cuda_cflags += -target-os-variant=Android
#_local_cuda_cflags += -Xcompiler="-mtune=cortex-a9 -march=armv7-a -mfloat-abi=softfp -mfpu=neon"
_local_cuda_cflags += -DARCH_ARM
_local_cuda_cflags += -DDEBUG_MODE
_local_cuda_cflags += -Xcompiler --sysroot=$(TMP_NDK)/platforms/android-18/arch-arm/
_local_cuda_cflags += -I$(ANDROID_CUDA_PATH)/targets/$(CUDA_EABI)/include

_local_cuda_cflags += -I$(TMP_NDK)sources/cxx-stl/gnu-libstdc++/$(TMP_GCC_VER)/include
_local_cuda_cflags += -I$(TMP_NDK)sources/cxx-stl/gnu-libstdc++/$(TMP_GCC_VER)/libs/armeabi-v7a/include

# Let the user override flags above using LOCAL_CFLAGS
#_save_local_cflags := $(LOCAL_CFLAGS)
LOCAL_CFLAGS := $(_local_cuda_cflags)
#LOCAL_CFLAGS += $(_save_local_cflags)


NVCC_CC := $(TMP_GPP)/bin/arm-linux-androideabi-g++

include $(NVIDIA_BASE)

ifeq ($(TARGET_IS_64_BIT),true)
    LOCAL_2ND_ARCH_VAR_PREFIX := $(TARGET_2ND_ARCH_VAR_PREFIX)
endif

# Clear out other LOCAL_CFLAGS as needed
LOCAL_CFLAGS_arm :=
LOCAL_CFLAGS_32 :=

include $(BUILD_SYSTEM)/base_rules.mk
include $(NVIDIA_POST)

cuda_sources := $(filter %.cu,$(LOCAL_SRC_FILES))
cuda_objects := $(addprefix $(intermediates)/,$(cuda_sources:.cu=.o))

ALL_C_CPP_ETC_OBJECTS += $(cuda_objects)

$(cuda_objects): PRIVATE_CC         := $(LOCAL_CC) -ccbin $(NVCC_CC)
$(cuda_objects): PRIVATE_CFLAGS     := $(LOCAL_CFLAGS)
$(cuda_objects): PRIVATE_C_INCLUDES := $(LOCAL_C_INCLUDES)
$(cuda_objects): PRIVATE_MODULE     := $(LOCAL_MODULE)

ifneq ($(strip $(cuda_objects)),)
$(cuda_objects): $(intermediates)/%.o: $(LOCAL_PATH)/%.cu \
    $(LOCAL_ADDITIONAL_DEPENDENCIES) \
	| $(LOCAL_CC) $(NVCC_CC)
	@echo "target CUDA: $(PRIVATE_MODULE) <= $<"
	@echo "C includes: $(PRIVATE_C_INCLUDES) end"
	@mkdir -p $(dir $@)
	$(hide) $(PRIVATE_CC) \
	    $(addprefix -I , $(PRIVATE_C_INCLUDES)) \
	    $(PRIVATE_CFLAGS) \
	    -o $@ --compiler-options -MD,-MF,$(patsubst %.o,%.d,$@) -c $<
	$(transform-d-to-p)
-include $(cuda_objects:%.o=%.P)
endif

$(LOCAL_BUILT_MODULE): PRIVATE_CC := $(LOCAL_CC) -ccbin $(NVCC_CC) -m32 -lib
$(LOCAL_BUILT_MODULE): $(cuda_objects) \
	| $(LOCAL_CC) $(NVCC_CC)
	@mkdir -p $(dir $@)
	@rm -f $@
	@echo "target CUDA StaticLib: $(PRIVATE_MODULE) ($@)"
	$(hide) $(call split-long-arguments,$(PRIVATE_CC) -o $@,$(filter %.o, $^))
	touch $(dir $@)export_includes

export_includes := $(intermediates)/export_includes
$(export_includes): PRIVATE_EXPORT_C_INCLUDE_DIRS := $(LOCAL_EXPORT_C_INCLUDE_DIRS)
# Make sure .pb.h are already generated before any dependent source files get compiled.
$(export_includes) : $(LOCAL_MODULE_MAKEFILE) $(proto_generated_headers)
	@echo Export includes file: $< -- $@
	$(hide) mkdir -p $(dir $@) && rm -f $@
	$(hide) touch $@
