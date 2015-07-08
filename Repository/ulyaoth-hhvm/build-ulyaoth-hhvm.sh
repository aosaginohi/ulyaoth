# Set Variables
hhvmversion=3.7.3
hhvmbranchversion=3.7

# Create build user
useradd ulyaoth &> /dev/null

hhvm()
{
cd /home/ulyaoth
su ulyaoth -c "git clone -b HHVM-'"$hhvmbranchversion"' git://github.com/facebook/hhvm.git"
mv /home/ulyaoth/hhvm /home/ulyaoth/hhvm-$hhvmversion
cd /home/ulyaoth/hhvm-$hhvmversion
su ulyaoth -c "git checkout HHVM-'"$hhvmversion"'"
su ulyaoth -c "git submodule update --init --recursive"
cd /home/ulyaoth
su ulyaoth -c "tar cvf hhvm-'"$hhvmversion"'.tar.gz hhvm-'"$hhvmversion"'/"
mv /home/ulyaoth/hhvm-$hhvmversion.tar.gz /home/ulyaoth/rpmbuild/SOURCES/
} &> /dev/null

preparebuild()
{
cd /home/ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SPECS/ulyaoth-hhvm.spec"
installrequirements &
} &> /dev/null

installrequirements()
{
if grep -q -i "release 7" /etc/redhat-release
then
yum install -y  http://mirror.nsc.liu.se/fedora-epel/7/x86_64/e/epel-release-7-5.noarch.rpm
fi

if grep -q -i "release 22" /etc/fedora-release
then
dnf builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-hhvm.spec
else
yum-builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-hhvm.spec
fi

su ulyaoth -c "spectool /home/ulyaoth/rpmbuild/SPECS/ulyaoth-hhvm.spec -g -R"
} &> /dev/null

build()
{
su ulyaoth -c "QA_SKIP_BUILD_ROOT=1 rpmbuild -bb /home/ulyaoth/rpmbuild/SPECS/ulyaoth-hhvm.spec"
}

clean()
{
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
rm -rf /home/ulyaoth/hhvm-$hhvmversion
rm -rf /home/ulyaoth/rpmbuild
cd /root
} &> /dev/null

echo "Step 1: Starting the HHVM Download process in background."
hhvm &
echo "Step 2: Downloading & installing all requirements for HHVM."
preparebuild &
echo "Waiting for Step 1 and Step 2 to finish before building.(This can take up to 30 minutes depending on your download speed)"
wait

echo "Step 3: Building the HHVM RPM. (This can take up to 1 hour or longer depending on your build machine)"
build
echo "Step 4: Cleaning your build environment."
clean

echo "Your RPM has been created and placed in your root directory."
exit