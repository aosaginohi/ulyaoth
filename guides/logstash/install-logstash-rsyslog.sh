#!/bin/bash
# Argument = -h (shows the help information)
# Argument = -o (option .i.e install / uninstall)
# Created By: Sjir Bagmeijer - 2015/03/21
# Last Edit By: Sjir Bagmeijer - 2015/03/21
# https://community.ulyaoth.net

usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h  Shows this help information
   -o  Choose to "install" or "uninstall".
EOF
exit 1
}


repo()
{
echo "Step 1: adding the required repositories."
rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/repository/logstash.repo -O /etc/yum.repos.d/logstash.repo
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/repository/elasticsearch.repo  -O /etc/yum.repos.d/elasticsearch.repo
yum install -y https://trash.ulyaoth.net/trash/rpm/Fedora/x86_64/ulyaoth-1.0.2-1.fc22.x86_64.rpm
}

install()
{
echo "Step 2: installing the required packages."
yum install -y ulyaoth-nginx ulyaoth-kibana java elasticsearch logstash rsyslog tar wget policycoreutils-python zip
}

logstash()
{
echo "Step 3: Configuring Logstash."
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/rsyslog/logstash.conf -O /etc/logstash/conf.d/logstash.conf
chown logstash:logstash /etc/logstash/conf.d/logstash.conf
}

kibana()
{
echo "Step 4: Configuring Kibana."
mkdir -p /var/log/nginx/kibana
chown nginx:adm /var/log/nginx/kibana
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/nginx/vhost/kibana4.conf -O /etc/nginx/sites-available/kibana.conf
ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/kibana.conf
}

firewall()
{
echo "Step 5: Fixing your Firewall."
semanage port -a -t http_port_t -p tcp 9200
semanage port -a -t http_port_t -p tcp 5601
firewall-cmd --permanent --zone=FedoraServer --add-service=http
firewall-cmd --permanent --zone=FedoraServer --add-service=https
firewall-cmd --permanent --zone=FedoraServer --add-port=5544/udp
}

restartstart()
{
echo "Step 6: Enabling and starting all services."
systemctl daemon-reload
systemctl restart firewalld.service
systemctl enable elasticsearch.service
systemctl enable logstash.service
systemctl enable nginx.service
systemctl enable kibana.service
sleep 10
systemctl start elasticsearch.service
sleep 5
systemctl start logstash.service
sleep 5
systemctl start nginx.service
sleep 5
systemctl start kibana.service
}

uninstall()
{
echo "Preparing to uninstall Logstash."
systemctl disable elasticsearch.service
systemctl disable logstash.service
systemctl disable nginx.service
systemctl disable kibana.service
systemctl stop elasticsearch.service
systemctl stop logstash.service
systemctl stop nginx.service
systemctl stop kibana.service
rm -rf /etc/yum.repos.d/logstash.repo
rm -rf  /etc/yum.repos.d/elasticsearch.repo
yum remove -y ulyaoth-* logstash elasticsearch
rm -rf /etc/nginx
rm -rf /var/log/nginx
rm -rf /etc/logstash
rm -rf /var/log/logstash
rm -rf /var/lib/elasticsearch
rm -rf /var/lib/logstash
rm -rf /var/lib/yum/repos/x86_64/22/logstash-1.4
rm -rf /var/cache/dnf/x86_64/22/x86_64/22/logstash-1.4
rm -rf /var/cache/dnf/x86_64/22/x86_64/22/logstash-1.4-filenames.solvx
rm -rf /var/cache/dnf/x86_64/22/x86_64/22/logstash-1.4.solv
rm -rf /var/cache/yum/x86_64/22/logstash-1.4
rm -rf /opt/logstash
rm -rf /opt/kibana
rm -rf /var/cache/nginx
rm -rf /usr/share/elasticsearch
rm -rf /var/cache/dnf/x86_64/22/x86_64/22/elasticsearch-1.4
rm -rf /var/cache/yum/x86_64/22/elasticsearch-1.4
rm -rf /var/log/elasticsearch
rm -rf  /var/lib/yum/repos/x86_64/22/elasticsearch-1.4
rm -rf /var/cache/dnf/x86_64/22/x86_64/22/elasticsearch-1.4-filenames.solvx
rm -rf /var/cache/dnf/x86_64/22/x86_64/22/elasticsearch-1.4.solv
}

option=

while getopts h:o: opt; do
case $opt in
h)
  usage
;;
o)
  option=$OPTARG
;;
\?)
  usage
;;
:)
  usage
;;
esac
done

if [ "$option" == "install" ]
then
  repo
  install
  logstash
  kibana
  firewall
  restartstart
  echo "Your installation is finished now."
exit 1
elif [ "$option" == "uninstall" ]
then
  uninstall
  echo "Your uninstallation has finished."
exit 1
else
  usage
exit 1
fi