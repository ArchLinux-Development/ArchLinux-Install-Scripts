#!/bin/bash

# Ensure you have root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Check for active network connection
echo "Checking network connection..."
if ! ping -c 1 archlinux.org &> /dev/null; then
  echo "No network connection detected. Please set up your network connection."
  wifi-menu
  if ! ping -c 1 archlinux.org &> /dev/null; then
    echo "Network setup failed. Exiting."
    exit 1
  fi
fi

# Update system clock
timedatectl set-ntp true

# List available storage devices
echo "Available storage devices:"
lsblk

# Prompt for the storage device to use
read -p "Enter the device to install Arch Linux on (e.g., /dev/sda): " dev

# Ensure the user has provided a valid device
if [ ! -b "$dev" ]; then
  echo "Invalid device: $dev"
  exit 1
fi

# Prompt for username and password
read -p "Enter your username: " username

while true; do
  read -s -p "Enter your password: " password
  echo
  read -s -p "Confirm your password: " password_confirm
  echo
  [ "$password" = "$password_confirm" ] && break
  echo "Passwords do not match. Please try again."
done

# Encrypt the password
encrypted_password=$(openssl passwd -6 "$password")

# Partition the disk
echo "Partitioning the disk..."
parted -s "$dev" mklabel gpt
parted -s "$dev" mkpart primary fat32 1MiB 512MiB
parted -s "$dev" set 1 esp on
parted -s "$dev" mkpart primary 512MiB 100%

# Format the partitions
echo "Formatting the partitions..."
mkfs.fat -F32 "${dev}1"
partprobe "$dev"

# Install essential packages for ZFS
echo "Installing essential packages for ZFS..."
pacman -Syu --noconfirm linux-headers
pacman -S --noconfirm zfs-dkms zfs-utils

# Load the ZFS module
echo "Loading ZFS kernel module..."
modprobe zfs

# Create ZFS pool and datasets
echo "Creating ZFS pool and datasets..."
zpool create -f -o ashift=12 zroot "${dev}2"
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=/ zroot/ROOT/default
zfs create -o mountpoint=/home zroot/home
zfs create -o mountpoint=/root zroot/root
zfs create -o mountpoint=/var zroot/var
zfs create -o mountpoint=/var/log zroot/var/log
zfs create -o mountpoint=/var/cache zroot/var/cache
zfs create -o mountpoint=/srv zroot/srv
zfs create -o mountpoint=/tmp zroot/tmp
zfs create -o mountpoint=/opt zroot/opt
zfs create -o mountpoint=/usr/local zroot/usr/local

# Mount the ZFS filesystems
echo "Mounting ZFS filesystems..."
zpool set bootfs=zroot/ROOT/default zroot
zfs set mountpoint=legacy zroot/ROOT/default
zfs set mountpoint=legacy zroot/home
zfs set mountpoint=legacy zroot/root
zfs set mountpoint=legacy zroot/var
zfs set mountpoint=legacy zroot/var/log
zfs set mountpoint=legacy zroot/var/cache
zfs set mountpoint=legacy zroot/srv
zfs set mountpoint=legacy zroot/tmp
zfs set mountpoint=legacy zroot/opt
zfs set mountpoint=legacy zroot/usr/local

mount -t zfs zroot/ROOT/default /mnt
mkdir -p /mnt/{home,root,var/log,var/cache,srv,tmp,opt,usr/local}
mount -t zfs zroot/home /mnt/home
mount -t zfs zroot/root /mnt/root
mount -t zfs zroot/var /mnt/var
mount -t zfs zroot/var/log /mnt/var/log
mount -t zfs zroot/var/cache /mnt/var/cache
mount -t zfs zroot/srv /mnt/srv
mount -t zfs zroot/tmp /mnt/tmp
mount -t zfs zroot/opt /mnt/opt
mount -t zfs zroot/usr/local /mnt/usr/local
mkdir /mnt/boot
mount "${dev}1" /mnt/boot

# Install essential packages
echo "Installing essential packages..."
pacstrap /mnt base linux linux-firmware zfs-dkms zfs-utils grub grub-btrfs rsync efibootmgr snapper reflector snap-pac zram-generator sudo micro xorg-server xorg-apps git plasma-meta plasma-wayland-session kde-utilities kde-system dolphin-plugins kde-graphics neofetch zsh man-db man-pages texinfo samba chromium nano sddm sddm-kcm gnome-disk-utility ksysguard kate xorg plasma plasma-wayland-session kde-applications

# Generate fstab (will be empty, using ZFS mountpoints)
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the new system
arch-chroot /mnt /bin/bash <<EOF

# Set timezone
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

# Localization
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Network configuration
echo "archlinux" > /etc/hostname
cat << EOL > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   archlinux.localdomain archlinux
EOL

# Set root password
echo "root:${encrypted_password}" | chpasswd -e

# Create user
useradd -m -G wheel -s /bin/zsh $username
echo "${username}:${encrypted_password}" | chpasswd -e
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Install bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable necessary services
systemctl enable sddm
systemctl enable NetworkManager
systemctl enable zram-generator

# ZFS-related configurations
systemctl enable zfs.target
systemctl enable zfs-import-cache
systemctl enable zfs-mount
systemctl enable zfs-import.target

EOF

# Unmount all partitions and reboot
umount -R /mnt
reboot