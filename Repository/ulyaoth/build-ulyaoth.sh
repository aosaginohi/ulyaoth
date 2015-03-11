arch="$(uname -m)"

useradd ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES

if grep -q -i "Red Hat" /etc/redhat-release
then
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-rhel.repo -O ulyaoth.repo"
elif grep -q -i "CentOS" /etc/centos-release
then
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-centos.repo -O ulyaoth.repo"
else
echo yeah Fedora!
fi

su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/RPM-GPG-KEY-ulyaoth"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-fedora.repo"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SPECS/ulyaoth.spec"
su ulyaoth -c "rpmbuild -bb ulyaoth.spec"
cp /home/ulyaoth/rpmbuild/RPMS/$arch/* /root/