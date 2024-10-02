#!/bin/bash
sudo su
sudo yum update -y
sudo mkdir -p /var/www/html
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.my_efs.dns_name}:/ /var/www/html
sudo yum install -y httpd httpd-tools mod_ssl
sudo systemctl enable httpd 
sudo systemctl start httpd
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install php php-common php-pear -y
sudo yum install php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip} -y
sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install mysql-community-server -y
sudo systemctl enable mysqld
sudo systemctl start mysqld
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec  chmod 2775 {} \;
sudo find /var/www -type f -exec  chmod 0664 {} \;
sudo chown apache:apache -R /var/www/html 
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i "s/database_name_here/${aws_db_instance.my_db.db_name}/g" /var/www/html/wp-config.php
sudo sed -i "s/username_here/${aws_db_instance.my_db.username}/g" /var/www/html/wp-config.php
sudo sed -i "s/password_here/Loki7476/g" /var/www/html/wp-config.php
sudo sed -i "s/localhost/${aws_db_instance.my_db.endpoint}/g" /var/www/html/wp-config.php
sudo service httpd restart