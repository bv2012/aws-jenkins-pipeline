#!/bin/bash -e

show_progress() {
  echo -e "\n##############################################"
  echo -e "Start running $1..."
  "$@"
  echo -e "\nFinish running $1.\n"
}

init_yum_repos(){
    sudo yum install -y yum-utils
    rpm -Uvh http://mirrors.kernel.org/fedora-epel/6/i386/epel-release-6-8.noarch.rpm
    rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
    sudo yum -y makecache fast
    yum update -y
}

upgrade_kernel(){
    sudo yum --enablerepo=elrepo-kernel install kernel-ml -y
    sudo grub2-set-default 0
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
}

install_awscli(){
    #install aws cli
    yum install unzip -y
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/tmp/awscli-bundle.zip"
    unzip /tmp/awscli-bundle.zip
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
}
set_security(){
    sed -i '/tty11/Q' /etc/securetty
    echo tty11 >> /etc/securetty
    sed -i -e 's/umask 022/umask 077/g' /etc/bashrc
    sed -i -e 's/umask 022/umask 077/g' /etc/profile

    #Disable ICMP redirect support
    echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
    echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
    echo "net.ipv4.conf.all.secure_redirects=0" >> /etc/sysctl.conf
    echo "net.ipv4.conf.default.secure_redirects=0" >> /etc/sysctl.conf

    sysctl -w net.ipv4.conf.all.accept_redirects=0
    sysctl -w net.ipv4.conf.default.accept_redirects=0
    sysctl -w net.ipv4.conf.all.secure_redirects=0
    sysctl -w net.ipv4.conf.default.secure_redirects=0

}

show_progress init_yum_repos
show_progress set_security
show_progress install_awscli
show_progress upgrade_kernel
