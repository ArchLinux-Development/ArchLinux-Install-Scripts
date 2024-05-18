
# Arch Linux Installation and Maintenance Scripts

![Arch Linux](https://upload.wikimedia.org/wikipedia/commons/a/a5/Archlinux-icon-crystal-64.svg)

Welcome to the Arch Linux Installation and Maintenance Scripts repository! This collection of scripts is designed to simplify the installation of Arch Linux with different filesystems and configurations, as well as maintenance tasks. Currently, we have scripts for BTRFS, ZFS, and various system maintenance tasks, including fixing a corrupted bootloader and optimizing system performance. Each script will guide you through the necessary steps to achieve the desired setup or maintenance.

## Available Scripts

- **install_arch_btrfs.sh**: Installs Arch Linux with a BTRFS filesystem.
- **install_arch_zfs.sh**: Installs Arch Linux with a ZFS filesystem.
- **optimize_arch.sh**: Optimizes Arch Linux system performance.
- **fix_bootloader.sh**: Fixes a corrupted bootloader for standard filesystems.
- **fix_bootloader_btrfs.sh**: Fixes a corrupted bootloader for BTRFS filesystem.

## How to Use the Scripts

### For Installation Scripts

#### BTRFS Installation

1. Save the script to a file, for example, `install_arch_btrfs.sh`.
2. Make the script executable:

    ```bash
    chmod +x install_arch_btrfs.sh
    ```

3. Run the script with root privileges:

    ```bash
    sudo ./install_arch_btrfs.sh
    ```

#### ZFS Installation

1. Save the script to a file, for example, `install_arch_zfs.sh`.
2. Make the script executable:

    ```bash
    chmod +x install_arch_zfs.sh
    ```

3. Run the script with root privileges:

    ```bash
    sudo ./install_arch_zfs.sh
    ```

### For Maintenance Scripts

#### System Optimization

1. Save the script to a file, for example, `optimize_arch.sh`.
2. Make the script executable:

    ```bash
    chmod +x optimize_arch.sh
    ```

3. Run the script with root privileges:

    ```bash
    sudo ./optimize_arch.sh
    ```

#### Fix Bootloader (Standard Filesystem)

1. Boot into Arch Linux live environment.
2. Mount your root partition to `/mnt`:

    ```bash
    mount /dev/sda2 /mnt
    ```

3. Save the script to a file, for example, `fix_bootloader.sh`.
4. Make the script executable:

    ```bash
    chmod +x fix_bootloader.sh
    ```

5. Run the script with root privileges:

    ```bash
    sudo ./fix_bootloader.sh
    ```

#### Fix Bootloader (BTRFS Filesystem)

1. Boot into Arch Linux live environment.
2. Mount your root partition to `/mnt` with BTRFS subvolumes:

    ```bash
    mount -o subvol=@ /dev/sda2 /mnt
    ```

3. Save the script to a file, for example, `fix_bootloader_btrfs.sh`.
4. Make the script executable:

    ```bash
    chmod +x fix_bootloader_btrfs.sh
    ```

5. Run the script with root privileges:

    ```bash
    sudo ./fix_bootloader_btrfs.sh
    ```

## Script Explanations

### BTRFS Installation Script

1. **Network Check**: The script checks for an active network connection and prompts for network setup if needed.
2. **Disk Partitioning**: The script partitions the specified disk into an EFI partition and a BTRFS partition.
3. **BTRFS Setup**: The script formats the BTRFS partition and creates subvolumes for root, home, and snapshots.
4. **Package Installation**: The script installs the specified packages using `pacstrap`.
5. **System Configuration**: The script configures localization, network settings, and the bootloader.
6. **User Setup**: The script prompts for a username and password, encrypts the password, and creates the user.
7. **Services**: The script enables necessary services such as `sddm`, `NetworkManager`, and `zram-generator`.
8. **Reboot**: The script unmounts the partitions and reboots the system.

### ZFS Installation Script

1. **Network Check**: The script checks for an active network connection and prompts for network setup if needed.
2. **Disk Partitioning**: The script partitions the specified disk into an EFI partition and a partition for ZFS.
3. **ZFS Setup**: The script installs necessary ZFS packages, loads the ZFS module, and creates the ZFS pool and datasets.
4. **Package Installation**: The script installs the specified packages using `pacstrap`.
5. **System Configuration**: The script configures localization, network settings, and the bootloader.
6. **User Setup**: The script prompts for a username and password, encrypts the password, and creates the user.
7. **Services**: The script enables necessary services such as `sddm`, `NetworkManager`, `zram-generator`, and ZFS-related services.
8. **Reboot**: The script unmounts the partitions and reboots the system.

### System Optimization Script

1. **Update Package Databases**: Ensures package databases are up-to-date.
2. **Reinstall All Packages**: Reinstalls all installed packages to ensure they are correctly registered.
3. **Verify Package Integrity**: Verifies the integrity of installed packages.
4. **Clean Package Cache**: Cleans up the package cache to free up space.
5. **Remove Orphaned Packages**: Removes packages that are no longer needed.
6. **Clean System Logs**: Cleans up old system logs.
7. **Optimize Network Settings**: Tweaks network settings for better performance.
8. **Clear Temporary Files**: Removes temporary files to free up space.

### Bootloader Fix Script (Standard Filesystem)

1. **Mount the Root Partition**: Mount your root partition to `/mnt`.
2. **Mount the Boot Partition**: Mount your boot partition to `/mnt/boot`.
3. **Bind Mount Necessary Directories**: Bind mount `/dev`, `/proc`, `/sys`, and `/run` to `/mnt`.
4. **Chroot into Mounted Root**: Chroot into the mounted root to run necessary commands.
5. **Install GRUB Bootloader**: Reinstall the GRUB bootloader.
6. **Generate GRUB Configuration File**: Generate a new GRUB configuration file.
7. **Unmount Directories and Partitions**: Unmount the bind mounts and partitions.

### Bootloader Fix Script (BTRFS Filesystem)

1. **Mount the Root Partition**: Mount your root partition to `/mnt` with BTRFS subvolumes.
2. **Mount the Boot Partition**: Mount your boot partition to `/mnt/boot`.
3. **Bind Mount Necessary Directories**: Bind mount `/dev`, `/proc`, `/sys`, and `/run` to `/mnt`.
4. **Chroot into Mounted Root**: Chroot into the mounted root to run necessary commands.
5. **Install GRUB Bootloader**: Reinstall the GRUB bootloader.
6. **Generate GRUB Configuration File**: Generate a new GRUB configuration file.
7. **Unmount Directories and Partitions**: Unmount the bind mounts and partitions.

## Future Plans

- Additional scripts for different configurations and filesystems.
- Improved error handling and user prompts.
- Enhanced documentation and guides.

## Contributing

We welcome contributions! Please feel free to submit pull requests or open issues to improve the scripts or add new features.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

![Arch Linux](https://upload.wikimedia.org/wikipedia/commons/a/a5/Archlinux-icon-crystal-64.svg)

Happy installing!

---

**Note**: Always back up your data before running installation scripts and ensure you understand each step of the process. This repository is provided as-is, without any warranties or guarantees.
