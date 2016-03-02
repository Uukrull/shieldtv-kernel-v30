#Copyright (c) 2015 NVIDIA Corporation.  All Rights Reserved.
#
#NVIDIA Corporation and its licensors retain all intellectual property and
#proprietary rights in and to this software and related documentation.  Any
#use, reproduction, disclosure or distribution of this software and related
#documentation without an express license agreement from NVIDIA Corporation
#is strictly prohibited.

#!/bin/bash

#
# Script to generate blob.
#
# This script is based on original signing script located,
# http://git-master/r/gitweb?p=tegra/git-tools.git;a=blob_plain;f=signing/configs/Loki/prod-loki/generic/common.conf;hb=HEAD
# and
# http://git-master/r/gitweb?p=tegra/git-tools.git;a=tree;f=signing/configs/Loki/prod-loki/loki_e_wifi;h=b4392b27233050b88819fdf3ed6121860938a0e5;hb=HEAD

if [ ! -d $TOP/vendor/nvidia/tegra/core-private ]; then
    echo "Generating nv-blob in customer build is not supported\n";
    exit
fi

# Set options.

set -e
set -u

# Set the input files to use.

BOARD_NAME=$TARGET_PRODUCT

# Multiple BCTs are not supported yet
# Add multiple DTBs seperated by comma
# For now, add all the relevant DTBs present in $OUT

CFG_FILE="flash_t210_android_sdmmc_fb.xml"
BCT_FILE="bct_p2530_e01.cfg"
case ${BOARD_NAME} in
    t210ref)
        DTB_FILE=$(ls -m $OUT/tegra210*jetson*.dtb $OUT/tegra210*ers*.dtb | awk -F '/' '{print $NF}')
        ;;
    hawkeye_na_do | hawkeye_na_wf | hawkeye_un_do | hawkeye_un_mo)
        BCT_FILE="bct_p2290_a00.cfg"
        DTB_FILE=$(ls -m $OUT/tegra210*hawkeye*.dtb | awk -F '/' '{print $NF}')
        ;;
    loki_e_wifi | loki_e_tab_os)
        DTB_FILE=$(ls -m $OUT/tegra210*loki*.dtb | awk -F '/' '{print $NF}')
        ;;
    foster_e)
        DTB_FILE=$(ls -m $OUT/tegra210*foster-e-*.dtb | awk -F '/' '{print $NF}')
        ;;
    foster_e_hdd)
        BCT_FILE="bct_p2530_sata_e01.cfg"
        CFG_FILE="flash_t210_android_sata_fb.xml"
        DTB_FILE=$(ls -m $OUT/tegra210*foster-e-hdd-*.dtb | awk -F '/' '{print $NF}')
        ;;
    *)
        echo "Unsupported board: ${BOARD_NAME}"
        echo "OTA Blob creation failed"
        exit 0
        ;;
esac

# Sign the bootloader.

cd ${OUT}
case ${BOARD_NAME} in
    t210ref | hawkeye_na_do | hawkeye_na_wf | hawkeye_un_do | hawkeye_un_mo | loki_e_wifi | loki_e_tab_os | foster_e | foster_e_hdd)
        echo ""
        echo "Generating fuse_bypass.bin..."
        CMD="$ANDROID_HOST_OUT/bin/tegraparser --fuseconfig fuse_bypass.xml \
            --sku acr-debug"
        echo ""
        echo $CMD
        echo ""
        eval $CMD
        echo ""
        echo "Generating signed .bin files..."
        echo ""
        CMD="$ANDROID_HOST_OUT/bin/tegraflash.py \
            --bct ${BCT_FILE} \
            --bl cboot.bin \
            --cfg ${CFG_FILE} \
            --odmdata 0x694000 \
            --applet nvtboot_recovery.bin \
            --chip 0x21 \
            --key none \
            --cmd \"sign\" \
            --fb fuse_bypass.bin "

        echo $CMD
        eval $CMD
        echo ""
        echo "Updating the blob..."
        CMD="$ANDROID_HOST_OUT/bin/nvblob_v2 \
            -t update \
            signed/nvtboot.bin.encrypt NVC 2 \
            signed/nvtboot.bin.encrypt NVC-B 2 \
            bpmp.bin BPF 2 \
            signed/nvtboot_cpu.bin.encrypt TBC 2 \
            signed/nvtboot_cpu.bin.encrypt TBC-B 2 \
            signed/cboot.bin.encrypt EBT 2 \
            signed/cboot.bin.encrypt RBL 2 \
            signed/warmboot_fb.bin.encrypt WB0 2 \
            signed/tos.img.encrypt TOS 2 \
            signed/${BCT_FILE/.cfg/.bct} BCT 2 "

        for i in $(echo $DTB_FILE | tr "," "\n")
        do
            CMD=${CMD}" $i DTB 2 "
            CMD=${CMD}" $i RP1 2 "
        done
        echo ""
        echo $CMD
        echo ""
        eval $CMD && mv ota.blob blob
        ;;
    *)
        echo "Unsupported board: ${BOARD_NAME}"
        echo "OTA Blob creation failed"
        exit 0
        ;;
esac

echo ""
echo "OTA Blob creation successful"
echo ""
