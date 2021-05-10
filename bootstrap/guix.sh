set -e

# https://guix.gnu.org/manual/en/guix.html#Binary-Installation-1
cd /tmp
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh

wget "https://sv.gnu.org/people/viewgpg.php?user_id=15145" -qO - | sudo -i gpg --import -
wget "https://sv.gnu.org/people/viewgpg.php?user_id=127547" -qO - | sudo -i gpg --import -

./guix-install.sh

# Log out and log in

parted /dev/sdb \
  mklabel gpt \
  set 1 boot on \
  mkpart esp 1049KB 11.5MB \
  mkpart root ext4 11.5MB 10GB \
  mkpart swap linux-swap 10GB 12GB \
  mkpart home 12GB 100% \
  align-check optimal 1 \
  align-check optimal 2 \
  align-check optimal 3 \
  align-check optimal 4 \
  unit compact p

mkfs.fat -F16 /dev/sdb1
mkfs.ext4 -L root /dev/sdb2
mkfs.ext4 -L home /dev/sdb4

mount /dev/sdb2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sdb1 /mnt/boot/efi
mkdir -p /mnt/home
mount /dev/sdb4 /mnt/home


mkswap /dev/sdb3
swapon /dev/sdb3

#### cow-store.sh

TARGET=/mnt
BACKING_DIR=/tmp/guix-inst
STORE_PREFIX=/gnu/store

tmpdir=$TARGET/tmp
mkdir -p $tmpdir
mount --bind /tmp $tmpdir
rwdir=$TARGET/$BACKING_DIR
workdir=$rwdir/../.overlayfs-workdir

mkdir -p $rwdir
mkdir -p $workdir
mkdir -p /.rw-store

chown 30000 $rwdir
chmod 1775 $rwdir
chown 30000 /.rw-store
chmod 1775 /.rw-store

mount --make-private /

mount -t overlay overlay -o lowerdir=$STORE_PREFIX,upperdir=$rwdir,workdir=$workdir /.rw-store
mount --move /.rw-store $STORE_PREFIX
rmdir /.rw-store

####

guix system init /home/ec2-user/dev-vm-dotfiles/bootstrap/config.scm /mnt
