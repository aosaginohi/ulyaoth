useradd ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/RPM-GPG-KEY-ulyaoth"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-fedora.repo"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-rhel.repo"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SPECS/ulyaoth.spec"
su ulyaoth -c "rpmbuild -bb ulyaoth.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild"
