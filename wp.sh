#!/bin/bash
sudo apt update
sudo apt install -y apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
sudo apt-get install -y curl
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
sudo touch /etc/apache2/sites-available/wordpress.conf
sudo chmod 666 /etc/apache2/sites-available/wordpress.conf
echo "<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>" > /etc/apache2/sites-available/wordpress.conf
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
read -p "Adatbázis neve:" dataname
sudo -u www-data sed -i "s/database_name_here/$dataname/" /srv/www/wordpress/wp-config.php
read -p "MySQL felhasználónév:" username
sudo -u www-data sed -i "s/username_here/$username/" /srv/www/wordpress/wp-config.php
read -p "MySQL jelszó:" sqlpass
sudo -u www-data sed -i "s/password_here/$sqlpass/" /srv/www/wordpress/wp-config.php
read -p "MySQL IP cím:" ipaddr
sudo -u www-data sed -i "s/localhost/$ipaddr/" /srv/www/wordpress/wp-config.php

