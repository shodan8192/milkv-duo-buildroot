
## Milk-V Duo Introduction

Milk-V Duo is an ultra-compact embedded development platform based on the rv64 CV1800B chip.

It can run Linux and RTOS, providing a reliable, cost-effective, and high-performance platform for professionals, industrial ODMs, AIoT enthusiasts, DIY enthusiasts, and creators.

Features:

- [x] The RISC-V C906 processor with clock speeds of 1GHz and 700MHz.
- [x] CSI-2 (MIPI Serial Camera Interface)
- [x] Ethernet PHY
- [x] USB RNDIS & USB HOST & USB Mass Storage
- [x] Multiple peripherals
	- [x] -   Up to 3x I2C
	- [x] -   Up to 5x UART
	- [x] -   Up to 1x SDIO1
	- [x] -   Up to 1x SPI
	- [x] -   Up to 2x ADC
	- [x] -   Up to 7x PWM
	- [x] -   Up to 1x RUN
	- [x] -   Up to 1x JTAG

## How to build

```shell
$  make milkv_duo_musl_riscv64_defconfig
$  make
```

By default, a portion of the RAM is allocated to ION, which is the memory used when running algorithms with the camera. If you are not using the camera, please try:

```shell
$  make milkv_duo_musl_riscv64_64mb_defconfig
$  make
```

To have all the 64mb free memory.


To configure the kernel or u-boot or others, please try:

```shell
$  make linux-menuconfig # act like kernel's make menuconfig
$  make linux-rebuild
```

## Usage of the sdcard.img

The `sdcard.img` is in `output/images`, you can directly write the image into your TF card, which could automatically boot and load the USB as rndis function by default.

## Usage of the rootfs

Find the `rootfs.tar.xz` in `output/images`, mount the `mmcblk0p2` part to a directory. Then:

```shell
$ cd path/to/mmcblk0p2
$ rm -rf *
$ sync

$ tar -xf rootfs.tar.xz --directory=path/to/mmcblk0p2
$ cd path/to/mmcblk0p2
$ sync
```
