# TWRP Device Tree for Samsung Galaxy S5 Active NTT Docomo (SC-02G / kltedcmactive)

This repository provides the TWRP (Team Win Recovery Project) device configuration for building TWRP 3.x for the **Samsung Galaxy S5 Active (NTT Docomo / SC-02G / kltedcmactive)**.

## Device Specifications

| Feature | Specification |
| :--- | :--- |
| Chipset | Qualcomm Snapdragon 801 (MSM8974PRO-AC) |
| CPU | Quad-core 2.5 GHz Krait 400 |
| GPU | Adreno 330 |
| Memory | 2 GB RAM |
| Storage | 16 GB eMMC |
| Battery | 2800 mAh Li-ion (removable) |
| Display | 1080 x 1920 pixels, 5.1 inches Super AMOLED |
| Carrier | NTT Docomo (Japan) |

---

## Partition Table (KACTIVE_JPN_DCM.pit)

| Partition | Block Device | Size | Filesystem |
| :--- | :--- | :--- | :--- |
| BOOT | `/dev/block/platform/msm_sdcc.1/by-name/boot` | 13 MiB (`13631488` B) | EMMC |
| RECOVERY | `/dev/block/platform/msm_sdcc.1/by-name/recovery` | 15 MiB (`15728640` B) | EMMC |
| SYSTEM | `/dev/block/platform/msm_sdcc.1/by-name/system` | 2.42 GiB (`2548039680` B) | EXT4 |
| USERDATA | `/dev/block/platform/msm_sdcc.1/by-name/userdata` | 11.58 GiB (`12442369024` B) | EXT4 |
| CACHE | `/dev/block/platform/msm_sdcc.1/by-name/cache` | 500 MiB (`524288000` B) | EXT4 |
| EFS | `/dev/block/platform/msm_sdcc.1/by-name/efs` | 14 MiB | EXT4 |
| MODEM | `/dev/block/platform/msm_sdcc.1/by-name/modem` | 64 MiB | VFAT |

---

## How to Build TWRP 3.x

### 1. Initialize Minimal TWRP Manifest (Android 8.1 / twrp-8.1)

```bash
mkdir ~/twrp-8.1
cd ~/twrp-8.1
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-8.1
repo sync -c -j$(nproc --all) --no-tags --no-clone-bundle
```

### 2. Clone Device Tree & Kernel

Clone this device tree into `device/samsung/kltedcmactive`:

```bash
git clone https://github.com/manat414-dev-jp/android_device_samsung_kltedcmactive-twrp.git -b twrp-8.1 device/samsung/kltedcmactive
```

Clone the LineageOS 15.1 kernel source into `kernel/samsung/msm8974`:

```bash
git clone --depth 1 -b lineage-15.1 https://github.com/LineageOS/android_kernel_samsung_msm8974.git kernel/samsung/msm8974
```

### 3. Build TWRP Recovery

```bash
source build/envsetup.sh
lunch omni_kltedcmactive-eng
mka recoveryimage -j$(nproc --all)
```

The output files will be created in `out/target/product/kltedcmactive/`:
- `recovery.img` - Flashable via existing TWRP/Flashify/DD
- `recovery.tar` - Flashable directly via Odin / Heimdall in Download Mode (with `SEANDROIDENFORCE` magic appended)

---

## Credits
- TeamWin Recovery Project (TWRP)
- LineageOS Project
- CyanogenMod Project
