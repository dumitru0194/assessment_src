#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export MYSQL_REPO_URL="https://repo.mysql.com/apt/ubuntu"
export MYSQL_SERVER_VERSION="mysql-8.0"
export MYSQL_TOOLS="mysql-tools"
export DISTRO="ubuntu"
export DISTRO_VERSION="bionic"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B7B3B788A8D3785C
sudo dpkg -i mysql-apt-config_0.8.12-1_all.deb
sudo apt update
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password root'
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'
sudo apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*

