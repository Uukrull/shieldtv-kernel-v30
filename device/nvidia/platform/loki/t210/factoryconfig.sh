#!/system/bin/sh

# Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

COUNTRY_CODE_FILE_PATH=$(getprop factory.wifi_country_code)
SKU_FILE_PATH=$(getprop factory.sku_config)

cp ${COUNTRY_CODE_FILE_PATH}.sig /factory/wifi_config/country_code.sig
cp ${COUNTRY_CODE_FILE_PATH}.txt /factory/wifi_config/country_code.txt
cp ${SKU_FILE_PATH}.txt /factory/wifi_config/FSS.txt
chown system:system /factory/wifi_config/country_code.sig
chown system:system /factory/wifi_config/country_code.txt
chown system:system /factory/wifi_config/FSS.txt
chmod 664 /factory/wifi_config/country_code.sig
chmod 664 /factory/wifi_config/country_code.txt
chmod 664 /factory/wifi_config/FSS.txt
setprop factory.sku_config "done"
