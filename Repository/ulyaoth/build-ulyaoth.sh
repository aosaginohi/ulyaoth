arch="$(uname -m)"
buildarch="$(uname -m)"

useradd ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SOURCES

if grep -q -i "rhel" /etc/ulyaoth
then
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-rhel.repo -O ulyaoth.repo"
elif grep -q -i "CentOS" /etc/ulyaoth
then
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-centos.repo -O ulyaoth.repo"
elif grep -q -i "Fedora" /etc/ulyaoth
su ulyaoth -c "https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/ulyaoth-fedora.repo -O ulyaoth.repo"
else
echo A unsupported OS was detected!
fi

su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SOURCES/RPM-GPG-KEY-ulyaoth"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/SPECS/ulyaoth.spec"

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth.spec
fi

su ulyaoth -c "rpmbuild -bb ulyaoth.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/