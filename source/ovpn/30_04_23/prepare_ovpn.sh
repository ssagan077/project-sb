#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
echo "Updating packages..."
apt-get update

echo "Installing OpenVPN..."
apt-get -y install openvpn && echo " OpenVPN installed"
if [ $? -ne 0 ]; then echo "OpenVPN hasn't been installed. Try it manually" ; exit 1; fi

echo "Installing Easy-RSA..."
apt-get -y install easy-rsa && echo "Easy-RSA installed"
if [ $? -ne 0 ]; then echo "Easy-RSA hasn't been installed. Try it manually" ; exit 1; fi

##echo "To continue, please run script make_keys_ca.sh..."
echo "Installing Easy-RSA..."
apt-get -y install easy-rsa && echo "Easy-RSA installed"
if [ $? -ne 0 ]; then echo "Easy-RSA hasn't been installed. Try it manually" ; exit 1; fi

echo "To continue, please run script make_env_ovpn.sh..."
