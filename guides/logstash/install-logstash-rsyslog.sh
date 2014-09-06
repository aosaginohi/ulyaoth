yum install -y https://download.elasticsearch.org/logstash/logstash/packages/centos/logstash-1.4.2-1_2c0f5a1.noarch.rpm
yum install -y https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.noarch.rpm
yum install -y nginx rsyslog tar wget vim policycoreutils-python zip
cd /etc/logstash/conf.d
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/rsyslog/logstash.conf
chown logstash:logstash logstash.conf
mkdir -p /var/log/nginx/kibana
mkdir -p /usr/share/nginx/kibana/public
mkdir -p /etc/nginx/sites-available
mkdir -p /etc/nginx/sites-enabled
rm -rf /etc/nginx/nginx.conf
cd /etc/nginx/
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/nginx/conf/nginx.conf
cd /etc/nginx/sites-available/
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/nginx/vhost/kibana.conf
ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/kibana.conf
cd /usr/share/nginx/kibana/public
wget https://download.elasticsearch.org/kibana/kibana/kibana-latest.tar.gz
tar xzfv kibana-latest.tar.gz
mv kibana-latest/* .
rm -rf kibana-latest.tar.gz
rm -rf kibana-latest
sed -i 's/default.json/ulyaoth.json/' config.js
cd /usr/share/nginx/kibana/public/app/dashboards
wget https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/logstash/kibana/dashboard/ulyaoth.json
useradd -s /sbin/nologin kibana
chown -R kibana:nginx /usr/share/nginx/kibana/
chcon -R -t httpd_sys_content_t /usr/share/nginx/kibana/public/
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