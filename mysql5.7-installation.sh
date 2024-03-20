#!/bin/bash
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-codename select bionic'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-distro select ubuntu'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-url string http://repo.mysql.com/apt/'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-preview select '
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-product select Ok'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-server select mysql-5.7'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-tools select '
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/unsupported-platform select abort'

apt-key --keyring /etc/apt/trusted.gpg.d/mysql-keyring.gpg adv --keyserver keyserver.ubuntu.com --recv B7B3B788A8D3785C
dpkg -i mysql-apt-config_0.8.12-1_all.deb
apt update
debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password root'
debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'
apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*

