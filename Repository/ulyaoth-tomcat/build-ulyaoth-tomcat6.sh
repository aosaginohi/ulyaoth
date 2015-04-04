buildarch="$(uname -m)"

useradd ulyaoth
cd /home/ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget http://apache.mirrors.spacedump.net/tomcat/tomcat-6/v6.0.43/bin/apache-tomcat-6.0.43.tar.gz"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SOURCES/tomcat.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SOURCES/tomcat.logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SOURCES/tomcat.service"
cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SPECS/ulyaoth-tomcat6.spec"

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-tomcat6.spec
fi

if grep -q -i "release 22" /etc/fedora-release
then
dnf builddep -y ulyaoth-tomcat6.spec
else
yum-builddep -y ulyaoth-tomcat6.spec
fi

su ulyaoth -c "rpmbuild -bb ulyaoth-tomcat6.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild"
rm -rf /root/build-ulyaoth-tomcat6.sh