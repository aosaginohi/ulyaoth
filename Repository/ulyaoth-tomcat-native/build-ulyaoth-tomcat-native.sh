useradd ulyaoth
cd /home/ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget http://apache.mirrors.spacedump.net/tomcat/tomcat-connectors/native/1.1.32/source/tomcat-native-1.1.32-src.tar.gz"
cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-tomcat-native/SPECS/ulyaoth-tomcat-native.spec"
yum-builddep -y ulyaoth-tomcat-native.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-tomcat-native.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild"
rm -rf /root/build-ulyaoth-tomcat-native.sh