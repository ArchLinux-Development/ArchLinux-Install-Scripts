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
parted -s "$dev" mkpart primary btrfs 512MiB 100%

# Format the partitions
echo "Formatting the partitions..."
mkfs.fat -F32 "${dev}1"
mkfs.btrfs "${dev}2"

# Mount the BTRFS partition and create subvolumes
echo "Setting up BTRFS..."
mount "${dev}2" /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
umount /mnt

# Remount the BTRFS subvolumes
mount -o noatime,space_cache,compress=zstd,subvol=@ "${dev}2" /mnt
mkdir -p /mnt/{boot,home,.snapshots}
mount -o noatime,space_cache,compress=zstd,subvol=@home "${dev}2" /mnt/home
mount -o noatime,space_cache,compress=zstd,subvol=@snapshots "${dev}2" /mnt/.snapshots
mount "${dev}1" /mnt/boot

# Install essential packages
echo "Installing essential packages..."
pacstrap /mnt base linux linux-firmware btrfs-progs grub grub-btrfs rsync efibootmgr snapper reflector snap-pac zram-generator sudo micro xorg-server xorg-apps git plasma-meta plasma-wayland-session kde-utilities kde-system dolphin-plugins kde-graphics neofetch zsh man-db man-pages texinfo samba chromium nano sddm sddm-kcm gnome-disk-utility ksysguard kate xorg plasma plasma-wayland-session kde-applications

# Generate fstab
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

EOF

# Unmount all partitions and reboot
umount -R /mnt
reboot