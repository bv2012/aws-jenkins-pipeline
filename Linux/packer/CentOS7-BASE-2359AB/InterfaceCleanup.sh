#!/bin/bash -e

#cleanup interface based on bug 13300
# https://bugs.centos.org/view.php?id=13300 

shopt -s nullglob
echo "removing interface configuration files"
for f in /etc/sysconfig/network-scripts/ifcfg*
do
	echo "Removing $f"
    sudo rm $f
done

echo "removing persistent rule file"
file="/etc/udev/rules.d/70-persistent-net.rules"
if [ -f "$file" ]
then
    echo "removing $file."
	sudo rm $file
else
	echo "$file not found."
fi

echo "Updating /etc/default/grub."
sudo sed -i -e 's;GRUB_CMDLINE_LINUX="console=tty0 crashkernel=auto console=ttyS0,115200";GRUB_CMDLINE_LINUX="console=tty0 crashkernel=auto console=ttyS0,115200 net.ifnames=0";g' /etc/default/grub
