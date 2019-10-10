#!/bin/bash -e

show_progress() {
  echo -e "\n##############################################"
  echo -e "Start running $1..."
  "$@"
  echo -e "\nFinish running $1.\n"
}

init_yum_repos(){
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

}

install_docker(){
  sudo yum -y makecache fast
  sudo yum -y install docker-ce-$DOCKER_VERSION
  sudo systemctl enable docker
  sudo usermod -aG docker $USER
  sudo systemctl start docker
  echo '{ "max-concurrent-uploads": 1 }' | sudo tee /etc/docker/daemon.json #had to add because pushes were failing
}


show_progress init_yum_repos
show_progress install_docker
