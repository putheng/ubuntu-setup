#!/usr/bin/env python3.6
import os

import sys
#sys.argv[0]

## Clear the console.
os.system("clear")

os.system("cd ~")

server_parent_dir = "/var/www/html"

## Domain directory
domain_dir = "/cambodiahr_xyz"

## Domain name
domain = "cambodiahr.xyz"

## Chceck and set name of the public directory.
public_dir = "/public"

## Creating the Directory Structure
os.system("sudo mkdir -p "+server_parent_dir+domain_dir+public_dir)

## Granting Proper Permissions
os.system("sudo chown -R $USER:$USER "+server_parent_dir+domain_dir+public_dir)

## Making Sure Read Access is Permitted
os.system("sudo chmod -R 755 "+server_parent_dir+domain_dir+public_dir)

## Adding A Demo Page

file_object = open(server_parent_dir+domain_dir+public_dir+"/index.php", "w")
file_object.write("<?php \n\tphpinfo(); \n?>")
file_object.close()

## Creating Virtual Host File
host_file = open("/tmp/"+domain_dir, "w")
host_file.write("server {\n\tlisten 80;\n\n\troot /var/www/html"+ domain_dir+public_dir +";\n\tindex index.php index.html;\n\n\tserver_name "+ domain +";\n\n\tlocation ~* \.php$ {\n\t\tfastcgi_pass unix:/var/run/php/php7.2-fpm.sock;\n\t\tfastcgi_index	index.php;\n\t\tinclude			fastcgi_params;\n\t\tfastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;\n\t\tfastcgi_param   SCRIPT_NAME        $fastcgi_script_name;\n\t}\n}")
host_file.close()
os.system("sudo mv \"/tmp/"+domain_dir+"\" \"/etc/nginx/sites-available/\"")

## Activating New Virtual Host
os.system("sudo ln -s /etc/nginx/sites-available/"+domain_dir+" /etc/nginx/sites-enabled/")

# Restart Nginx
os.system("sudo service nginx restart")
