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
usermod -Gulyaoth ulyaoth
mkdir -p /etc/nginx/modules
chown -R ulyaoth:ulyaoth /etc/nginx
cd /home/ulyaoth/
su ulyaoth -c "rpmdev-setuptree"
su ulyaoth -c "wget https://github.com/openresty/headers-more-nginx-module/archive/v0.25.tar.gz"
su ulyaoth -c "tar xvf v0.25.tar.gz"
su ulyaoth -c "mv headers-more-nginx-module-0.25 /etc/nginx/modules/headersmore"
su ulyaoth -c "rm -rf v0.25.tar.gz"
chown -R ulyaoth:ulyaoth /etc/nginx
cd /home/ulyaoth/rpmbuild/SOURCES
su ulyaoth -c "wget http://tengine.taobao.org/download/tengine-1.5.2.tar.gz"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.service"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.suse.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.suse.logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.sysconf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.upgrade.sh"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.vh.default.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SOURCES/nginx.vh.example_ssl.conf"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-tengine/SPECS/ulyaoth-tengine.spec"

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-nginx.spec
fi

if grep -q -i "release 22" /etc/fedora-release
then
dnf builddep -y ulyaoth-tengine.spec
else
yum-builddep -y ulyaoth-tengine.spec
fi

su ulyaoth -c "rpmbuild -bb ulyaoth-tengine.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/
rm -rf /etc/nginx
rm -rf /root/build-ulyaoth-tengine.sh
rm -rf /home/ulyaoth/rpmbuild