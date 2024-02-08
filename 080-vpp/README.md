\# boot iso/iPXE

\# setup-alpine

\# user wheel doas 'permit nopass :wheel'

apk add alpine-sdk bash bash-completion coreutils utmps gawk grep sed tar bison

apk add findutils util-linux util-linux-misc procps-ng gmp libtool texinfo chrpath

apk add mandoc mandoc-apropos mandoc-doc man-pages

apk add bsd-compat-headers linux-headers iproute2 ethtool pciutils

apk add python3 python3-dev py3-pip py3-elftools py3-virtualenv py3-ply py3-jsonschema

apk add py3-docutils eudev-dev libdrm-dev libnl3-dev dtc-dev isa-l-dev jansson-dev 

apk add numactl numactl-dev libbpf libbpf-dev libxdp libxdp-dev libpcap libpcap-dev

apk add openssl-dev libarchive libarchive-dev libnl3 libnl3-dev libmnl libmnl-dev

apk add rdma-core rdma-core-dev zlib-dev libffi libffi-dev subunit subunit-dev

apk add apr-dev check check-dev xmlto indent 

apk add make automake autoconf nasm meson ccache cmake clang14 llvm14 git-review keychain

apk add strace gdb tshark iperf3

setup-utmp

adduser $USER abuild

apk add docs

mkdir -p /mnt/huge

vi /etc/default/grub

iommu=pt default_hugepagesz=1G hugepagesz=1G hugepages=2 transparent_hugepage=never"

grub-mkconfig -o /boot/grub/grub.cfg

echo "nodev /mnt/huge hugetlbfs pagesize=1GB 0 0" >> /etc/fstab

cat > /etc/modules << EOF
af_packet
ipv6
tun
tap
kvm_amd
vfio
vfio_pci
vfio_iommu_type1
vfio_virqfd
vhost_net
macvtap
uio_pci_generic
EOF

reboot

git clone https://gerrit.fd.io/r/vpp; cd vpp

wget https://raw.githubusercontent.com/mczka/alpinelinux-howto/main/080-vpp/0001-alpinelinux-dpdk-v23.11-patch.patch

mkdir -p build/external/patches/dpdk_23.11/

cp 0001-alpinelinux-dpdk-v23.11-patch.patch build/external/patches/dpdk_23.11/0001-alpinelinux-dpdk-v23.11-patch.patch

export SUDO=doas

export CROSS_COMPILE=x86_64-alpine-linux-musl-

doas ln -s $(which clang-14) /usr/bin/clang

doas ln -s $(which llc14) /usr/bin/llc


sed -i 's/-linux-gnu/-alpine-linux-musl/' ./configure

sed -i 's/-linux-gnu/-alpine-linux-musl/' ./src/CMakeLists.txt


make wipe-all

make build

make wipe-all

make build-release
