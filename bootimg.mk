#
# Copyright (C) 2014-2016 The CyanogenMod Project
# Copyright (C) 2017-2018 The LineageOS Project
# Copyright (C) 2018-2024 The TeamWin Recovery Project
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

LOCAL_PATH := $(call my-dir)

FLASH_IMAGE_TARGET ?= $(PRODUCT_OUT)/recovery.tar

ifdef TARGET_PREBUILT_DTB
	BOARD_MKBOOTIMG_ARGS += --dt $(TARGET_PREBUILT_DTB)
endif

$(recovery_ramdisk): $(recovery_uncompressed_ramdisk) $(MKBOOTFS)
	@echo -e ${CL_GRN}"----- Slimming down recovery root for 15MB partition ------"${CL_RST}
	$(hide) rm -f $(TARGET_RECOVERY_ROOT_OUT)/sbin/charger \
		$(TARGET_RECOVERY_ROOT_OUT)/sbin/*f2fs* \
		$(TARGET_RECOVERY_ROOT_OUT)/sbin/sgdisk \
		$(TARGET_RECOVERY_ROOT_OUT)/sbin/avbctl \
		$(TARGET_RECOVERY_ROOT_OUT)/sbin/android.* \
		$(TARGET_RECOVERY_ROOT_OUT)/sbin/libhidl* \
		$(TARGET_RECOVERY_ROOT_OUT)/sbin/libvintf* \
		$(TARGET_RECOVERY_ROOT_OUT)/sbin/libhwbinder*
	$(hide) find $(TARGET_RECOVERY_ROOT_OUT)/twres/languages -name '*.xml' ! -name 'en.xml' ! -name 'ja.xml' -delete 2>/dev/null || true
	@echo -e ${CL_GRN}"----- Compressing recovery ramdisk (gzip) ------"${CL_RST}
	$(hide) $(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) | gzip -9c > $@

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(TARGET_PREBUILT_DTB) $(recovery_kernel) $(recovery_ramdisk)
	@echo -e ${CL_GRN}"----- Making recovery image ------"${CL_RST}
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@ --ramdisk $(recovery_ramdisk)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
	@echo -e ${CL_GRN}"----- Adding SEAndroid signature for Samsung bootloader ------"${CL_RST}
	$(hide) echo -n "SEANDROIDENFORCE" >> $(INSTALLED_RECOVERYIMAGE_TARGET)
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	$(hide) tar -C $(PRODUCT_OUT) -H ustar -c recovery.img > $(FLASH_IMAGE_TARGET)
	@echo -e ${CL_CYN}"Made Odin flashable recovery tar: ${FLASH_IMAGE_TARGET}"${CL_RST}
