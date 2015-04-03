arch="$(uname -m)"
buildarch="$(uname -m)"

if [ "$arch" == "i686" ]
then
arch="i386"
fi

useradd ulyaoth
cd /home/ulyaoth/
chown -R ulyaoth:ulyaoth /etc/nginx
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget https://github.com/sbagmeijer/ulyaoth/raw/master/Repository/ulyaoth-nginx-pagespeed/SOURCES/ulyaoth-nginx-pagespeed.pp"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-nginx-pagespeed/SPECS/ulyaoth-nginx-pagespeed-selinux.spec"

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-nginx-pagespeed-selinux.spec
fi

yum-builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-nginx-pagespeed-selinux.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-nginx-pagespeed-selinux.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/
rm -rf /home/ulyaoth/rpmbuild/
rm -rf /etc/nginx
rm -rf /root/build-ulyaoth-nginx-pagespeed-selinux.sh