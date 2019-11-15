#!/bin/bash
# install components for kernel install
yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 perl wget tar
##download kernel 5.2
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.2.21.tar.xz
##unzip archive
tar -xf linux-5.2.21.tar.xz &&
##copy old config
sudo cp /boot/config* linux-5.2.21/.config
##make & install 
cd linux-5.2.21/ && 
make oldconfig && 
make && 
make modules && 
make install && 
make modules_install && 

# Install elrepo
#yum install -y http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
# Install new kernel
#yum --enablerepo elrepo-kernel install kernel-ml -y
# Remove older kernels (Only for demo! Not Production!)
#rm -f /boot/*3.10*
# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Reboot VM
shutdown -r now
