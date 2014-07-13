How to create this rpm:

Do all this as your build user!

Step 1: Download the stable hhvm git
$ git clone -b HHVM-3.1 git://github.com/facebook/hhvm.git

Step 2: Rename the directory
$ mv hhvm hhvm-3.1.1

Step 3: Download extra stuff
you have to do this inside the "hhvm-3.1.1" directory

$ git submodule update --init --recursive

Step 4: Tar the directory "hhvm-3.1.1"
$ tar cvf hhvm-3.1.1.tar.gz hhvm-3.1.1/

Step 5: create rpmbuild directory
$ rpmdev-setuptree

Step 6: Move tar.gz file into build directory
$ mv hhvm-3.1.1.tar.gz /rpmbuild/SOURCES/

Step 7: download extra source files
do this from "/rpmbuild/SOURCES/"

$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/config.hdf
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/hhvm.service
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/php.ini
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/server.hdf
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/static.mime-types.hdf

Step 8: Download spec file
do this in "/rpmbuild/SPECS/"
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SPECS/ulyaoth-hhvm.spec

Step 9: run the require install command
$ sudo yum-builddep ulyaoth-hhvm.spec

Step 10: Create the rpm
$ rpmbuild -bb ulyaoth-hhvm.spec
