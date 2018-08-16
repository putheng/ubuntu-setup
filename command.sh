
### Change folder permissions and ownership

sudo chown -R git:git directory
#will change ownership (both user and group) of all files and directories 
#inside of directory and directory itself.

sudo chown username:group directory
#will only change the permission of the folder directory 
#but will leave the files and folders inside the directory alone.