#!/bin/bash

# Function to check if the script is run as root
check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
  fi
}

# Clean package cache
clean_package_cache() {
  echo "Cleaning package cache..."
  sudo pacman -Sc --noconfirm
}

# Remove orphaned packages
remove_orphaned_packages() {
  echo "Removing orphaned packages..."
  sudo pacman -Rns $(pacman -Qtdq) --noconfirm
}

# Update system and packages
update_system() {
  echo "Updating system and packages..."
  sudo pacman -Syu --noconfirm
}

# Clean system logs
clean_system_logs() {
  echo "Cleaning system logs..."
  sudo journalctl --vacuum-time=2weeks
}

# Optimize network settings
optimize_network() {
  echo "Optimizing network settings..."
  sudo sysctl -w net.core.rmem_max=2500000
  sudo sysctl -w net.core.wmem_max=2500000
  sudo sysctl -w net.ipv4.tcp_rmem='4096 87380 2500000'
  sudo sysctl -w net.ipv4.tcp_wmem='4096 65536 2500000'
}

# Clear temporary files
clear_temp_files() {
  echo "Clearing temporary files..."
  sudo rm -rf /tmp/*
}

# Function to perform all tasks
perform_all_tasks() {
  check_root
  clean_package_cache
  remove_orphaned_packages
  update_system
  clean_system_logs
  optimize_network
  clear_temp_files
}

# Start the script
perform_all_tasks

echo "System optimization complete!"
