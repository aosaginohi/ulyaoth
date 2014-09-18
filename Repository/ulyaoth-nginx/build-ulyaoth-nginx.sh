useradd ulyaoth
cd /root
rpmdev-setuptree
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
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx-modsecurity.spec
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx-passenger.spec
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx-passenger-modsecurity.spec
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx.spec
mv /root/rpmbuild /home/ulyaoth/
chown -R ulyaoth:ulyaoth /home/ulyaoth/rpmbuild
cd /home/ulyaoth/rpmbuild/SPECS
yum-builddep -y ulyaoth-nginx.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/