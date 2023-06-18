my x86_64 machine has installed packages:
cat /etc/apk/world
acct
alpine-base
alpine-sdk
alsa-plugins-pulse
bash
bash-completion
bash-doc
bc
binutils
binutils-riscv64
bison
build-base
busybox-mdev-openrc
chrony
consolekit2
coreutils
coreutils-doc
curl
curl-doc
doas
docker
dosfstools
dtc
e2fsprogs
ethtool
eudev
findutils
firefox
flex
gawk
gdb
git
grep
grep-doc
grub-efi
gvfs
htop
hwloc-tools
iproute2
iw
libc6-compat
liburing
liburing-dev
liburing-doc
lightdm
lightdm-gtk-greeter
linux-firmware-i915
linux-firmware-intel
linux-firmware-mediatek
linux-firmware-nvidia
linux-firmware-other
linux-firmware-rtl_bt
linux-headers
linux-lts
linux-lts-doc
logrotate
lsblk
man-pages
mandoc
mesa-dri-gallium
nano
nano-doc
ncurses-dev
openssh
openssl
openssl-dev
pciutils
perf
perl
polkit
procps-ng
procps-ng-doc
pulseaudio
py3-setuptools
python3
python3-dev
qemu-system-riscv64
readline
sdl2-dev
sed
sed-doc
sysfsutils
texinfo
tshark
udev-init-scripts
udev-init-scripts-openrc
usbutils
util-linux
util-linux-doc
util-linux-misc
utmps
wpa_supplicant
xf86-input-libinput
xfce4
xfce4-pulseaudio-plugin
xfce4-terminal
xorg-server
zlib-dev
```
## SETUP ENV
apk add makeinfo bison flex zlib-dev

#####riscv-gnu-toolchain
mkdir /opt/riscv
chown -R $user:$user /opt/riscv
mkdir $HOME/riscv-gnu-toolchain
cd
git clone https://github.com/riscv-collab/riscv-gnu-toolchain
cd $HOME/riscv-gnu-toolchain
./configure --prefix=/opt/riscv
make musl
(very very long compile time)

export PATH=/opt/riscv/bin:$PATH


#u-boot
git clone https://github.com/u-boot/u-boot
make qemu-riscv64_smode_defconfig
make -j4

#opensbi
git clone https://github.com/riscv-software-src/opensbi

make PLATFORM=generic FW_PAYLOAD_PATH=$HOME/riscv/u-boot/u-boot.bin

cat riscv-env.sh 
export PATH=/opt/riscv/bin:$PATH
export CROSS_COMPILE=riscv64-unknown-linux-musl-

cat run-qemu.sh 
#!/bin/bash

qemu-system-riscv64 -nographic -M virt -m 8G -smp 8 \
-bios $HOME/riscv/opensbi/build/platform/generic/firmware/fw_payload.elf

#check opensbi and u-boot run
./run-qemu.sh

###############################################################################################
# bootlin tutorial embedded
#disk with kernel riscv (compile kernel first: make defconfig; make 64-bit.config; make)
dd if=/dev/zero of=disk0-nvme.img bs=1M count=4096
cfdisk disk0.img
# dos
#p1 type W95 FAT32 (LBA) bootable
#p2 type linux
fdisk -lu disk0.img

Disk disk0.img: 4 GiB, 4294967296 bytes, 8388608 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x841c9859

Device     Boot  Start     End Sectors  Size Id Type
disk0.img1 *      2048  526335  524288  256M  c W95 FAT32 (LBA)
disk0.img2      526336 8388607 7862272  3.7G 83 Linux
doas losetup -f --show --partscan disk0.img
doas mkfs.vfat -F 32 -n boot /dev/loopXp1
doas mkfs.ext4 -L rootfs /dev/loopXp2

mkdir /mnt/boot
mount /dev/loopXp1 /mnt/boot/

#kernel 
cp ../arch/riscv/boot/Image /mnt/boot/

umount /mnt/boot


#recompile u-boot
make menuconfig
# ENV_IS_IN_FAT
# ENV_FAT_INTERFACE="virtio"
# ENV_FAT_DEVICE_AND_PART="0:1"
#recompile opensbi

# add disk to qemu
-device virtio-blk-device,drive=hd0
-disk file=disk0.img,format=raw,id=hd0


# in u-boot saveenv
fatls virtio 0:1
setenv bootargs 'root=/dev/vda2 rootwait console=ttyS0 earlycon=sbi'
setenv bootcmd 'fatload virtio 0:1 84000000 Image; booti 0x84000000 - ${fdtcontroladdr}'
saveenv


#rootfs
mkdir /mnt/rootfs
mount /dev/loopXp2 /mnt/rootfs
cd /mnt/rootfs
tar xf alpine-minirootfs-riscv64..
umount /mnt/rootfs

as losetup -f --show --partscan disk0.img
doas mkfs.vfat -F 32 -n boot /dev/loopXp1
doas mkfs.ext4 -L rootfs /dev/loopXp2

mkdir /mnt/boot
mount /dev/loopXp1 /mnt/boot/

#kernel 
cp ../arch/riscv/boot/Image /mnt/boot/

umount /mnt/boot

#####################################################################################################
# disk again from AL script
TBC






```
