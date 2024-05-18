#!/bin/bash

# Exit on error
set -e

echo "Arch Linux Font Improvement Script for KDE Plasma"

# Instructions
echo "Instructions:"
echo "1. Save this script to a file, for example, improve_fonts_kde.sh."
echo "2. Make the script executable:"
echo "   chmod +x improve_fonts_kde.sh"
echo "3. Run the script with root privileges:"
echo "   sudo ./improve_fonts_kde.sh"
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Update package database
echo "Updating package database..."
pacman -Syu --noconfirm

# Install necessary packages for font rendering and popular fonts
echo "Installing necessary packages and fonts..."
pacman -S --noconfirm \
  fontconfig \
  freetype2 \
  cairo \
  noto-fonts \
  ttf-dejavu \
  ttf-liberation \
  ttf-roboto \
  ttf-ubuntu-font-family \
  ttf-droid \
  ttf-opensans \
  ttf-inconsolata \
  ttf-font-awesome \
  ttf-ms-fonts

# Configure font rendering
echo "Configuring font rendering..."
cat > /etc/fonts/local.conf <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <match target="font">
        <edit mode="assign" name="antialias">
            <bool>true</bool>
        </edit>
        <edit mode="assign" name="hinting">
            <bool>true</bool>
        </edit>
        <edit mode="assign" name="hintstyle">
            <const>hintfull</const>
        </edit>
        <edit mode="assign" name="lcdfilter">
            <const>lcddefault</const>
        </edit>
        <edit mode="assign" name="rgba">
            <const>rgb</const>
        </edit>
        <edit mode="assign" name="autohint">
            <bool>false</bool>
        </edit>
    </match>
    <match target="font">
        <edit mode="assign" name="embeddedbitmap">
            <bool>false</bool>
        </edit>
    </match>
    <match target="font">
        <edit mode="assign" name="dpi">
            <double>96</double>
        </edit>
    </match>
</fontconfig>
EOF

# Update font cache
echo "Updating font cache..."
fc-cache -fv

echo "Font improvement complete. Please restart your system or X session to apply the changes."

# Exit script
exit 0
