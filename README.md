
# Arch Linux Installation and Maintenance Scripts

![Arch Linux](https://upload.wikimedia.org/wikipedia/commons/a/a5/Archlinux-icon-crystal-64.svg)

Welcome to the Arch Linux Installation and Maintenance Scripts repository! This collection of scripts simplifies the installation of Arch Linux with different filesystems and configurations, as well as system maintenance tasks. 

## Available Scripts

- **install_arch_btrfs.sh**: Installs Arch Linux with a BTRFS filesystem.
- **install_arch_zfs.sh**: Installs Arch Linux with a ZFS filesystem.
- **optimize_arch.sh**: Optimizes Arch Linux system performance.
- **fix_bootloader.sh**: Fixes a corrupted bootloader for standard filesystems.
- **fix_bootloader_btrfs.sh**: Fixes a corrupted bootloader for BTRFS filesystem.
- **improve_fonts.sh**: Enhances font rendering and appearance.
- **improve_fonts_kde.sh**: Optimizes font settings for KDE Plasma.
- **rebuild-pacman-db.sh**: Rebuilds the Pacman database.
- **reinstall_sddm.sh**: Reinstalls SDDM and resets its configuration.

## How to Use the Scripts

### Installation Scripts

#### BTRFS Installation

1. Save the script to a file, e.g., `install_arch_btrfs.sh`.
2. Make it executable:
   ```bash
   chmod +x install_arch_btrfs.sh
   ```
3. Run with root privileges:
   ```bash
   sudo ./install_arch_btrfs.sh
   ```

#### ZFS Installation

1. Save the script to a file, e.g., `install_arch_zfs.sh`.
2. Make it executable:
   ```bash
   chmod +x install_arch_zfs.sh
   ```
3. Run with root privileges:
   ```bash
   sudo ./install_arch_zfs.sh
   ```

### Maintenance Scripts

#### System Optimization

1. Save the script to a file, e.g., `optimize_arch.sh`.
2. Make it executable:
   ```bash
   chmod +x optimize_arch.sh
   ```
3. Run with root privileges:
   ```bash
   sudo ./optimize_arch.sh
   ```

#### Fix Bootloader (Standard Filesystem)

1. Boot into Arch Linux live environment.
2. Mount your root partition to `/mnt`:
   ```bash
   mount /dev/sda2 /mnt
   ```
3. Save the script to a file, e.g., `fix_bootloader.sh`.
4. Make it executable:
   ```bash
   chmod +x fix_bootloader.sh
   ```
5. Run with root privileges:
   ```bash
   sudo ./fix_bootloader.sh
   ```

#### Fix Bootloader (BTRFS Filesystem)

1. Boot into Arch Linux live environment.
2. Mount your root partition to `/mnt` with BTRFS subvolumes:
   ```bash
   mount -o subvol=@ /dev/sda2 /mnt
   ```
3. Save the script to a file, e.g., `fix_bootloader_btrfs.sh`.
4. Make it executable:
   ```bash
   chmod +x fix_bootloader_btrfs.sh
   ```
5. Run with root privileges:
   ```bash
   sudo ./fix_bootloader_btrfs.sh
   ```

#### Font Improvement Scripts

#### Improve Fonts

1. Save the script to a file, e.g., `improve_fonts.sh`.
2. Make it executable:
   ```bash
   chmod +x improve_fonts.sh
   ```
3. Run with root privileges:
   ```bash
   sudo ./improve_fonts.sh
   ```
   
#### Improve Fonts for KDE

1. Save the script to a file, e.g., `improve_fonts_kde.sh`.
2. Make it executable:
   ```bash
   chmod +x improve_fonts_kde.sh
   ```
3. Run with root privileges:
   ```bash
   sudo ./improve_fonts_kde.sh
   ```

### Rebuild Pacman Database

1. Save the script to a file, e.g., `rebuild-pacman-db.sh`.
2. Make it executable:
   ```bash
   chmod +x rebuild-pacman-db.sh
   ```
3. Run with root privileges:
   ```bash
   sudo ./rebuild-pacman-db.sh
   ```

### Reinstall SDDM

1. Save the script to a file, e.g., `reinstall_sddm.sh`.
2. Make it executable:
   ```bash
   chmod +x reinstall_sddm.sh
   ```
3. Run with root privileges:
   ```bash
   sudo ./reinstall_sddm.sh
   ```

## Script Explanations

### BTRFS Installation Script

1. **Network Check**: Checks for an active network connection and prompts for setup if needed.
2. **Disk Partitioning**: Partitions the specified disk into an EFI partition and a BTRFS partition.
3. **BTRFS Setup**: Formats the BTRFS partition and creates subvolumes for root, home, and snapshots.
4. **Package Installation**: Installs the specified packages using `pacstrap`.
5. **System Configuration**: Configures localization, network settings, and the bootloader.
6. **User Setup**: Prompts for a username and password, encrypts the password, and creates the user.
7. **Services**: Enables necessary services such as `sddm`, `NetworkManager`, and `zram-generator`.
8. **Reboot**: Unmounts the partitions and reboots the system.

### ZFS Installation Script

1. **Network Check**: Checks for an active network connection and prompts for setup if needed.
2. **Disk Partitioning**: Partitions the specified disk into an EFI partition and a partition for ZFS.
3. **ZFS Setup**: Installs necessary ZFS packages, loads the ZFS module, and creates the ZFS pool and datasets.
4. **Package Installation**: Installs the specified packages using `pacstrap`.
5. **System Configuration**: Configures localization, network settings, and the bootloader.
6. **User Setup**: Prompts for a username and password, encrypts the password, and creates the user.
7. **Services**: Enables necessary services such as `sddm`, `NetworkManager`, `zram-generator`, and ZFS-related services.
8. **Reboot**: Unmounts the partitions and reboots the system.

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

### Font Improvement Scripts

#### Improve Fonts

1. Installs necessary packages and popular fonts.
2. Configures font rendering settings.
3. Updates the font cache.

#### Improve Fonts for KDE

1. Installs necessary packages and popular fonts.
2. Configures font rendering settings.
3. Updates the font cache.
4. Additional KDE-specific font configuration.

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
