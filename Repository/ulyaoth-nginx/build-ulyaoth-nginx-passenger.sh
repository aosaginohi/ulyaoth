useradd ulyaoth
cd /root
rpmdev-setuptree
mkdir -p /etc/nginx/modules
cd /etc/nginx/modules
wget http://s3.amazonaws.com/phusion-passenger/releases/passenger-4.0.52.tar.gz
tar xvf passenger-4.0.52.tar.gz
mv passenger-4.0.52 passenger
rm -rf /etc/nginx/modules/passenger/packaging
tar cvf passenger.tar.gz passenger
mv passenger.tar.gz /root/rpmbuild/SOURCES/
cd /root/rpmbuild/SOURCES
wget http://nginx.org/download/nginx-1.6.2.tar.gz
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/logrotate
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/modsecurity.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.init
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.service
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.suse.init
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.sysconf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.upgrade.sh
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.default-modsecurity.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.default.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.example_ssl.conf
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.passenger.conf
cd /root/rpmbuild/SPECS
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx-passenger.spec
cd /home/ulyaoth/
chown -R ulyaoth:ulyaoth /etc/nginx/
mv /root/rpmbuild /home/ulyaoth/
chown -R ulyaoth:ulyaoth /home/ulyaoth/rpmbuild
cd /home/ulyaoth/rpmbuild/SPECS
yum-builddep -y ulyaoth-nginx-passenger.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-passenger.spec"
rm -rf /home/ulyaoth/rpmbuild/BUILD/*
rm -rf /home/ulyaoth/rpmbuild/BUILDROOT/*
rm -rf /home/ulyaoth/rpmbuild/RPMS/*
rm -rf /home/ulyaoth/rpmbuild/SOURCES/passenger.tar.gz
cd /etc/nginx/modules
tar cvf passenger.tar.gz passenger
mv passenger.tar.gz /home/ulyaoth/rpmbuild/SOURCES/
chown -R ulyaoth:ulyaoth /home/ulyaoth/rpmbuild
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-passenger.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
