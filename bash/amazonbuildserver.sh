#!/bin/bash

sudo yum update -y
echo 'amazonlinux' | sudo tee --append /etc/ulyaoth > /dev/null
sudo useradd -G wheel ulyaoth
sudo yum groupinstall "Development Tools" -y
sudo yum install rpmdevtools rpm-build perl-macros rpm-sign yum-utils curl wget zip tar system-rpm-config mlocate -y
sudo yum install https://downloads.ulyaoth.net/rpm/ulyaoth-1.1.0-1.amazonlinux.noarch.rpm -y
sudo reboot