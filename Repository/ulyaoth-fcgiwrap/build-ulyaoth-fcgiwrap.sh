useradd ulyaoth
cd /home/ulyaoth/
su ulyaoth -c "rpmdev-setuptree"
su ulyaoth -c "git clone https://github.com/gnosek/fcgiwrap"
su ulyaoth -c "sed -i 's/http/fcgiwrap/g' /home/ulyaoth/fcgiwrap/systemd/fcgiwrap.service"
su ulyaoth -c "rm -rf /home/ulyaoth/fcgiwrap/.git/"
su ulyaoth -c "tar cvf fcgiwrap.tar.gz fcgiwrap"
su ulyaoth -c "mv fcgiwrap.tar.gz /home/ulyaoth/rpmbuild/SOURCES/"
cd /home/ulyaoth/rpmbuild/SPECS/
su ulyaoth -c "wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-fcgiwrap/SPEC/ulyaoth-fcgiwrap.spec"
yum-builddep -y /home/ulyaoth/rpmbuild/SPECS/ulyaoth-fcgiwrap.spec
su ulyaoth -c "rpmbuild -bb ulyaoth-fcgiwrap.spec"
cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
rm -rf /home/ulyaoth/rpmbuild/
rm -rf /etc/nginx
rm -rf /root/build-ulyaoth-fcgiwrap.sh
