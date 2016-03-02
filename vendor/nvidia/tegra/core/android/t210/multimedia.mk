$(call inherit-product, $(LOCAL_PATH)/firmware.mk)
$(call inherit-product, $(LOCAL_PATH)/../multimedia/base.mk)
$(call inherit-product, $(LOCAL_PATH)/../multimedia/firmware.mk)
$(call inherit-product, $(LOCAL_PATH)/../multimedia/nvsi.mk)
$(call inherit-product, $(LOCAL_PATH)/../multimedia/widevine.mk)
$(call inherit-product, $(LOCAL_PATH)/../multimedia/playready.mk)
$(call inherit-product, $(LOCAL_PATH)/../multimedia/tests.mk)

## Add 64-bit MM libs
PRODUCT_PACKAGES += \
    libnvtvmr \
    libnvomx \
    libnvmmlite_video \
    libnvmm_parser
