echo 'amazon' | sudo tee --append /etc/ulyaoth > /dev/null
sudo useradd -G wheel ulyaoth
sudo yum groupinstall "Development Tools" -y
sudo yum install rpmdevtools rpm-build perl-macros rpm-sign yum-utils curl wget zip tar system-rpm-config -y

