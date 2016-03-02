/*
 * Copyright (C) 2011 The Android Open Source Project
 * Copyright (c) 2015 NVIDIA Corporation.  All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <linux/input.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <cutils/properties.h>

#include <fs_mgr.h>
#include "roots.h"
#include "common.h"
#include "device.h"
#include "screen_ui.h"
#include "ui.h"
#include "make_ext4fs.h"
extern "C" {
#include "wipe.h"
}

const char* HEADERS[] = { "Volume up/down to move highlight;",
                          "enter/power button to select.",
                          "",
                          NULL };

const char* HEADERS_loki[] = { "Short press of Power button to move highlight;",
                               "Press Power button for 4-6s to select.",
                               "",
                               NULL };

static const char* ITEMS[] =  {"reboot system now",
                               "apply update from ADB",
                               "wipe data/factory reset",
                               "wipe cache partition",
                               "reboot to bootloader",
                               "power down",
                               NULL };

static const char* ITEMS_foster[] =  {"reboot system now",
                               "apply update from ADB",
                               "wipe data/factory reset",
                               "wipe cache partition",
                               "view recovery logs",
                               NULL };

#if (PLATFORM_IS_NEXT == 1)
class DefaultRecoveryUI : public ScreenRecoveryUI {
  public:
    DefaultRecoveryUI() :
        consecutive_power_keys(0) {
    }

    KeyAction CheckKey(int key, bool long_press) {
        if (IsKeyPressed(KEY_POWER) && key == KEY_VOLUMEUP) {
            return TOGGLE;
        }

        if (key == KEY_DISPLAYTOGGLE) {
            return TOGGLE;
        }

        if (key == KEY_POWER) {
            ++consecutive_power_keys;
            if (consecutive_power_keys >= 7) {
                return REBOOT;
            }
        } else {
            consecutive_power_keys = 0;
        }
        return ENQUEUE;
    }

  private:
    int consecutive_power_keys;
};
#endif

class DefaultDevice : public Device {
  public:
#if (PLATFORM_IS_NEXT != 1)
    DefaultDevice() :
        ui(new ScreenRecoveryUI) {
#else
    DefaultDevice(DefaultRecoveryUI *UI) :
        Device(UI), ui(UI) {
            property_get("ro.hardware", platform, "");
#endif
    }

#if (PLATFORM_IS_NEXT != 1)
    RecoveryUI* GetUI() { return ui; }

    int HandleMenuKey(int key, int visible) {
        if (visible) {
            switch (key) {
              case KEY_DOWN:
              case KEY_VOLUMEDOWN:
                return kHighlightDown;

              case KEY_UP:
              case KEY_VOLUMEUP:
                return kHighlightUp;

              case KEY_ENTER:
              case KEY_POWER:
                return kInvokeItem;
            }
        }

        return kNoAction;
    }

    BuiltinAction InvokeMenuItem(int menu_position) {
        switch (menu_position) {
          case 0: return REBOOT;
          case 1: return APPLY_ADB_SIDELOAD;
          case 2: return WIPE_DATA;
          case 3: return WIPE_CACHE;
          case 4: return REBOOT_BOOTLOADER;
          case 5: return SHUTDOWN;
          default: return NO_ACTION;
        }
    }

    int WipeData() {
        erase_usercalibration_partition();
        return 0;
    }

    const char* const* GetMenuHeaders() { return HEADERS; }
    const char* const* GetMenuItems() { return ITEMS; }

#else
    const char* const* GetMenuHeaders() {
        if (!strncmp(platform, "loki_e", 6) ||
            !strncmp(platform, "foster_e", 8)) {
            return HEADERS_loki;
        }
        return HEADERS;
    }

    const char* const* GetMenuItems() {
        if (!strncmp(platform, "foster_e", 8)) {
            return ITEMS_foster;
        }
        return Device::GetMenuItems();
    }

    BuiltinAction InvokeMenuItem(int menu_position) {
        switch (menu_position) {
          case 0: return REBOOT;
          case 1: return APPLY_ADB_SIDELOAD;
          case 2: return WIPE_DATA;
          case 3: return WIPE_CACHE;
          case 4: return VIEW_RECOVERY_LOGS;
          default: return NO_ACTION;
        }
    }

    bool PostWipeData() {
         if(erase_usercalibration_partition() == 0)
             return true;
         else
             return false;
    }
#endif

  private:
    int erase_usercalibration_partition() {
        const char* USERCALIB_PATH = "/usercalib";


        Volume *v = volume_for_path(USERCALIB_PATH);
        if (v == NULL) {
            // most devices won't have /usercalib, so this is not an error.
            return 0;
        }

        ui->SetBackground(RecoveryUI::ERASING);
        ui->SetProgressType(RecoveryUI::INDETERMINATE);
        ui->Print("Formatting %s...\n", USERCALIB_PATH);

        int fd = open(v->blk_device, O_RDWR);
        uint64_t size = get_file_size(fd);
        if (size != 0) {
            if (wipe_block_device(fd, size)) {
                LOGE("error wiping /usercalib: %s\n", strerror(errno));
                close(fd);
                return -1;
            }
        }

        close(fd);

        return 0;
    }

  private:
#if (PLATFORM_IS_NEXT != 1)
    RecoveryUI* ui;
#else
    DefaultRecoveryUI* ui;
    char platform[PROPERTY_VALUE_MAX+1];
#endif
};

Device* make_device() {
#if (PLATFORM_IS_NEXT != 1)
    return new DefaultDevice();
#else
    return new DefaultDevice(new DefaultRecoveryUI);
#endif
}

