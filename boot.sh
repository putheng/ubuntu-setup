# Add the PHP 7 Repositories
sudo add-apt-repository ppa:ondrej/php

#If you’re missing add-apt-repository, like some plain systems are, 
#install it and then add-apt-repository ppa:ondrej/php
sudo apt-get -y install software-properties-common
sudo apt-get -y install python-software-properties

# Update
sudo apt-get update

#Install Git
sudo apt-get install -y git

# Install Nginx
sudo apt-get -y install unzip zip nginx

# Install PHP 7.2 FPM
sudo apt-get -y install php7.2 php7.2-fpm php7.2-mysql php7.2-mbstring php7.2-xml php7.2-curl

# Install PHP 7.1 FPM
sudo apt-get -y install php7.1 php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip php7.1-fpm

# Install PHP 7.0 FPM
sudo apt-get -y install php7.0 php7.0-fpm php7.0-mysql php7.0-mbstring php7.0-xml php7.0-curl

# Install PHP 5.5 FPM
sudo apt-get -y install php5.6 php5.6-fpm

# Restart PHP
sudo service php7.2-fpm restart
sudo service php7.1-fpm restart
sudo service php7.0-fpm restart
sudo service php5.6-fpm restart

# Update
sudo apt-get update

# Set MySql User, Password will be root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# Install MySql
sudo apt-get install -y mysql-server

# Install Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

## Setup HHVM
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449

# HHVM's repository
sudo add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main"

# Update
sudo apt-get update

# Install HHVM
sudo apt-get -y install hhvm

#script which makes the integration with Nginx
sudo /usr/share/hhvm/install_fastcgi.sh

#=== Config Nginx to know HHVM
# Change on Nginx sites enabled ==> fastcgi_pass   127.0.0.1:9000;



# Remove default Nginx host
rm -f /etc/nginx/sites-enabled/default

# Create default host
sudo mkdir -p /var/www
sudo mkdir -p /var/www/html
sudo mkdir -p /var/www/html/default

echo "<?php phpinfo(); ?>" > /var/www/html/default/index.php

#### Create new default host

cat <<EOF > /etc/nginx/sites-available/default
# Application with PHP 7.2
#
server {
	listen 80;

	root /var/www/html/default;
	index index.php index.html;

	server_name laravelspace.com;

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





