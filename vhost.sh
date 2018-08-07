#### Create new virtual host

# Create 7.0 host
sudo mkdir /var/www/html/putheng_io

# Create 5.6 host
sudo mkdir /var/www/html/putheng_net

echo "<?php phpinfo(); ?>" > /var/www/html/putheng_io/index.php

echo "<?php phpinfo(); ?>" > /var/www/html/putheng_net/index.php

cat <<EOF > /etc/nginx/sites-available/putheng_io
# Application with PHP 7.0
#
server {
	listen 80;

	root /var/www/html/putheng_io;
	index index.php index.html;

	server_name putheng.io;

	location ~* \.php\$ {
		# With php-fpm unix sockets
		fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
		fastcgi_index	index.php;
		include			fastcgi_params;
		fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
		fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
	}
}
EOF

cat <<EOF > /etc/nginx/sites-available/putheng_net
# Application with PHP 5.6
#
server {
	listen 80;

	root /var/www/html/putheng_net;
	index index.php index.html;

	server_name putheng.net;

	location ~* \.php\$ {
		# With php-fpm unix sockets
		fastcgi_pass unix:/var/run/php/php5.6-fpm.sock;
		fastcgi_index	index.php;
		include			fastcgi_params;
		fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
		fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
	}
}
EOF

sudo ln -s /etc/nginx/sites-available/putheng_io /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/putheng_net /etc/nginx/sites-enabled/

# Restart Nginx
sudo service nginx restart



