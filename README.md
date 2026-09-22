# TWRP Device Tree for Samsung Galaxy S5 Active (Docomo SC-02G / kltedcmactive)

## Specifications
- **Device**: Samsung Galaxy S5 Active (NTT Docomo)
- **Model**: SC-02G
- **Codename**: kltedcmactive / klteactive / klte
- **SoC**: Qualcomm Snapdragon 801 (MSM8974PRO-AC)
- **Chipset ID**: `0xC2085101`, Platform: `2` (Board Rev 0.2)
- **Screen**: 1080x1920
- **Recovery Partition Size**: 15,728,640 bytes (15.00 MB)

---

## How to Build TWRP 3.x (Android 8.1)

### 1. Initialize Minimal TWRP 8.1 Manifest
```bash
mkdir twrp-8.1 && cd twrp-8.1
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-8.1 --depth=1
repo sync -c -j$(nproc) --no-clone-bundle --no-tags
```

### 2. Clone Device Tree
```bash
git clone https://github.com/manat414-dev-jp/android_device_samsung_kltedcmactive-twrp.git device/samsung/kltedcmactive -b twrp-8.1
```

### 3. Build Recovery Image & Odin Tar
```bash
source build/envsetup.sh
lunch omni_kltedcmactive-eng
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
mka recoveryimage -j$(nproc)
```

### 4. Output
- `out/target/product/kltedcmactive/recovery.img` (~11.7 MB)
- `out/target/product/kltedcmactive/recovery.tar` (Odin flashable)
