#!/bin/bash
sudo apt-get update
sudo apt install -y mysql-server

sudo mysql -u root -e "CREATE DATABASE wordpress;"
sudo mysql -u root -e  "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'ubuntu';"
sudo mysql -u root -e  "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';"
sudo mysql -u root -e  "CREATE USER 'wpuser'@'192.168.0.31' IDENTIFIED BY 'ubuntu';"
sudo mysql -u root -e  "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'192.168.0.31';"
sudo mysql -u root -e  "FLUSH PRIVILEGES;"
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
sudo ufw allow from 192.168.0.31 to any port 3306
