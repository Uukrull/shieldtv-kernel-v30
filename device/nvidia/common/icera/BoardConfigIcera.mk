# Copyright (c) 2014 NVIDIA Corporation.  All rights reserved.
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
#

# This lists the SE Linux policies necessary to build a device using
# Icera modem


# Icera modem policies - override default rild.te
ifeq ($(wildcard external/sepolicy/gatekeeperd.te),)
# SELinux policy for Android L
BOARD_SEPOLICY_DIRS += device/nvidia/common/icera/sepolicy/
BOARD_SEPOLICY_UNION += \
	config_modem.te \
	fild.te \
	file_contexts \
	file.te \
	icera-crashlogs.te \
	icera-feedback.te \
	icera-loader.te \
	icera-switcherd.te \
	init.te \
	mediaserver.te \
	mock_modem.te \
	modemnic.te \
	property_contexts \
	property.te \
	system_app.te \

BOARD_SEPOLICY_REPLACE += rild.te
else
# SELinux policy for Android M
BOARD_SEPOLICY_DIRS += device/nvidia/common/icera/sepolicy_m/
endif
