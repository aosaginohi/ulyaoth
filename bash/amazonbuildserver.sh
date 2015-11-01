yum update -y
echo 'amazon' | sudo tee --append /etc/ulyaoth > /dev/null
sudo useradd -G wheel ulyaoth
sudo yum groupinstall "Development Tools" -y
sudo yum install rpmdevtools rpm-build perl-macros rpm-sign yum-utils curl wget zip tar system-rpm-config mlocate -y
sudo yum install https://downloads.ulyaoth.net/rpm/amazon/x86_64/ulyaoth-1.0.9-1.amzn1.x86_64.rpm -y
reboot
