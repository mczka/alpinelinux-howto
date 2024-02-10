\#boot iso extended and setup-alpine 

apk add bash bash-completion make llvm17 cmake clang17 lld strace

apk add coreutils utmps python3 git diffutils util-linux util-linux-misc findutils

apk add gawk sed grep tar meson pkgconf numactl numactl-tools numactl-dev pciutils

apk add libdrm libdrm-dev libdrm-tests elfutils elfutils-dev

setup-utmp

mkdir -p $HOME/prefix

\# step 2:

git clone https://github.com/ROCm/rocm-cmake.git

cd rocm-cmake

cmake -S . -B build -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/prefix -DCMAKE_PREFIX_PATH=$HOME/prefix

ninja -C build install

cd ../

\# step 3:

git clone https://github.com/ROCm/ROCT-Thunk-Interface.git

cd ROCT-Thunk-Interface

...

cd ../

git clone https://github.com/ROCm/ROCR-Runtime.git

cd ROCR-Runtime/src

cd ../../

