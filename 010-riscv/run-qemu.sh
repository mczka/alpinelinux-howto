#!/bin/bash

qemu-system-riscv64 -nographic -M virt -m 8G -smp 8 \
-bios $HOME/riscv/opensbi/build/platform/generic/firmware/fw_payload.elf \
-kernel $HOME/riscv/linux-6.4-rc3/arch/riscv/boot/Image \
-append "alpine_repo=/main init=/bin/sh root=/dev/vda" \
-device virtio-blk-device,drive=hd0 \
-drive file=$HOME/riscv/disk.img,format=raw,id=hd0
