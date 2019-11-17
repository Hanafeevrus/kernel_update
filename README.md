   ## kernel_update_lesson1
   ## 1. сборка ядра 5.2.21 с исходника
  #### Packer'ом провижиним скрипт `stage-3.sh` с командами:
  ##### !/bin/bash
    ####устанавливаем компоненты и утилиты
    yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 perl wget tar
    ####скачиваем исходники ядра 5.2.21
    wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.2.21.tar.xz
    #### распаковываем
    tar -xf linux-5.2.21.tar.xz &&
    #### копируем old config
    sudo cp /boot/config* linux-5.2.21/.config
    #### make & install 
    cd linux-5.2.21/ &&
    make oldconfig &&
    make &&
    make modules &&
    make install &&
    make modules_install &&
    #### Обновляем GRUB
    grub2-mkconfig -o /boot/grub2/grub.cfg
    grub2-set-default 0
    echo "Grub update done."
    #### ребутим ВМ
    shutdown -r now
    
 ## 2. сборка duild
 #### перейти в директорию packer и в ней выполнить команду:
  `packer build centos.json`
 #### публикуем релиз
      vagrant cloud auth login
      vagrant cloud publish --release <username>/centos-7-5 1.0 virtualbox \
      centos-7.7.1908-kernel-5-x86_64-Minimal.box
 #### опубликована сборка 
      Vagrant.configure("2") do |config|
      config.vm.box = "hanafeevrus/centos-7-5"
      config.vm.box_version = "1.0"
      end
