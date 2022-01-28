#!/bin/bash
sudo apt-get update
sudo apt install -y mysql-server
read -p "Adatbázis neve:" dataname
sudo mysql -u root -e "CREATE DATABASE $dataname;"
read -p "MySQL felhasználónév:" username
read -p "MySQL jelszó:" sqlpass
read -p "MySQL IP cím:" ipaddr
sudo mysql -u root -e  "CREATE USER '$username'@'localhost' IDENTIFIED BY '$sqlpass';"
sudo mysql -u root -e  "GRANT ALL PRIVILEGES ON $dataname.* TO '$username'@'localhost';"
sudo mysql -u root -e  "CREATE USER '$username'@'$ipaddr' IDENTIFIED BY '$sqlpass';"
sudo mysql -u root -e  "GRANT ALL PRIVILEGES ON $dataname.* TO '$username'@'$ipaddr';"
sudo mysql -u root -e  "FLUSH PRIVILEGES;"
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
#sudo ufw allow from $ipaddr to any port 3306
