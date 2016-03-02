# NVIDIA Tegra development system
#
# Copyright (c) 2013-2015 NVIDIA Corporation.  All rights reserved.
#
# Common 32/64-bit userspace options

include frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk
include $(LOCAL_PATH)/../../drivers/comms/comms.mk
include $(TEGRA_TOP)/core/android/services/utils.mk
-include $(TEGRA_TOP)/bct/t210/bct.mk
include $(LOCAL_PATH)/comms/Android.mk

PRODUCT_AAPT_CONFIG += mdpi hdpi xhdpi

DEVICE_ROOT := device/nvidia

NVFLASH_FILES_PATH := $(DEVICE_ROOT)/tegraflash/t210

PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/eks_nokey.dat:eks.dat \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sdmmc.xml:flash_t210_android_sdmmc.xml \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sata.xml:flash_t210_android_sata.xml \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sdmmc_fb.xml:flash_t210_android_sdmmc_fb.xml \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sata_fb.xml:flash_t210_android_sata_fb.xml \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sdmmc_diag.xml:flash_t210_android_sdmmc_diag.xml \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sata_diag.xml:flash_t210_android_sata_diag.xml \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sdmmc_fb_diag.xml:flash_t210_android_sdmmc_fb_diag.xml \
    $(NVFLASH_FILES_PATH)/flash_t210_android_sata_fb_diag.xml:flash_t210_android_sata_fb_diag.xml \
    $(call add-to-product-copy-files-if-exists, device/nvidia/tegraflash/t210/rp4_binaries/rp4.bin:rp4.bin)

NVFLASH_FILES_PATH :=

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# OPENGL AEP permission file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_COPY_FILES += \
    $(call add-to-product-copy-files-if-exists,frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml) \
    $(call add-to-product-copy-files-if-exists, $(LOCAL_PATH)/js_firmware.bin:system/etc/firmware/js_firmware.bin) \
    $(call add-to-product-copy-files-if-exists, $(LOCAL_PATH)/ct_firmware.bin:system/etc/firmware/ct_firmware.bin)

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.e2190.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.e2220.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.jetson_e.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.jetson_cv.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.t18x-interposer.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.loki_e_lte.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.loki_e_wifi.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.loki_e_base.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.foster_e.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.foster_e_hdd.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.darcy.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.hawkeye.rc \
  $(LOCAL_PATH)/ueventd.t210ref.rc:root/ueventd.he2290.rc \
  $(LOCAL_PATH)/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
  device/nvidia/platform/loki/Vendor_0955_Product_7205.kl:system/usr/keylayout/Vendor_0955_Product_7205.kl \
  device/nvidia/platform/loki/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7210.kl \
  $(LOCAL_PATH)/../../common/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
  $(LOCAL_PATH)/raydium_ts.idc:system/usr/idc/touch.idc \
  $(LOCAL_PATH)/sensor00fn11.idc:system/usr/idc/sensor00fn11.idc \
  $(LOCAL_PATH)/../../common/ussr_setup.sh:system/bin/ussr_setup.sh \
  $(LOCAL_PATH)/../../common/set_hwui_params.sh:system/bin/set_hwui_params.sh \
  $(LOCAL_PATH)/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
  $(LOCAL_PATH)/update_js_touch_fw.sh:system/bin/update_js_touch_fw.sh

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
ifeq ($(BOARD_REMOVES_RESTRICTED_CODEC),true)
PRODUCT_COPY_FILES += \
  frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
  frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
  $(LOCAL_PATH)/media_codecs_no_licence.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
else
PRODUCT_COPY_FILES += \
  frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
  frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
  $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
endif
else
PRODUCT_COPY_FILES += \
  frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
  frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
  $(LOCAL_PATH)/media_codecs_noenhance.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.e2190.rc:root/init.e2190.rc \
    $(LOCAL_PATH)/init.e2220.rc:root/init.e2220.rc \
    $(LOCAL_PATH)/init.jetson_e.rc:root/init.jetson_e.rc \
    $(LOCAL_PATH)/init.jetson_cv.rc:root/init.jetson_cv.rc \
    $(LOCAL_PATH)/init.t18x-interposer.rc:root/init.t18x-interposer.rc \
    $(LOCAL_PATH)/init.t210.rc:root/init.t210.rc \
    $(LOCAL_PATH)/init.dualwifi.rc:root/init.dualwifi.rc \
    $(LOCAL_PATH)/init.loki_e_lte.rc:root/init.loki_e_lte.rc \
    $(LOCAL_PATH)/init.loki_e_wifi.rc:root/init.loki_e_wifi.rc \
    $(LOCAL_PATH)/init.loki_e_base.rc:root/init.loki_e_base.rc \
    $(LOCAL_PATH)/init.foster_e.rc:root/init.foster_e.rc \
    $(LOCAL_PATH)/init.foster_e_hdd.rc:root/init.foster_e_hdd.rc \
    $(LOCAL_PATH)/init.hawkeye.rc:root/init.hawkeye.rc \
    $(LOCAL_PATH)/init.he2290.rc:root/init.he2290.rc \
    $(LOCAL_PATH)/init.he2290.usb.rc:root/init.he2290.usb.rc \
    $(LOCAL_PATH)/init.loki_e_common.rc:root/init.loki_e_common.rc \
    $(LOCAL_PATH)/init.foster_e_common.rc:root/init.foster_e_common.rc \
    $(LOCAL_PATH)/init.loki_foster_e_common.rc:root/init.loki_foster_e_common.rc \
    $(LOCAL_PATH)/init.darcy.rc:root/init.darcy.rc \
    $(DEVICE_ROOT)/common/init.none.rc:root/init.none.rc \
    $(DEVICE_ROOT)/common/init.tegra_emmc.rc:root/init.tegra_emmc.rc \
    $(DEVICE_ROOT)/common/init.ray_touch.rc:root/init.ray_touch.rc \
    $(DEVICE_ROOT)/common/init.tegra_sata.rc:root/init.tegra_sata.rc \
    $(DEVICE_ROOT)/soc/t210/init.t210_common.rc:root/init.t210_common.rc \
    $(DEVICE_ROOT)/soc/t210/init.t18x-interposer_common.rc:root/init.t18x-interposer_common.rc \
    $(DEVICE_ROOT)/common/init.ussrd.rc:root/init.ussrd.rc \
    $(DEVICE_ROOT)/common/init.nv_dev_board.usb.rc:root/init.nv_dev_board.usb.rc \
    $(DEVICE_ROOT)/common/init.tlk.rc:root/init.tlk.rc \
    $(DEVICE_ROOT)/common/init.hdcp.rc:root/init.hdcp.rc

ifeq ($(PLATFORM_IS_NEXT),1)
PRODUCT_COPY_FILES += \
    $(DEVICE_ROOT)/common/init.tegra_m.rc:root/init.tegra.rc \
    $(LOCAL_PATH)/fstab_m.t210ref:root/fstab.e2190 \
    $(LOCAL_PATH)/fstab_m.t210ref:root/fstab.e2220 \
    $(LOCAL_PATH)/fstab_m.t210ref:root/fstab.jetson_e \
    $(LOCAL_PATH)/fstab_m.t210ref:root/fstab.jetson_cv \
    $(LOCAL_PATH)/fstab_m.t210ref:root/fstab.t18x-interposer \
    $(LOCAL_PATH)/fstab_m.loki_e:root/fstab.loki_e_lte \
    $(LOCAL_PATH)/fstab_m.loki_e:root/fstab.loki_e_base \
    $(LOCAL_PATH)/fstab_m.loki_e:root/fstab.loki_e_wifi \
    $(LOCAL_PATH)/fstab_m.foster_e:root/fstab.foster_e \
    $(LOCAL_PATH)/fstab_m.foster_e_hdd:root/fstab.foster_e_hdd \
    $(LOCAL_PATH)/fstab_m.darcy:root/fstab.darcy \
    $(LOCAL_PATH)/fstab_m.hawkeye:root/fstab.hawkeye
ifneq ($(filter user%,$(TARGET_BUILD_VARIANT)),)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_m.he2290_encrypt:root/fstab.he2290
else
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab_m.he2290:root/fstab.he2290
endif
else
PRODUCT_COPY_FILES += \
    $(DEVICE_ROOT)/common/init.tegra.rc:root/init.tegra.rc \
    $(LOCAL_PATH)/fstab.t210ref:root/fstab.e2190 \
    $(LOCAL_PATH)/fstab.t210ref:root/fstab.e2220 \
    $(LOCAL_PATH)/fstab.t210ref:root/fstab.jetson_e \
    $(LOCAL_PATH)/fstab.t210ref:root/fstab.jetson_cv \
    $(LOCAL_PATH)/fstab.t210ref:root/fstab.t18x-interposer \
    $(LOCAL_PATH)/fstab.loki_e:root/fstab.loki_e_lte \
    $(LOCAL_PATH)/fstab.loki_e:root/fstab.loki_e_base \
    $(LOCAL_PATH)/fstab.loki_e:root/fstab.loki_e_wifi \
    $(LOCAL_PATH)/fstab.foster_e:root/fstab.foster_e \
    $(LOCAL_PATH)/fstab.foster_e_hdd:root/fstab.foster_e_hdd \
    $(LOCAL_PATH)/fstab.hawkeye:root/fstab.hawkeye \
    $(LOCAL_PATH)/fstab.he2290:root/fstab.he2290
endif

DEVICE_ROOT :=

# System power mode configuration file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power.loki_e_common.rc:system/etc/power.loki_e_lte.rc \
    $(LOCAL_PATH)/power.loki_e_common.rc:system/etc/power.loki_e_wifi.rc \
    $(LOCAL_PATH)/power.loki_e_common.rc:system/etc/power.loki_e_base.rc \
    $(LOCAL_PATH)/power.foster_e_common.rc:system/etc/power.foster_e.rc \
    $(LOCAL_PATH)/power.foster_e_common.rc:system/etc/power.foster_e_hdd.rc \
    $(LOCAL_PATH)/power.foster_e_common.rc:system/etc/power.darcy.rc \
    $(LOCAL_PATH)/power.he2290.rc:system/etc/power.he2290.rc \
    $(LOCAL_PATH)/power.jetson_e.rc:system/etc/power.jetson_e.rc \
    $(LOCAL_PATH)/power.jetson_e.rc:system/etc/power.jetson_cv.rc \
    $(LOCAL_PATH)/power.jetson_e.rc:system/etc/power.t18x-interposer.rc

# Face detection model
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/core/include/ft/model_frontalface.xml:system/etc/model_frontal.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../../common/cluster:system/bin/cluster \
    $(LOCAL_PATH)/../../common/cluster_get.sh:system/bin/cluster_get.sh \
    $(LOCAL_PATH)/../../common/cluster_set.sh:system/bin/cluster_set.sh \
    $(LOCAL_PATH)/../../common/dcc:system/bin/dcc \
    $(LOCAL_PATH)/../../common/hotplug:system/bin/hotplug \
    $(LOCAL_PATH)/../../common/mount_debugfs.sh:system/bin/mount_debugfs.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/enctune.conf:system/etc/enctune.conf

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    BCMBINARIES_PATH := vendor/nvidia/tegra/3rdparty/bcmbinaries
else
    BCMBINARIES_PATH := vendor/nvidia/tegra/prebuilt/t210/3rdparty/bcmbinaries
endif

PRODUCT_COPY_FILES += \
   $(BCMBINARIES_PATH)/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd \
   $(BCMBINARIES_PATH)/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm43241/fw_bcmdhd.bin \
   $(BCMBINARIES_PATH)/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
   $(BCMBINARIES_PATH)/bcm43341/bluetooth/BCM43341A0_001.001.030.0015.0000_Generic_UART_37_4MHz_wlbga_iTR_Pluto_Evaluation_for_NVidia.hcd:system/etc/firmware/BCM43341A0_001.001.030.0015.0000.hcd \
   $(BCMBINARIES_PATH)/bcm43341/bluetooth/BCM43341B0_002.001.014.0008.0011.hcd:system/etc/firmware/BCM43341B0_002.001.014.0008.0011.hcd \
   $(BCMBINARIES_PATH)/bcm43341/wlan/sdio-ag-pno-pktfilter-keepalive-aoe-idsup-idauth-wme.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm43341/fw_bcmdhd.bin \
   $(BCMBINARIES_PATH)/bcm43341/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-sr-wapi-wl11d.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm43341/fw_bcmdhd_a0.bin \
   $(BCMBINARIES_PATH)/bcm43341/wlan/bcm943341wbfgn_2_hwoob.txt:system/etc/nvram_rev2.txt \
   $(BCMBINARIES_PATH)/bcm43341/wlan/nvram_43341_rev3.txt:system/etc/nvram_rev3.txt \
   $(BCMBINARIES_PATH)/bcm43341/wlan/bcm943341wbfgn_4_hwoob.txt:system/etc/nvram_rev4.txt \
   $(BCMBINARIES_PATH)/bcm4335/bluetooth/BCM4335B0_002.001.006.0037.0046_ORC.hcd:system/etc/firmware/bcm4335.hcd \
   $(BCMBINARIES_PATH)/bcm4335/wlan/bcm94335wbfgn3_r04_hwoob.txt:system/etc/nvram_4335.txt \
   $(BCMBINARIES_PATH)/bcm4335/wlan/sdio-ag-pool-p2p-pno-pktfilter-keepalive-aoe-ccx-sr-vsdb-proptxstatus-lpc-wl11u-autoabn.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm4335/fw_bcmdhd.bin \
   $(BCMBINARIES_PATH)/bcm4350/wlan/bcm94350wlagbe_KA_hwoob.txt:system/etc/nvram_4350.txt \
   $(BCMBINARIES_PATH)/bcm4350/wlan/sdio-ag-p2p-pno-aoe-pktfilter-keepalive-sr-mchan-proptxstatus-ampduhostreorder-lpc-wl11u-txbf-pktctx-dmatxrc.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm4350/fw_bcmdhd.bin \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_4354.txt:system/etc/nvram_4354.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_loki_e_4354.txt:system/etc/nvram_loki_e_4354.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_foster_e_4354.txt:system/etc/nvram_foster_e_4354.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_darcy_a00.txt:system/etc/nvram_darcy_a00.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_loki_e_antenna_tuned_4354.txt:system/etc/nvram_loki_e_antenna_tuned_4354.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_foster_e_antenna_tuned_4354.txt:system/etc/nvram_foster_e_antenna_tuned_4354.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_hawkeye_4354.txt:system/etc/nvram_hawkeye_4354.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/nvram_jetsonE_cv_4354.txt:system/etc/nvram_jetsonE_cv_4354.txt \
   $(BCMBINARIES_PATH)/bcm4354a1/wlan/sdio-ag-p2p-pno-aoe-pktfilter-keepalive-sr-mchan-proptxstatus-ampduhostreorder-lpc-wl11u-txbf-pktctx-okc-tdls-ccx-ve-mfp-ltecxgpio.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm4354/fw_bcmdhd.bin \
   $(BCMBINARIES_PATH)/bcm4354/bluetooth/BCM4354_003.001.012.0163.0000_Nvidia_NV54_TEST_ONLY.hcd:system/etc/firmware/bcm4350.hcd \
   $(BCMBINARIES_PATH)/bcm4359-b0/bluetooth/BCM4349B0_002.001.014.0019.0059.hcd:system/etc/firmware/BCM4349B0.hcd \
   $(BCMBINARIES_PATH)/bcm4359-b0/wlan/fw_bcmdhd.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm4359_b0/fw_bcmdhd.bin \
   $(BCMBINARIES_PATH)/bcm4359-b0/wlan/bcm89359nvram_150410.txt:system/etc/nvram_4359_b0.txt \
   $(BCMBINARIES_PATH)/bcm4359-b1/bluetooth/BCM4349B1.hcd:system/etc/firmware/BCM4349B1.hcd \
   $(BCMBINARIES_PATH)/bcm4359-b1/wlan/bcm4359_b1_fcbga_FW.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm4359_b1/fw_bcmdhd.bin \
   $(BCMBINARIES_PATH)/bcm4359-b1/wlan/bcm94359fcpagbss_from_hw.txt:system/etc/nvram_4359_b1.txt \
   $(BCMBINARIES_PATH)/bcm4356/wlan/nvram.txt:system/etc/nvram_4356.txt \
   $(BCMBINARIES_PATH)/bcm4356/wlan/fw_bcmdhd_56.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/bcm4356/fw_bcmdhd.bin

BCMBINARIES_PATH :=

PRODUCT_COPY_FILES += \
    $(call add-to-product-copy-files-if-exists, vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752_next_64/glgps_nvidiategraandroid:system/bin/glgps_nvidiaTegra2android) \
    $(call add-to-product-copy-files-if-exists, vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752_next_64/gps.nvidiategraandroid.so:system/lib64/hw/gps.brcm.so)

# Nvidia Miracast
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../../common/miracast/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml

# NvBlit JNI library
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/graphics-partner/android/frameworks/Graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml

ifneq ($(filter foster_e%,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists, vendor/nvidia/tegra/tnspec_data/t210/tnspec_foster.json:tnspec.json)
else
PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists, vendor/nvidia/tegra/tnspec_data/t210/tnspec.json:tnspec.json)
endif

# Prefer framerate over resolution
PRODUCT_PROPERTY_OVERRIDES += \
    persist.tegra.hdmi.resolution = Max_60Hz

# OTA version definition.  Depends on environment variable NV_OTA_VERSION
# being set prior to building.
ifneq ($(NV_OTA_VERSION),)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.build.version.ota = $(NV_OTA_VERSION)
endif
