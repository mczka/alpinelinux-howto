#!/bin/bash

curl -L https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/llvm-project-12.0.1.src.tar.xz | tar -xJ
cd llvm-project-12.0.1.src
cmake -G "Unix Makefiles" -S llvm -B build -DCMAKE_BUILD_TYPE="Release" \
                                -DCMAKE_INSTALL_PREFIX="$(pwd)/../llvm-project-12.0.1" \
                                -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld" \
                                -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" \
                                -DLLVM_TARGETS_TO_BUILD="X86" \
                                -DLLVM_STATIC_LINK_CXX_STDLIB=On

cd build
make -j$(nproc)
make install

cd ../..
tar -cvJf llvm-project-12.0.1.tar.xz llvm-project-12.0.1
