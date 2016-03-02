ifneq (, $(filter 3.%, $(PLATFORM_VERSION)))
$(error Unsupported PLATFORM_VERSION = $(PLATFORM_VERSION))
endif
ifneq (, $(filter 4.2%, $(PLATFORM_VERSION)))
$(error Unsupported PLATFORM_VERSION = $(PLATFORM_VERSION))
endif
ifneq (, $(filter 4.3%, $(PLATFORM_VERSION)))
$(error Unsupported PLATFORM_VERSION = $(PLATFORM_VERSION))
endif

PLATFORM_IS_JELLYBEAN := 1
PLATFORM_IS_JELLYBEAN_MR1 := 1
PLATFORM_IS_JELLYBEAN_MR2 := 1
PLATFORM_IS_KITKAT := 1

ifneq (, $(filter 5.%, $(PLATFORM_VERSION)))
PLATFORM_IS_AFTER_KITKAT := 1
PLATFORM_IS_LOLLIPOP := 1
endif

ifeq ($(BUILD_ID),AOSP)
PLATFORM_IS_AFTER_KITKAT := 1
PLATFORM_IS_AFTER_LOLLIPOP := 1
endif

ifeq (, $(filter 4.4%, $(PLATFORM_VERSION)))
ifeq (, $(filter 5.%, $(PLATFORM_VERSION)))
PLATFORM_IS_AFTER_KITKAT := 1
PLATFORM_IS_AFTER_LOLLIPOP := 1
endif
endif

# Default os version letter code
PLATFORM_VERSION_LETTER_CODE := l

ifneq (,$(filter M 6.0,$(PLATFORM_VERSION)))
PLATFORM_IS_NEXT := 1
# Set android M os version letter code
PLATFORM_VERSION_LETTER_CODE := m
endif
