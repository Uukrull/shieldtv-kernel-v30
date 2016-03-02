LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_C_INCLUDES += bootable/recovery
LOCAL_C_INCLUDES += system/core/fs_mgr/include
LOCAL_C_INCLUDES += system/extras/ext4_utils

LOCAL_SRC_FILES := recovery_ui.cpp

# should match TARGET_RECOVERY_UI_LIB set in BoardConfig.mk
LOCAL_MODULE := librecovery_ui_default

ifeq ($(PLATFORM_IS_NEXT),1)
LOCAL_CFLAGS += -DPLATFORM_IS_NEXT=1
endif

include $(BUILD_STATIC_LIBRARY)
