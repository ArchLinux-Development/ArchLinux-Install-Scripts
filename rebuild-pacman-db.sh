#!/bin/bash

echo "Updating package databases..."
sudo pacman -Syy

echo "Reinstalling all packages..."
sudo pacman -S --needed $(pacman -Qq)

echo "Verifying package integrity..."
sudo pacman -Qk

echo "Backing up and removing local databases..."
sudo mv /var/lib/pacman/sync /var/lib/pacman/sync.bak
sudo mkdir /var/lib/pacman/sync

echo "Re-syncing package databases..."
sudo pacman -Syy

echo "Cleaning package cache..."
sudo pacman -Sc

echo "Refreshing keyring..."
sudo pacman-key --init
sudo pacman-key --populate archlinux

echo "Package database rebuild complete!"
