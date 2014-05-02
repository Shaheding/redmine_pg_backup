#!/bin/sh

backuppath=/tmp/redmine
tempdir=$(date +"%y_%m_%d_%H_%M_%S")
redminehome=REDMINE_INSTALL_DIR
redminedb=REDMINE_DB_NAME
keyfile=PATH_TO_PRIVATE_KEY
username=USERNAME
path=DEST_DIRECTORY_PATH
url=RSYNC_SERVER_URL
port=22

mkdir -p $backuppath/$tempdir
sudo -u postgres pg_dump $redminedb | gzip > $backuppath/$tempdir/db.gz
rsync -a $redminehome/files $backuppath/$tempdir
rsync -Cavz --delete-after -e "ssh -i $keyfile -p$port" $backuppath/$tempdir  $username@$url:.$path
