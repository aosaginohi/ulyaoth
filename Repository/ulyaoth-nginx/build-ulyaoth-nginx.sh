useradd ulyaoth
usermod -Gulyaoth ulyaoth
mkdir -p /etc/nginx/modules
chown -R ulyaoth:ulyaoth /etc/nginx
cd /home/ulyaoth/
rpmdev-setuptree
su ulyaoth -c "wget https://github.com/openresty/headers-more-nginx-module/archive/v0.25.tar.gz"
su ulyaoth -c "tar xvf v0.25.tar.gz"
su ulyaoth -c "mv headers-more-nginx-module-0.25 /etc/nginx/modules/headersmore"
su ulyaoth -c "rm -rf v0.25.tar.gz"
chown -R ulyaoth:ulyaoth /etc/nginx
cd /home/ulyaoth/rpmbuild/SOURCES
su ulyaoth -c "wget http://nginx.org/download/nginx-1.6.2.tar.gz"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.service"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.suse.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.sysconf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.upgrade.sh"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.default.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.example_ssl.conf"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx.spec"
yum-builddep -y ulyaoth-nginx.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/