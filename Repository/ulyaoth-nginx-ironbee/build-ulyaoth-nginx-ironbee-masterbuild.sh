arch="$(uname -m)"
buildarch="$(uname -m)"

if [ "$arch" == "i686" ]
then
arch="i386"
fi

if grep -q -i "release 6" /etc/redhat-release
then
yum install -y http://ftp.acc.umu.se/mirror/fedora/epel/6/$arch/epel-release-6-8.noarch.rpm
elif grep -q -i "release 6" /etc/centos-release
then
yum install -y http://ftp.acc.umu.se/mirror/fedora/epel/6/$arch/epel-release-6-8.noarch.rpm
elif grep -q -i "release 7" /etc/oracle-release
then
yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/GeoIP-devel-1.5.0-9.el7.x86_64.rpm
else
echo yeah Fedora!
fi

useradd ulyaoth
cd /home/ulyaoth/
mkdir -p /etc/nginx/modules/ironbee
chown -R ulyaoth:ulyaoth /etc/nginx
su ulyaoth -c "rpmdev-setuptree"
su ulyaoth -c "wget https://github.com/ironbee/ironbee/archive/master.zip"
su ulyaoth -c "unzip master.zip"
su ulyaoth -c "cp -rf ironbee-master/* /etc/nginx/modules/ironbee/"
su ulyaoth -c "rm -rf ironbee-master master.zip"
cd /etc/nginx/modules/
su ulyaoth -c "tar cvf ironbee.tar.gz ironbee"
su ulyaoth -c "mv ironbee.tar.gz /home/ulyaoth/rpmbuild/SOURCES/"
cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget http://nginx.org/download/nginx-1.6.3.tar.gz"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.service"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.suse.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.suse.logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.sysconf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.upgrade.sh"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.default.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.example_ssl.conf"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-ironbee/SPECS/ulyaoth-nginx-ironbee-masterbuild.spec"

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-nginx-ironbee-masterbuild.spec
fi

if grep -q -i "release 22" /etc/fedora-release
then
dnf builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-nginx-ironbee-masterbuild.spec
else
yum-builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-nginx-ironbee-masterbuild.spec
fi

su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-ironbee-masterbuild.spec"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/BUILD/*"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/BUILDROOT/*"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/RPMS/*"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/SOURCES/ironbee.tar.gz"
cd /etc/nginx/modules/
su ulyaoth -c "tar cvf ironbee.tar.gz ironbee"
su ulyaoth -c "mv ironbee.tar.gz /home/ulyaoth/rpmbuild/SOURCES/"
cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-ironbee-masterbuild.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/
rm -rf /home/ulyaoth/rpmbuild/
rm -rf /etc/nginx
rm -rf /root/build-ulyaoth-nginx-ironbee-masterbuild.sh