# Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This lists the SE Linux policies necessary to build a device and touch
# init.rc using Raydium touch

# Raydium touch policies
ifeq ($(wildcard external/sepolicy/gatekeeperd.te),)
# SELinux policy for Android L
BOARD_SEPOLICY_DIRS += device/nvidia/drivers/touchscreen/raydium/sepolicy/
BOARD_SEPOLICY_UNION += \
	file.te \
	file_contexts \
	mediaserver.te \
	raydium.te \
	service.te \
	service_contexts \
	surfaceflinger.te \
	system_app.te \
	ueventd.te \

else
# SELinux policy for Android M
BOARD_SEPOLICY_DIRS += device/nvidia/drivers/touchscreen/raydium/sepolicy_m/
endif

# create touch init.rc according touchvendor id from bootloader/nct
PRODUCT_COPY_FILES += \
    device/nvidia/common/init.ray_touch.rc:root/init.touch.0.rc
