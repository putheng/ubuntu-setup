#!/bin/sh

## Create repository directory
mkdir -p /var/repositories/putheng/laravelspace_com.git

cd /var/repositories/putheng/laravelspace_com.git

## Init repository
git init --bare

## Write script to hook directory
cat <<EOF > /tmp/post-receive
#!/bin/sh
git --work-tree=/var/www/html/default --git-dir=/var/repositories/putheng/laravelspace_com.git checkout -f
EOF

## set post-receive to execute permisstion
sudo chmod +x /tmp/post-receive

## Move post-receive from tmp folder to repository directory
mv /tmp/post-receive /var/repositories/putheng/laravelspace_com.git/hooks

## Add remote to local repository
#
# git remote add live ssh://root@laravelspace.com/var/repositories/putheng/laravelspace_com.git
#
###