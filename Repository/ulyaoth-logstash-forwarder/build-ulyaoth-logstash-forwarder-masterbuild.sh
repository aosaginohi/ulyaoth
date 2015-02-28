useradd ulyaoth
cd /home/ulyaoth/
su ulyaoth -c "rpmdev-setuptree"
yum install go
su ulyaoth -c "git clone git://github.com/elasticsearch/logstash-forwarder.git"
su ulyaoth -c "cd /home/ulyaoth/logstash-forwarder/ && go build"
su ulyaoth -c "mv /home/ulyaoth/logstash-forwarder/logstash-forwarder /home/ulyaoth/rpmbuild/SOURCES/"
su ulyaoth -c "rm -rf /home/ulyaoth/logstash-forwarder/"
cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-logstash-forwarder/SOURCES/logstash-forwarder.conf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-logstash-forwarder/SOURCES/logstash-forwarder.init"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-logstash-forwarder/SOURCES/logstash-forwarder.service"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-logstash-forwarder/SPECS/ulyaoth-logstash-forwarder-masterbuild.spec"
su ulyaoth -c "rpmbuild -bb ulyaoth-logstash-forwarder-masterbuild.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
rm -rf /home/ulyaoth/rpmbuild/
rm -rf /root/build-ulyaoth-logstash-forwarder-masterbuild.sh