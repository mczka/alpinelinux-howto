#ALPINELINUX v3.19

apk add elfutils-dev libelf clang llvm linux-headers perf libbpf libbpf-dev libxdp libxdp-dev bpftool xdp-tools xdp-tests

apk add iproute2 iproute2-qos iproute2-rdma iproute2-tc bash bash-completion

make

#pin BPF resources (redirect map) to a persistent filesystem
mount -t bpf bpf /sys/fs/bpf/

# attach xdp_router code to eno2
./xdp_loader -d eno2 -F — progsec xdp_router

# attach xdp_router code to eno4
./xdp_loader -d eno4 -F — progsec xdp_router

# populate redirect_params maps
./xdp_prog_user -d eno2
./xdp_prog_user -d eno4
