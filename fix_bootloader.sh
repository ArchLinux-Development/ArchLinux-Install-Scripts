#!/bin/bash

# Exit on error
set -e

echo "Arch Linux Bootloader Fix Script"

# Instructions
echo "Instructions:"
echo "1. Boot into Arch Linux live environment."
echo "2. Mount your root partition to /mnt. For example:"
echo "   mount /dev/sda2 /mnt"
echo "3. Run this script with root privileges:"
echo "   sudo ./fix_bootloader.sh"
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check if the /mnt directory exists
if [ ! -d "/mnt" ]; then
  echo "/mnt directory does not exist. Make sure your root partition is mounted at /mnt."
  exit 1
fi

# Check if necessary commands are available
for cmd in grub-install grub-mkconfig; do
  if ! command -v $cmd &> /dev/null; then
    echo "$cmd could not be found. Please ensure GRUB is installed."
    exit 1
  fi
done

# Prompt user for the boot partition and the root partition
read -p "Enter the boot partition (e.g., /dev/sda1): " boot_partition
read -p "Enter the root partition (e.g., /dev/sda2): " root_partition

# Mount the root partition
echo "Mounting the root partition..."
mount "$root_partition" /mnt

# Check if the boot directory exists in the mounted root
if [ ! -d "/mnt/boot" ]; then
  echo "/mnt/boot directory does not exist. Creating /mnt/boot."
  mkdir /mnt/boot
fi

# Mount the boot partition
echo "Mounting the boot partition..."
mount "$boot_partition" /mnt/boot

# Bind mount necessary directories
echo "Binding necessary directories..."
for dir in /dev /proc /sys /run; do
  mount --bind $dir /mnt$dir
done

# Chroot into the mounted root
echo "Chrooting into the mounted root..."
chroot /mnt /bin/bash <<EOF

# Ensure the bootloader is installed
echo "Installing GRUB bootloader..."
grub-install --target=i386-pc "$boot_partition"

# Generate the GRUB configuration file
echo "Generating GRUB configuration file..."
grub-mkconfig -o /boot/grub/grub.cfg

EOF

# Unmount the bind mounts
echo "Unmounting bind mounts..."
for dir in /dev /proc /sys /run; do
  umount /mnt$dir
done

# Unmount the boot and root partitions
echo "Unmounting the boot and root partitions..."
umount /mnt/boot
umount /mnt

echo "Bootloader fix complete. You can now reboot into your system."

# Exit script
exit 0
