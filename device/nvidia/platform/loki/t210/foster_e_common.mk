# NVIDIA Tegra7 "foster_e" development system
#
# Copyright (c) 2014-2015, NVIDIA Corporation.  All rights reserved.

## This is the file that is common for all Foster_e skus(foster_e_base, foster_e_hdd).

HOST_PREFER_32_BIT := true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_profiles_foster_e.xml:system/etc/media_profiles.xml

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
PRODUCT_COPY_FILES += \
    device/nvidia/platform/loki/t210/audio_policy_foster.conf:system/etc/audio_policy.conf \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

else
PRODUCT_COPY_FILES += \
    device/nvidia/platform/t210/audio_policy_noenhance.conf:system/etc/audio_policy.conf \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

endif

PRODUCT_COPY_FILES += \
    device/nvidia/platform/loki/t210/nvaudio_conf_foster.xml:system/etc/nvaudio_conf.xml \
    device/nvidia/platform/loki/t210/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf

PRODUCT_COPY_FILES += \
    device/nvidia/tegraflash/t210/bmp.blob:bmp.blob

PRODUCT_COPY_FILES += device/nvidia/tegraflash/t210/rp2_binaries/rp2_disable_frp.bin:rp2.bin

# Genesys IO board with USB hub firmware bin for foster
LOCAL_FOSTER_GENESYS_FW_PATH=vendor/nvidia/foster/firmware/P1963-Genesys
PRODUCT_COPY_FILES += \
    $(call add-to-product-copy-files-if-exists, $(LOCAL_FOSTER_GENESYS_FW_PATH)/GL3521-latest.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/GL3521_foster.bin) \
    $(call add-to-product-copy-files-if-exists, $(LOCAL_FOSTER_GENESYS_FW_PATH)/GL_latest.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/GL_SS_HUB_ISP_foster.ini) \
    $(call add-to-product-copy-files-if-exists, vendor/nvidia/loki/utils/genesysload/geupdate.sh:$(TARGET_COPY_OUT_VENDOR)/bin/geupdate.sh)

PRODUCT_PACKAGES += \
    libtegra_sata_hal \
    rp3_image \
    genesys_hub_update \
    sil_load

TARGET_SYSTEM_PROP    += device/nvidia/platform/loki/t210/system.prop

HDCP_POLICY_CHECK := true

# FW check
LOCAL_FW_CHECK_TOOL_PATH=device/nvidia/common/fwcheck
LOCAL_FW_XML_PATH=vendor/nvidia/loki/skus
PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists, $(LOCAL_FW_XML_PATH)/fw_version.xml:$(TARGET_COPY_OUT_VENDOR)/etc/fw_version.xml) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_FW_CHECK_TOOL_PATH)/fw_check.py:fw_check.py)

PRODUCT_COPY_FILES += \
    device/nvidia/platform/loki/gpio_ir_recv.idc:system/usr/idc/gpio_ir_recv.idc \
    device/nvidia/platform/loki/Vendor_0955_Product_7210.idc:system/usr/idc/Vendor_0955_Product_7210.idc \
    device/nvidia/platform/loki/Vendor_0955_Product_7212.idc:system/usr/idc/Vendor_0955_Product_7212.idc

# Foster LED Firmware bin
LOCAL_FOSTER_LED_FW_PATH=vendor/nvidia/foster/firmware/P1961-Cypress/ReleasedHexFiles/Application
PRODUCT_COPY_FILES += \
    $(call add-to-product-copy-files-if-exists, $(LOCAL_FOSTER_LED_FW_PATH)/cypress_latest.cyacd:$(TARGET_COPY_OUT_VENDOR)/firmware/psoc_foster_fw.cyacd)

PRODUCT_COPY_FILES += device/nvidia/platform/loki/t210/factoryconfig.sh:/system/bin/factoryconfig.sh

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hdmi.wake_on_hotplug = 0

# Wi-Fi country code system properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.factory.wifi=/factory/wifi_config \
    ro.factory.wifi.lbs=false

# Define Netflix nrdp properties
PRODUCT_COPY_FILES += device/nvidia/platform/loki/t210/nrdp.modelgroup.xml:system/etc/permissions/nrdp.modelgroup.xml

PRODUCT_PROPERTY_OVERRIDES += \
        ro.nrdp.modelgroup=SHIELDANDROIDTV

PRODUCT_PROPERTY_OVERRIDES += \
        ro.nrdp.audio.otfs=true

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
    endif
  endif
endif
