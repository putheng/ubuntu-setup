cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    listen 443 ssl http2;
    server_name .laravelspace.io;
    root "/home/vagrant/sites/laravelspace/public";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/laravelspace.io-error.log error;

    sendfile off;

    client_max_body_size 100m;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~ /\.ht {
        deny all;
    }

    ssl_certificate     /etc/nginx/ssl/laravelspace.io.crt;
    ssl_certificate_key /etc/nginx/ssl/laravelspace.io.key;
}
EOF


## Change the group ownership of the storage and bootstrap/cache directories to www-data.
sudo chgrp -R www-data /var/www/html/default/bootstrap/cache

sudo chgrp -R www-data /var/www/html/default/storage 

## Recursively grant all permissions, including write and execute, to the group.
sudo chmod -R ug+rwx /var/www/html/default/bootstrap/cache

sudo chmod -R ug+rwx /var/www/html/default/storage 




