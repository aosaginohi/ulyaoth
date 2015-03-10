useradd ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES

if grep -q -i "release 7" /etc/redhat-release
then
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-rhel.repo -O ulyaoth.repo"
else
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-centos.repo -O ulyaoth.repo"
fi

if grep -q -i "release 6" /etc/redhat-release
then
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-rhel.repo"
else
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-centos.repo -O ulyaoth.repo"
fi

su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/RPM-GPG-KEY-ulyaoth"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-fedora.repo"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SPECS/ulyaoth.spec"
su ulyaoth -c "rpmbuild -bb ulyaoth.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild"
rm -rf /root/build-ulyaoth.sh