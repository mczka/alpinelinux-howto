# vagrant on Alpinelinux

RUN apk add --no-cache gcc gcompat musl-dev make git ruby-bundler ruby-dev libvirt-dev \
    libvirt-daemon qemu-img qemu-system-x86_64 qemu-modules curl libarchive-tools kmod openssh-client-default && \
    echo -e "max_client_requests = 5\n" >> /etc/libvirt/libvirtd.conf
ENV VAGRANT_VERSION="v2.3.4"
RUN git clone --branch 0.11.2 https://github.com/vagrant-libvirt/vagrant-libvirt.git && \
    cd vagrant-libvirt && bundle install && bundle --binstubs exec
ENV PATH="$PATH:/build/vagrant-libvirt/exec"

git clone --branch 0.11.2 https://github.com/vagrant-libvirt/vagrant-libvirt.git

doas apk add ruby-bundler ruby-dev libvirt-dev libarchive-tools kmod openssh-client-default

doas echo -e "max_client_requests = 5\n" >> tee /etc/libvirt/libvirtd.conf

cd vagrant-libvirt

doas bundle install

doas bundle --binstubs exec

export PATH="$PATH:/home/username/vagrant-libvirt/exec"
