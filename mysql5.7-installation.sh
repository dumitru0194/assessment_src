#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export MYSQL_REPO_URL="https://repo.mysql.com/apt/ubuntu"
export MYSQL_SERVER_VERSION="mysql-5.7"
export MYSQL_TOOLS="mysql-tools"
export DISTRO="ubuntu"
export DISTRO_VERSION="bionic"
apt install wget
wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B7B3B788A8D3785C
dpkg -i mysql-apt-config_0.8.12-1_all.deb
apt update
debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password root'
debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'
apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*

