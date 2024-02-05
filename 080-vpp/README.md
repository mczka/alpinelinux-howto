\# boot iso/iPXE

\# setup-alpine

\# user wheel doas 'permit nopass :wheel'

USERNAME=user

apk add alpine-sdk bash bash-completion coreutils utmps gawk grep sed tar

apk add findutils util-linux util-linux-misc procps-ng gmp libtool texinfo

apk add mandoc mandoc-apropos mandoc-doc man-pages chrpath

add add python3 python3-dev 

apk add make automake autoconf ccache cmake clang14 llvm14 

apk add strace gdb tshark iperf3

setup-utmp

adduser $USERNAME abuild

apk add docs

reboot

git clone https://gerrit.fd.io/r/vpp; cd vpp
