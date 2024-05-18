#!/bin/bash

echo "Checking SDDM logs..."
journalctl -u sddm

echo "Reinstalling SDDM and Xorg server..."
sudo pacman -Rns sddm xorg-server --noconfirm
sudo pacman -S sddm xorg-server --noconfirm

echo "Resetting SDDM configuration..."
sudo mv /etc/sddm.conf /etc/sddm.conf.bak
sudo sddm --example-config > /etc/sddm.conf

echo "Setting default theme..."
sudo sed -i 's/^Current=.*/Current=elarun/' /etc/sddm.conf

echo "Checking permissions..."
sudo chown -R sddm:sddm /var/lib/sddm /etc/sddm.conf /usr/share/sddm

echo "Enabling and starting SDDM..."
sudo systemctl enable sddm
sudo systemctl start sddm

echo "SDDM reinstallation and setup complete!"
