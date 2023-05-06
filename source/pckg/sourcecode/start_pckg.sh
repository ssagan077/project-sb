#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
pckg_address="10.88.10.6"

# Checking password
echo -e "\nYou have to set a user password to continue. If you have not done so, please abort this script and do it now."
read -p "Interrupt script execution to set password? y/n: " -n 1 -r
   echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo -e "\nPlease execute command: sudo passwd _username_"
      exit 1
fi

#Adding hostname to HOST
if [ $(grep $pckg_address" vm-pckg-srv" /etc/hosts | wc -l ) -eq 0 ]; then
    echo $pckg_address" vm-pckg-srv.local" >> /etc/hosts
fi

#Adding our local repo to repo-list
echo "Adding our repo to Repo list..."
if [ $(grep "http://vm-pckg-srv" /etc/apt/sources.list | wc -l) -eq 0 ]; then
    echo "deb [trusted=yes] http://vm-pckg-srv/debian ./" | tee -a /etc/apt/sources.list > /dev/null
fi

echo "Updating packages..."
apt-get update && echo "repo list updated" || exit 1

#Installing package deploy-ca
if dpkg -l deploy-pckg; then echo "deploy-pckg has been already installed"
else
     apt-get install deploy-pckg && echo "Our package installed" || exit 1
fi

echo "Checking installed software..."
# Our variables
source pckg_paths.sh

check_installed "iptables-persistent"
echo "To continue, please run script deb_setup.sh"
