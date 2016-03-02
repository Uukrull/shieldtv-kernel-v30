#
# GPS symlink creator
#

SYMLINKS := $(TARGET_OUT)/etc/permissions/android.hardware.location.gps.xml
$(SYMLINKS): GPS_SYMLINK := /data/android.hardware.location.gps.xml
$(SYMLINKS): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(GPS_SYMLINK)"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf $(GPS_SYMLINK) $@
ALL_DEFAULT_INSTALLED_MODULES += $(SYMLINKS)

