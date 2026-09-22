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

LOCAL_PATH := device/samsung/kltedcmactive

TARGET_OTA_ASSERT_DEVICE := SC-02G,kltedcmactive,klteactive,klte
TARGET_BOOTLOADER_BOARD_NAME := MSM8974
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# Flags
COMMON_GLOBAL_CFLAGS += -DREFRESH_RATE=60 -DQCOM_HARDWARE -DNO_SECURE_DISCARD

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := console=null androidboot.hardware=qcom androidboot.bootdevice=msm_sdcc.1 user_debug=31 msm_rtb.filter=0x3F
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x01e00000
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/bootimg.mk

# Kernel source / configuration
TARGET_KERNEL_SOURCE := kernel/samsung/msm8974
TARGET_KERNEL_CONFIG := lineage_klteactivexx_defconfig

# NTT Docomo SC-02G 16GB PIT (KACTIVE_JPN_DCM.pit) Partition Sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 13631488
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 15728640
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2548039680
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12442369024 # 12442385408 - 16384
BOARD_CACHEIMAGE_PARTITION_SIZE := 524288000
BOARD_FLASH_BLOCK_SIZE := 131072

# Filesystem
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SUPPRESS_SECURE_ERASE := true

# TWRP Recovery Settings
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/msm_dwc3/f9200000.dwc3/gadget/lun%d/file"

# TWRP Display & Theme (1080x1920)
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/devices/mdp.0/qcom\x2cmdss_fb_primary.191/leds/lcd-backlight/brightness"
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone1/temp"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 162

# TWRP Feature Flags
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_MTP_DEVICE := "/dev/mtp_usb"
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_NO_EXFAT_FUSE := false
TW_INCLUDE_NTFS_3G := true
TW_EXCLUDE_SUPERSU := true

# Encryption support (Qualcomm HW disk encryption & Keymaster)
TW_INCLUDE_CRYPTO := true
TARGET_HW_DISK_ENCRYPTION := true
TARGET_KEYMASTER_WAIT_FOR_QSEE := true

# Init properties from bootloader
TARGET_INIT_VENDOR_LIB := libinit_kltedcmactive
TARGET_RECOVERY_DEVICE_MODULES := libinit_kltedcmactive
TARGET_LIBINIT_DEFINES_FILE := $(LOCAL_PATH)/init/init_klte.cpp
