#!/bin/bash
# Argument = -h (shows the help information)
# Argument = -p (package name .i.e ulyaoth-nginx)

usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h      Show this message
   -E      Package name .i.e ulyaoth-nginx
EOF
}

package=

while getopts p:h: opt; do
case $opt in
p)
  package=$OPTARG
;;
h)
  usage
;;
esac
done

shift $((OPTIND - 1))

if [ -z package ]
then
     usage
fi

echo $package