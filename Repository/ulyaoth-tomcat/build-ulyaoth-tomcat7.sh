useradd ulyaoth
cd /home/ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget http://apache.mirrors.spacedump.net/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.tar.gz"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SOURCES/tomcat.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SOURCES/tomcat.logrotate"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SOURCES/tomcat.service"
cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat/SPECS/ulyaoth-tomcat7.spec"
yum-builddep -y ulyaoth-tomcat7.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-tomcat7.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild"
rm -rf /root/build-ulyaoth-tomcat7.sh