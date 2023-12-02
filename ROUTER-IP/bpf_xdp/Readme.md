#ALPINELINUX v3.19

apk add elfutils-dev libelf clang llvm linux-headers perf libbpf libbpf-dev libxdp libxdp-dev bpftool xdp-tools xdp-tests

mount -t bpf bpf /sys/fs/bpf/

apk add iproute2 iproute2-qos iproute2-rdma iproute2-tc bash bash-completion
