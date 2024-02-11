\#boot iso extended and setup-alpine 

apk add bash bash-completion make llvm17 cmake clang17 lld strace

apk add coreutils utmps python3 git diffutils util-linux util-linux-misc findutils

apk add gawk sed grep tar meson pkgconf numactl numactl-tools numactl-dev pciutils

apk add libdrm libdrm-dev libdrm-tests elfutils elfutils-dev

setup-utmp

export ROCM_PATH=$HOME/prefix

export HIP_PATH=$HOME/prefix/hip

export LLVM_PATH=$HOME/prefix/llvm

mkdir -p $HOME/prefix

mkdir -p $HOME/llvm-project

mkdir -p $HOME/prefix/device-libs

LLVM_PROJECT=$HOME/llvm-project

git clone https://github.com/ROCm/llvm-project.git $HOME/llvm-project

DEVICE_LIBS=$HOME/prefix/device-libs

COMGR=$HOME/prefix/lib/comgr

mkdir -p "$LLVM_PROJECT/build"

cd "$LLVM_PROJECT/build"

cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="llvm;clang;lld" -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" ../llvm

make

mkdir -p "$DEVICE_LIBS/build"; cd "$DEVICE_LIBS/build"

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$LLVM_PROJECT/build" ..

make

mkdir -p "$COMGR/build"; cd "$COMGR/build"

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$LLVM_PROJECT/build;$DEVICE_LIBS/build" ..

make

make test






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

