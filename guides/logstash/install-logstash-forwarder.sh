sudo rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
cd /etc/yum.repos.d/
sudo wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/repository/logstash.repo
sudo wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/repository/elasticsearch.repo
sudo yum install -y http://trash.ulyaoth.net/trash/rpm/ulyaoth-1.0.0-1.fc21.x86_64.rpm
sudo yum install -y ulyaoth-nginx ulyaoth-kibana ulyaoth-logstash-forwarder java elasticsearch logstash rsyslog tar wget policycoreutils-python zip
sudo systemctl daemon-reload
cd /etc/logstash/conf.d
sudo wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/logstash-forwarder/conf/logstash.conf
sudo chown logstash:logstash logstash.conf
sudo mkdir -p /var/log/nginx/kibana
sudo chown nginx:adm /var/log/nginx
sudo wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/nginx/vhost/kibana4.conf -O /etc/nginx/sites-available/kibana.conf
sudo ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/kibana.conf
cd /opt/logstash-forwarder/ssl
sudo openssl req -x509 -subj '/CN=*.ulyaoth.net/' -nodes -newkey rsa:4096 -keyout logstash-forwarder.key -out logstash-forwarder.crt && chown lforward:lforward *
sudo semanage port -a -t http_port_t -p tcp 9200
sudo semanage port -a -t http_port_t -p tcp 5601
firewall-cmd --permanent --zone=FedoraServer --add-service=http
firewall-cmd --permanent --zone=FedoraServer --add-service=https
firewall-cmd --permanent --zone=FedoraServer --add-port=5544/udp
sudo systemctl restart firewalld.service
sudo systemctl enable elasticsearch.service
sudo systemctl enable logstash.service
sudo systemctl enable logstash-forwarder.service
sudo systemctl enable nginx.service
sudo systemctl enable kibana.service
sleep 10
sudo systemctl start elasticsearch.service
sleep 5
sudo systemctl start logstash.service
sleep 5
sudo systemctl start logstash-forwarder.service
sleep 5
sudo systemctl start nginx.service
sleep 5
sudo systemctl start kibana.service