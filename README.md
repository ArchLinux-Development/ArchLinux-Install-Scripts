# Arch Linux Installation Scripts

![Arch Linux](https://upload.wikimedia.org/wikipedia/commons/a/a5/Archlinux-icon-crystal-64.svg)

Welcome to the Arch Linux Installation Scripts repository! This collection of scripts is designed to simplify the installation of Arch Linux with different filesystems and configurations. Currently, we have scripts for BTRFS and ZFS, with more to come. Each script will guide you through setting up your system, including disk partitioning, filesystem setup, package installation, and configuration.

## Available Scripts

- **install_arch_btrfs.sh**: Installs Arch Linux with a BTRFS filesystem.
- **install_arch_zfs.sh**: Installs Arch Linux with a ZFS filesystem.

## How to Use the Script

### For BTRFS

1. Save the script to a file, for example, `install_arch_btrfs.sh`.
2. Make the script executable:

    ```bash
    chmod +x install_arch_btrfs.sh
    ```

3. Run the script with root privileges:

    ```bash
    sudo ./install_arch_btrfs.sh
    ```

### For ZFS

1. Save the script to a file, for example, `install_arch_zfs.sh`.
2. Make the script executable:

    ```bash
    chmod +x install_arch_zfs.sh
    ```

3. Run the script with root privileges:

    ```bash
    sudo ./install_arch_zfs.sh
    ```

## Script Explanations

### BTRFS Script

1. **Network Check**: The script checks for an active network connection and prompts for network setup if needed.
2. **Disk Partitioning**: The script partitions the specified disk into an EFI partition and a BTRFS partition.
3. **BTRFS Setup**: The script formats the BTRFS partition and creates subvolumes for root, home, and snapshots.
4. **Package Installation**: The script installs the specified packages using `pacstrap`.
5. **System Configuration**: The script configures localization, network settings, and the bootloader.
6. **User Setup**: The script prompts for a username and password, encrypts the password, and creates the user.
7. **Services**: The script enables necessary services such as `sddm`, `NetworkManager`, and `zram-generator`.
8. **Reboot**: The script unmounts the partitions and reboots the system.

### ZFS Script

1. **Network Check**: The script checks for an active network connection and prompts for network setup if needed.
2. **Disk Partitioning**: The script partitions the specified disk into an EFI partition and a partition for ZFS.
3. **ZFS Setup**: The script installs necessary ZFS packages, loads the ZFS module, and creates the ZFS pool and datasets.
4. **Package Installation**: The script installs the specified packages using `pacstrap`.
5. **System Configuration**: The script configures localization, network settings, and the bootloader.
6. **User Setup**: The script prompts for a username and password, encrypts the password, and creates the user.
7. **Services**: The script enables necessary services such as `sddm`, `NetworkManager`, `zram-generator`, and ZFS-related services.
8. **Reboot**: The script unmounts the partitions and reboots the system.

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