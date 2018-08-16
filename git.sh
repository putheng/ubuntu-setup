### Setup git hook

# Create git user
sudo adduser git

# give Git user a password:
passwd git

# logged in as the Git user
su git

# authorized keys file, and it resides in the dot folder "ssh".
mkdir ~/.ssh && touch ~/.ssh/authorized_keys

# add the key
cat .ssh/id_rsa.pub | ssh git@laravelspace.com "cat >> ~/.ssh/authorized_keys"

## to create ssh key in Mac or linux
#ssh-keygen -C "youremail@mailprovider.com"

# logged in as the root user
su

## create homes directory
mkdir homes

# change ownership from root to git
sudo chown -R git:git homes