
https://github.com/llvm/llvm-project.git


cmake ../llvm -G Ninja -DLLVM_ENABLE_PROJECTS=”libc;lld;compiler-rt;clang” \
-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=/llvm/prefix \
-DLLVM_LIBC_FULL_BUILD=ON \ # We want the full libc
-DLLVM_LIBC_INCLUDE_SCUDO=ON \ # Include Scudo in the libc
-DCOMPILER_RT_BUILD_SCUDO_STANDALONE_WITH_LLVM_LIBC=ON \ # Build Scudo against libc headers
-DCOMPILER_RT_BUILD_GWP_ASAN=OFF \ # Do not include GWP-ASAN with Scudo
-DCOMPILER_RT_SCUDO_STANDALONE_BUILD_SHARED=OFF # Do not build the Scudo shared object

● Install:

ninja install-clang install-builtins install-compiler-rt \
install-core-resource-headers install-libc install-lld

● Linux Headers:

apt download linux-libc-dev
dpkg -x linux-libc-dev*deb .
mv usr/include/* /path/to/sysroot/include
rm -rf usr linux-libc-dev*deb
ln -s x86_64-linux-gnu/asm ~/Programming/sysroot/include/asm
