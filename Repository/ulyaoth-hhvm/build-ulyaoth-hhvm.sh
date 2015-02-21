useradd ulyaoth
cd /home/ulyaoth

if grep -q -i "release 7" /etc/redhat-release
then
wget http://ftp.acc.umu.se/mirror/fedora/linux/releases/20/Everything/x86_64/os/Packages/o/oniguruma-5.9.5-1.fc20.x86_64.rpm
wget http://ftp.acc.umu.se/mirror/fedora/linux/releases/20/Everything/x86_64/os/Packages/o/oniguruma-devel-5.9.5-1.fc20.x86_64.rpm
wget http://ftp.acc.umu.se/mirror/fedora/linux/releases/20/Everything/x86_64/os/Packages/g/glog-0.3.3-3.fc20.x86_64.rpm
wget http://ftp.acc.umu.se/mirror/fedora/linux/releases/20/Everything/x86_64/os/Packages/g/glog-devel-0.3.3-3.fc20.x86_64.rpm
wget http://ftp.acc.umu.se/mirror/fedora/linux/releases/20/Everything/x86_64/os/Packages/l/libmcrypt-2.5.8-14.fc20.x86_64.rpm
wget http://ftp.acc.umu.se/mirror/fedora/linux/releases/20/Everything/x86_64/os/Packages/l/libmcrypt-devel-2.5.8-14.fc20.x86_64.rpm
yum -y install libc-client-2007f-4.el7.1.x86_64.rpm uw-imap-devel-2007f-4.el7.1.x86_64.rpm oniguruma-5.9.5-1.fc20.x86_64.rpm oniguruma-devel-5.9.5-1.fc20.x86_64.rpm libmcrypt-devel-2.5.8-14.fc20.x86_64.rpm libmcrypt-2.5.8-14.fc20.x86_64.rpm glog-devel-0.3.3-3.fc20.x86_64.rpm glog-0.3.3-3.fc20.x86_64.rpm
rm -rf /home/ulyaoth/libc-client-2007f-4.el7.1.x86_64.rpm uw-imap-devel-2007f-4.el7.1.x86_64.rpm oniguruma-5.9.5-1.fc20.x86_64.rpm oniguruma-devel-5.9.5-1.fc20.x86_64.rpm libmcrypt-devel-2.5.8-14.fc20.x86_64.rpm libmcrypt-2.5.8-14.fc20.x86_64.rpm glog-devel-0.3.3-3.fc20.x86_64.rpm glog-0.3.3-3.fc20.x86_64.rpm
fi

su ulyaoth -c "rpmdev-setuptree"
su ulyaoth -c "git clone -b HHVM-3.5 git://github.com/facebook/hhvm.git"
mv /home/ulyaoth/hhvm /home/ulyaoth/hhvm-3.5.2
cd /home/ulyaoth/hhvm-3.5.2
su ulyaoth -c "git submodule update --init --recursive"
cd /home/ulyaoth
su ulyaoth -c "tar cvf hhvm-3.5.2.tar.gz hhvm-3.5.2/"
mv /home/ulyaoth/hhvm-3.5.2.tar.gz /home/ulyaoth/rpmbuild/SOURCES/
rm -rf /home/ulyaoth/hhvm-3.5.2
cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/config.hdf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/hhvm.service"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/php.ini"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/server.hdf"
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/static.mime-types.hdf"
cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SPECS/ulyaoth-hhvm.spec"
yum-builddep -y ulyaoth-hhvm.spec
su ulyaoth -c "QA_SKIP_BUILD_ROOT=1 rpmbuild -bb ulyaoth-hhvm.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
su ulyaoth -c "rm -rf /home/ulyaoth/rpmbuild"
rm -rf /root/build-ulyaoth-hhvm.sh
