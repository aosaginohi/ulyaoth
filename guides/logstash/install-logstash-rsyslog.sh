yum install -y https://download.elasticsearch.org/logstash/logstash/packages/centos/logstash-1.4.2-1_2c0f5a1.noarch.rpm
yum install -y https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.Beta1.noarch.rpm
yum install -y nginx rsyslog tar wget policycoreutils-python zip java-1.8.0-openjdk.
cd /etc/logstash/conf.d
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/rsyslog/logstash.conf
chown logstash:logstash logstash.conf
mkdir -p /var/log/nginx/kibana
mkdir -p /etc/nginx/sites-available
mkdir -p /etc/nginx/sites-enabled
rm -rf /etc/nginx/nginx.conf
cd /etc/nginx/
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/nginx/conf/nginx.conf
cd /etc/nginx/sites-available/
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/nginx/vhost/kibana.conf
ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/kibana.conf
cd /opt
wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA1.1.tar.gz
tar xzfv kibana-4.0.0-BETA1.1.tar.gz
mv kibana-4.0.0-BETA1.1 kibana
rm -rf kibana-4.0.0-BETA1.1.tar.gz
useradd -s /sbin/nologin kibana
chown -R kibana:kibana /opt/kibana/
setsebool httpd_can_network_connect true 
semanage port -a -t http_port_t -p tcp 9200
firewall-cmd --zone=public --add-service=http
firewall-cmd --zone=public --add-service=https
firewall-cmd --zone=public --add-port=9200/tcp
firewall-cmd --zone=public --add-port=5544/udp
systemctl start elasticsearch.service
systemctl start logstash.service
systemctl start nginx.service
systemctl enable elasticsearch.service
systemctl enable logstash.service
systemctl enable nginx.service
chmod 755 /var/log/nginx