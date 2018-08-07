# Add the PHP 7 Repositories
sudo add-apt-repository ppa:ondrej/php

#If you’re missing add-apt-repository, like some plain systems are, 
#install it and then add-apt-repository ppa:ondrej/php
sudo apt-get install software-properties-common
sudo apt-get install python-software-properties

# Update
sudo apt-get update

# Install Nginx
sudo apt-get -y install unzip zip nginx

# Install PHP 7.2 FPM
sudo apt-get -y install php7.2 php7.2-fpm php7.2-mysql php7.2-mbstring php7.2-xml php7.2-curl

# Install PHP 7.0 FPM
sudo apt-get -y install php7.0 php7.0-fpm php7.0-mysql php7.0-mbstring php7.0-xml php7.0-curl

# Install PHP 5.5 FPM
sudo apt-get -y install php5.6 php5.6-fpm

# Restart PHP
sudo service php7.2-fpm restart
sudo service php7.0-fpm restart
sudo service php5.6-fpm restart

# Set MySql User, Password
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# Install MySql
sudo apt-get install -y mysql-server

# Remove default Nginx host
rm -f /etc/nginx/sites-enabled/default

# Create default host
sudo mkdir /var/www
sudo mkdir /var/www/html
sudo mkdir /var/www/html/default

echo "<?php phpinfo(); ?>" > /var/www/html/default/index.php

#### Create new default host

cat <<EOF > /etc/nginx/sites-available/default
# Application with PHP 7.2
#
server {
	listen 80;

	root /var/www/html/default;
	index index.php index.html;

	server_name putheng.com;

	location ~* \.php\$ {
		# With php-fpm unix sockets
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
		fastcgi_index	index.php;
		include			fastcgi_params;
		fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
		fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
	}
}
EOF

sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Restart Nginx
sudo service nginx restart





