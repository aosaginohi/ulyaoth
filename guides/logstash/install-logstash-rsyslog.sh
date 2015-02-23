rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
cd /etc/yum.repos.d/
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/repository/logstash.repo
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/repository/elasticsearch.repo
yum install -y http://trash.ulyaoth.net/trash/rpm/ulyaoth-1.0.0-1.fc21.x86_64.rpm
yum install -y ulyaoth-nginx ulyaoth-kibana java elasticsearch logstash rsyslog tar wget policycoreutils-python zip
systemctl daemon-reload
cd /etc/logstash/conf.d
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/rsyslog/logstash.conf
chown logstash:logstash logstash.conf
mkdir -p /var/log/nginx/kibana
chown nginx:adm /var/log/nginx/kibana
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/nginx/vhost/kibana4.conf -O /etc/nginx/sites-available/kibana.conf
ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/kibana.conf
semanage port -a -t http_port_t -p tcp 9200
semanage port -a -t http_port_t -p tcp 5601
firewall-cmd --permanent --zone=FedoraServer --add-service=http
firewall-cmd --permanent --zone=FedoraServer --add-service=https
firewall-cmd --permanent --zone=FedoraServer --add-port=5544/udp
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