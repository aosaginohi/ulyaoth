buildarch="$(uname -m)"
bananaversion=1.5.0

useradd ulyaoth
cd /home/ulyaoth

if grep -q -i "release 22" /etc/fedora-release
then
dnf install -y ant
else
yum install -y ant
fi

su ulyaoth -c "rpmdev-setuptree"
su ulyaoth -c "wget https://github.com/LucidWorks/banana/archive/v'"$bananaversion"'.tar.gz"
su ulyaoth -c "tar xvzf v'"$bananaversion"'.tar.gz"
su ulyaoth -c "mkdir -p /home/ulyaoth/banana-'"$bananaversion"'/build"
cd /home/ulyaoth/banana-$bananaversion
su ulyaoth -c "ant"
mv /home/ulyaoth/banana-$bananaversion/build/banana-0.war /home/ulyaoth/rpmbuild/SOURCES/banana.war

cd /home/ulyaoth/rpmbuild/SOURCES/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-banana/SOURCES/banana-context.xml"

cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-banana/SPECS/ulyaoth-banana.spec"

if [ "$arch" != "x86_64" ]
then
sed -i '/BuildArch: x86_64/c\BuildArch: '"$buildarch"'' ulyaoth-banana.spec
fi

su ulyaoth -c "rpmbuild -bb ulyaoth-banana.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/