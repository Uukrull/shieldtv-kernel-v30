# Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
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
# init.rc using Sharp touch

# Sharp touch policies

ifeq ($(wildcard external/sepolicy/gatekeeperd.te),)
# SELinux policy for Android L
BOARD_SEPOLICY_DIRS += device/nvidia/drivers/touchscreen/sharp/sepolicy/
BOARD_SEPOLICY_UNION += \
	dumpstate.te \
	file_contexts \
	file.te \
	property_contexts \
	sharp.te

else
# SELinux policy for Android M
BOARD_SEPOLICY_DIRS += device/nvidia/drivers/touchscreen/sharp/sepolicy_m/
endif

# PRODUCT_PROPERTY_OVERRIDES is not working from here.
ADDITIONAL_BUILD_PROPERTIES += persist.tch.tap2wake=2

# create touch init.rc according touchvendor id from bootloader/nct
PRODUCT_COPY_FILES += \
    device/nvidia/common/init.sharp_touch.rc:root/init.touch.2.rc
