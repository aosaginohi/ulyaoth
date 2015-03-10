#!/bin/bash
# Argument = -h (shows the help information)
# Argument = -package (package name .i.e ulyaoth-nginx)

usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -help      Show this message
   -package      Add the name of the package that should be build
EOF
}

EXTENSIONS=
while getopts "help:package" OPTION
do
  case $OPTION in
help)
  usage
  exit 1
;;
package)
package=$1
;;
?)
  usage
  exit
;;
esac
done

if [[ -z EXTENSIONS ]]
then
  usage()
  exit 1
fi


echo $package