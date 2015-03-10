#!/bin/bash
# Argument = -h (shows the help information)
# Argument = -b (package name .i.e ulyaoth-nginx)
# Argument = -u (user name)
# Argument = -p (port)
# Argument = -r (repository)

arch="$(uname -m)"

if [ ! -f /etc/redhat-release ];
then
  serveros="$(grep -Eo '^[^ ]+' /etc/centos-release)"
else
  serveros="$(grep -Eo '^[^ ]+' /etc/redhat-release)"
fi

usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h  Shows this help information
   -b  Package name input (.i.e ulyaoth-nginx)
   -u  User name input for repository connection
   -p  Port input for ssh
   -r  Repository connection input
EOF
}

# Build the Package: ulyaoth
ulyaoth()
{
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth/build-ulyaoth.sh ; chmod +x build-ulyaoth.sh ; ./build-ulyaoth.sh
}

# Move package to repository server
scppackage()
{
if (($serveros == "Fedora")) && (($arch == "x86_64"))
then

  ssh -i $username.pem -o StrictHostKeyChecking=no -p $port $username@$repository "mkdir -p /home/$username/createrpm/fedora/64"
  scp -i $username.pem -o StrictHostKeyChecking=no -P $port /root/*.rpm $username@$repository:/home/$username/createrpm/fedora/64/
  ssh -i $username.pem -o StrictHostKeyChecking=no -p $port $username@$repository "chown -R $username:$username /home/$username/createrpm/"

elif (($serveros == "Fedora")) && ((($arch == "i386")) || (($arch == "i686")))
then
  echo Fedora 32-bit
elif (($serveros == "Red")) && (($arch == "x86_64"))
then
  echo Red Hat 64-bit
elif (($serveros == "Red")) && ((($arch == "i386")) || (($arch == "i686")))
then
 echo Red Hat 32-bit
elif (($serveros == "CentOS")) && (($arch == "x86_64"))
then
  echo CentOS 64-bit
elif (($serveros == "CentOS")) && ((($arch == "i386")) || (($arch == "i686")))
then
  echo CentOS 32-bit
else
  Unsupported OS!!!
fi
}

package=

while getopts h:b:u:p:r:s: opt; do
case $opt in
h)
  usage
;;
b)
  package=$OPTARG
;;
u)
  username=$OPTARG
;;
p)
  port=$OPTARG
;;
r)
  repository=$OPTARG
;;
esac
done

$package
scppackage