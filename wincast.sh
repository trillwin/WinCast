#!/bin/bash

echo "WARNING: This script will overwrite the OS on your ChromeCast."
echo "If you don't know what you're doing, press N to exit."
echo "If you know what you're doing, press Y to continue."

echo "Make sure you have the ChromeCast plugged in and make sure you have the system image."

read -p "Continue? (Y/N): " choice

case "$choice" in 
  y|Y ) 
    echo "Proceeding with the installation..."
    
    echo "Extracting system_image.iso from system_image.rar..."
    if ! command -v unrar &> /dev/null
    then
        echo "unrar could not be found. Please install unrar and try again."
        exit 1
    fi
    unrar x system_image.rar
    if [ $? -ne 0 ]; then
        echo "Failed to extract system_image.iso. Exiting..."
        exit 1
    fi
    echo "Extraction of ISO complete."

    echo "Flashing system_image.iso to ChromeCast..."
    # Replace /dev/sdX with the actual device path of your Chromecast
    DEVICE_PATH="/dev/sdX"
    IMAGE_FILE="system_image.iso"

    # Ensure the device path is correct
    if [ ! -b "$DEVICE_PATH" ]; then
        echo "Invalid device path: $DEVICE_PATH. Please check the device path and try again."
        exit 1
    fi

    # Flash the image to the Chromecast
    sudo dd if="$IMAGE_FILE" of="$DEVICE_PATH" bs=4M status=progress conv=fsync
    if [ $? -ne 0 ]; then
        echo "Failed to flash the image to the ChromeCast. Exiting..."
        exit 1
    fi
    echo "Flashing complete. Your ChromeCast now has Windows 10 installed."
    ;;
  n|N ) 
    echo "Exiting..."
    exit 1
    ;;
  * ) 
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac
``` ▋