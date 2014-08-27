wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/build-ulyaoth-hhvm.sh ; chmod +x build-ulyaoth-hhvm.sh ; ./build-ulyaoth-hhvm.sh




OLD WAY:
How to create this rpm:

Do all this as your build user!

Step 1: Download the stable hhvm git.<br>
$ git clone -b HHVM-3.1 git://github.com/facebook/hhvm.git

Step 2: Rename the directory<br>
$ mv hhvm hhvm-3.1.1

Step 3: Download extra stuff<br>
you have to do this inside the "hhvm-3.1.1" directory<br>

$ git submodule update --init --recursive

Step 4: Tar the directory "hhvm-3.1.1"<br>
$ tar cvf hhvm-3.1.1.tar.gz hhvm-3.1.1/

Step 5: create rpmbuild directory<br>
$ rpmdev-setuptree

Step 6: Move tar.gz file into build directory<br>
$ mv hhvm-3.1.1.tar.gz /rpmbuild/SOURCES/

Step 7: download extra source files<br>
do this from "/rpmbuild/SOURCES/"<br>

$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/config.hdf<br>
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/hhvm.service<br>
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/php.ini<br>
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/server.hdf<br>
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SOURCES/static.mime-types.hdf<br>

Step 8: Download spec file<br>
do this in "/rpmbuild/SPECS/"<br>
$ wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-hhvm/SPECS/ulyaoth-hhvm.spec

Step 9: run the require install command<br>
$ sudo yum-builddep ulyaoth-hhvm.spec

Step 10: Create the rpm<br>
$ rpmbuild -bb ulyaoth-hhvm.spec
