#!/bin/bash -e

show_progress() {
  echo -e "\n##############################################"
  echo -e "Start running $1..."
  "$@"
  echo -e "\nFinish running $1.\n"
}

install_utils() {
  sudo yum -y install bzip2
}

install_nodejs() {
  sudo yum -y install wget
  sudo wget http://nodejs.org/dist/v8.13.0/node-v8.13.0-linux-x64.tar.gz
  sudo tar --strip-components 1 -xzvf node-v* -C /usr/local
  sudo ln -s /usr/local/bin/node /usr/bin/node
  sudo ln -s /usr/local/bin/npm /usr/bin/npm
}

install_git() {
  sudo yum -y install git
}

install_java() {
  aws s3 cp s3://autoscale-dependencies/Java/jdk-8u172-linux-x64.tar.gz jdk-8u172-linux-x64.tar.gz
  sudo tar xzf jdk-8u172-linux-x64.tar.gz -C /opt
  sudo alternatives --install /usr/bin/java java /opt/jdk1.8.0_172/bin/java 2
  sudo alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_172/bin/jar 2
  sudo alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_172/bin/javac 2
  sudo alternatives --set jar /opt/jdk1.8.0_172/bin/jar
  sudo alternatives --set javac /opt/jdk1.8.0_172/bin/javac
}

show_progress install_utils
show_progress install_nodejs
show_progress install_git
show_progress install_java