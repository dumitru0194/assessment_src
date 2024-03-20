#!/bin/bash
apt-key --keyring /etc/apt/trusted.gpg.d/mysql-keyring.gpg adv --keyserver keyserver.ubuntu.com --recv B7B3B788A8D3785C
dpkg -i mysql-apt-config_0.8.12-1_all.deb
apt update
debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password root'
debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'
apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*

