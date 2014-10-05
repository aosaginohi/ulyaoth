useradd ulyaoth
cd /home/ulyaoth/
mkdir -p /etc/nginx/modules/naxsi
chown -R ulyaoth:ulyaoth /etc/nginx
su ulyaoth -c "rpmdev-setuptree"
su ulyaoth -c "wget https://github.com/nbs-system/naxsi/archive/master.zip"
su ulyaoth -c "unzip master.zip"
su ulyaoth -c "mv naxsi-master/* /etc/nginx/modules/naxsi/"
su ulyaoth -c "rm -rf naxsi-master master.zip"
su ulyaoth -c "cd /etc/nginx/modules/"
su ulyaoth -c "tar cvf naxsi.tar.gz naxsi"
su ulyaoth -c "mv naxsi.tar.gz /home/ulyaoth/rpmbuild/SOURCES/"
su ulyaoth -c "cd /home/ulyaoth/rpmbuild/SOURCES/"
su ulyaoth -c "wget http://nginx.org/download/nginx-1.6.2.tar.gz"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.service"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.suse.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.sysconf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.upgrade.sh"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.default-naxsi.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SOURCES/nginx.vh.example_ssl.conf"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx/SPECS/ulyaoth-nginx-naxsi.spec"
yum-builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-nginx-naxsi.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-naxsi.spec"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/BUILD/*"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/BUILDROOT/*"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/RPMS/*"
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/SOURCES/naxsi.tar.gz"
su ulyaoth -c "cd /etc/nginx/modules/"
su ulyaoth -c "tar cvf naxsi.tar.gz naxsi"
su ulyaoth -c "mv naxsi.tar.gz /home/ulyaoth/rpmbuild/SOURCES/"
su ulyaoth -c "cd /home/ulyaoth/rpmbuild/SPECS/"
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-naxsi.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild/"
su ulyaoth -c "rm -rf /etc/nginx"