buildarch="$(uname -m)"

useradd ulyaoth
usermod -Gulyaoth ulyaoth
cd /home/ulyaoth/
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SPECS
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-mbedtls/SPECS/ulyaoth-mbedtls.spec"

if grep -q -i "release 19" /etc/fedora-release
then
  if [ "$arch" != "x86_64" ]
  then
    yum install https://trash.ulyaoth.net/trash/rpm/Fedora/i686/ulyaoth-1.0.5-1.fc19.i686.rpm
  else
    yum install https://trash.ulyaoth.net/trash/rpm/Fedora/x86_64/ulyaoth-1.0.5-1.fc19.x86_64.rpm
  fi
elif grep -q -i "release 20" /etc/fedora-release
then
  if [ "$arch" != "x86_64" ]
  then
    yum install https://trash.ulyaoth.net/trash/rpm/Fedora/i686/ulyaoth-1.0.5-1.fc20.i686.rpm
  else
    yum install https://trash.ulyaoth.net/trash/rpm/Fedora/x86_64/ulyaoth-1.0.5-1.fc20.x86_64.rpm
  fi
elif grep -q -i "release 21" /etc/fedora-release
then
  if [ "$arch" != "x86_64" ]
  then
    yum install https://trash.ulyaoth.net/trash/rpm/Fedora/i686/ulyaoth-1.0.5-1.fc21.i686.rpm
  else
    yum install https://trash.ulyaoth.net/trash/rpm/Fedora/x86_64/ulyaoth-1.0.5-1.fc21.x86_64.rpm
  fi
elif grep -q -i "release 22" /etc/fedora-release
then
  if [ "$arch" != "x86_64" ]
  then
    dnf install https://trash.ulyaoth.net/trash/rpm/Fedora/i686/ulyaoth-1.0.5-1.fc22.i686.rpm
  else
    dnf install https://trash.ulyaoth.net/trash/rpm/Fedora/x86_64/ulyaoth-1.0.5-1.fc22.x86_64.rpm
  fi
elif grep -q -i "rhel" /etc/ulyaoth && grep -q -i "release 6" /etc/redhat-release
then
  if [ "$arch" != "x86_64" ]
  then
    yum install https://trash.ulyaoth.net/trash/rpm/rhel/i686/ulyaoth-1.0.5-1.el6.i686.rpm
  else
    yum install https://trash.ulyaoth.net/trash/rpm/rhel/x86_64/ulyaoth-1.0.5-1.el6.x86_64.rpm
  fi  
elif grep -q -i "rhel" /etc/ulyaoth && grep -q -i "release 7" /etc/redhat-release
then
  yum install https://trash.ulyaoth.net/trash/rpm/rhel/x86_64/ulyaoth-1.0.5-1.el7.x86_64.rpm
elif grep -q -i "CentOS" /etc/ulyaoth && grep -q -i "release 6" /etc/centos-release
then
  if [ "$arch" != "x86_64" ]
  then
    yum install https://trash.ulyaoth.net/trash/rpm/CentOS/i686/ulyaoth-1.0.5-1.el6.i686.rpm
  else
    yum install https://trash.ulyaoth.net/trash/rpm/CentOS/x86_64/ulyaoth-1.0.5-1.el6.x86_64.rpm
  fi
elif grep -q -i "CentOS" /etc/ulyaoth && grep -q -i "release 7" /etc/redhat-release
then
  yum install https://trash.ulyaoth.net/trash/rpm/CentOS/x86_64/ulyaoth-1.0.5-1.el7.centos.x86_64.rpm
elif grep -q -i "OracleLinux" /etc/ulyaoth && grep -q -i "release 6" /etc/oracle-release
then
  if [ "$arch" != "x86_64" ]
  then
    yum install https://trash.ulyaoth.net/trash/rpm/OracleLinux/i686/ulyaoth-1.0.5-1.el6.i686.rpm
  else
    yum install https://trash.ulyaoth.net/trash/rpm/OracleLinux/x86_64/ulyaoth-1.0.5-1.el6.x86_64.rpm
  fi
elif grep -q -i "OracleLinux" /etc/ulyaoth && grep -q -i "release 7" /etc/oracle-release
then
  yum install https://trash.ulyaoth.net/trash/rpm/OracleLinux/x86_64/ulyaoth-1.0.5-1.el7.x86_64.rpm
fi

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-mbedtls.spec
fi

if grep -q -i "release 22" /etc/fedora-release
then
dnf builddep -y ulyaoth-mbedtls.spec
else
yum-builddep -y ulyaoth-mbedtls.spec
fi

su ulyaoth -c "spectool ulyaoth-mbedtls.spec -g -R"
su ulyaoth -c "rpmbuild -bb ulyaoth-mbedtls.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/
rm -rf /root/build-ulyaoth-mbedtls.sh
rm -rf /home/ulyaoth/rpmbuild