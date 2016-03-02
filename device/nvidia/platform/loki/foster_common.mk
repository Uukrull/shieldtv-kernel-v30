# NVIDIA Tegra4 "foster" development system
#
# Copyright (c) 2013-2015 NVIDIA Corporation.  All rights reserved.
#

PRODUCT_LOCALES := en_US in_ID ca_ES cs_CZ da_DK de_DE en_GB es_ES es_US tl_PH fr_FR hr_HR it_IT lv_LV lt_LT hu_HU nl_NL nb_NO pl_PL pt_BR pt_PT ro_RO sk_SK sl_SI fi_FI sv_SE vi_VN tr_TR el_GR bg_BG ru_RU sr_RS uk_UA iw_IL ar_EG fa_IR th_TH ko_KR zh_CN zh_TW ja_JP

PRODUCT_PROPERTY_OVERRIDES += ro.radio.noril=true

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlays/wifi

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlays/common

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=320

# Additional AOSP packages not included in Android TV
PRODUCT_PACKAGES += \
    DocumentsUI \
    cyload \
    CaptivePortalLogin

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/Vendor_0955_Product_7205.kl:system/usr/keylayout/Vendor_0955_Product_7205.kl \
  $(LOCAL_PATH)/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
  device/nvidia/platform/t210/ussrd.foster.conf:system/etc/ussrd.conf \
  $(call add-to-product-copy-files-if-exists, vendor/nvidia/loki/utils/cyload/cyupdate.sh:$(TARGET_COPY_OUT_VENDOR)/bin/cyupdate.sh)

FOSTER_PREBUILT_BOOTLOADER_PATH := vendor/nvidia/tegra/bootloader/prebuilt/t210/signed/Loki/prod

ifneq ($(wildcard $(FOSTER_PREBUILT_BOOTLOADER_PATH)*),)
PRODUCT_COPY_FILES += \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e/cboot.bin.signed:cboot.bin.signed \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e/nvtboot.bin.signed:nvtboot.bin.signed \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e/nvtboot_cpu.bin.signed:nvtboot_cpu.bin.signed \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e/tos.img.signed:tos.img.signed \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e/warmboot.bin.signed:warmboot.bin.signed \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e/flash_t210_android_sdmmc_fb.xml:flash_t210_android_sdmmc_fb.xml.signed \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e/bct_p2530_e01.bct:bct_p2530_e01.bct \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e_hdd/flash_t210_android_sata_fb.xml:flash_t210_android_sata_fb.xml.signed \
    $(FOSTER_PREBUILT_BOOTLOADER_PATH)/foster_e_hdd/bct_p2530_sata_e01.bct:bct_p2530_sata_e01.bct
endif

PRODUCT_AAPT_CONFIG += xlarge large

## Common packages
$(call inherit-product-if-exists, vendor/nvidia/tegra/core/android/services/analyzer.mk)
