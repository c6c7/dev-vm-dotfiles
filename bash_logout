echo "Backing up ~/work ..."
cd ~
c-restic backup work && echo "Backup complete."
