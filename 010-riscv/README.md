## ARCH RISCV
1. gnu gcc toolchain  - cross_compile - used x86_64 HW to run qemu-system-riscv64 ```https://github.com/riscv-collab/riscv-gnu-toolchain```
2. opensbi - riscv M-mode to S-mode/HV-mode - ```https://github.com/riscv-software-src/opensbi```
3. U-boot SPL - kernel/initramfs bootloader - ```https://github.com/u-boot/u-boot/blob/master/doc/board/emulation/qemu-riscv.rst```
4. Alpinelinux riscv64 disk image - no official iso - ```https://gitlab.alpinelinux.org/nmeum/alpine-unmatched/-/blob/master/build-image.sh```
5. Booting AL with qemu-system-riscv64 
