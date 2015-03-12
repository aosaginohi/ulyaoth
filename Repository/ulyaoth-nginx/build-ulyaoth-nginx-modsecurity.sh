arch="$(uname -m)"
buildarch="$(uname -m)"

if [ "$arch" == "i686" ]
then
arch="i386"
fi

if grep -q -i "release 6" /etc/redhat-release
then
wget http://ftp.acc.umu.se/mirror/fedora/epel/6/$arch/epel-release-6-8.noarch.rpm
elif grep -q -i "release 6" /etc/centos-release
then
wget http://ftp.acc.umu.se/mirror/fedora/epel/6/$arch/epel-release-6-8.noarch.rpm
else
echo yeah Fedora!
fi

useradd ulyaoth
yum install -y pcre pcre-devel libxml2 libxml2-devel curl curl-devel httpd-devel yajl-devel lua-devel lua-static
cd /root
rpmdev-setuptree
mkdir -p /etc/nginx/modules
cd /etc/nginx/modules
wget https://www.modsecurity.org/tarball/2.9.0/modsecurity-2.9.0.tar.gz
tar xvf modsecurity-2.9.0.tar.gz
mv modsecurity-2.9.0 modsecurity
rm -rf modsecurity-2.9.0.tar.gz
cd modsecurity
./autogen.sh
./configure --enable-standalone-module
make
cd /etc/nginx/modules
tar cvf modsecurity.tar.gz modsecurity
mv modsecurity.tar.gz /root/rpmbuild/SOURCES/
cd /root/rpmbuild/SOURCES
wget http://nginx.org/download/nginx-1.6.2.tar.gz
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/logrotate
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/modsecurity.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.init
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.service
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.suse.init
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.suse.logrotate
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.sysconf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.upgrade.sh
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.default-modsecurity.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.default.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.example_ssl.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.passenger.conf
cd /root/rpmbuild/SPECS
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx-modsecurity.spec
cd /home/ulyaoth/
chown -R ulyaoth:ulyaoth /etc/nginx/
mv /root/rpmbuild /home/ulyaoth/
chown -R ulyaoth:ulyaoth /home/ulyaoth/rpmbuild
cd /home/ulyaoth/rpmbuild/SPECS

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-nginx-modsecurity.spec
fi

yum-builddep -y ulyaoth-nginx-modsecurity.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-modsecurity.spec"
rm -rf /home/ulyaoth/rpmbuild/BUILD/*
rm -rf /home/ulyaoth/rpmbuild/BUILDROOT/*
rm -rf /home/ulyaoth/rpmbuild/RPMS/*
rm -rf /home/ulyaoth/rpmbuild/SOURCES/modsecurity.tar.gz
cd /etc/nginx/modules
tar cvf modsecurity.tar.gz modsecurity
mv modsecurity.tar.gz /home/ulyaoth/rpmbuild/SOURCES/
chown -R ulyaoth:ulyaoth /home/ulyaoth/rpmbuild
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-modsecurity.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/