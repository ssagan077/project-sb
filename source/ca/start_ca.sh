#!/bin/bash
## This is the script that initiates installation of the CA server on newly created virtual machine.
## It adds our local repository to the list of trusted repo and installs the necessary packages (deploy_ca)

# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

pckg_address="10.88.10.6"
pckg_server="vm-pckg-srv"
domain_name="sigmanet.site"

# Checking password
echo -e "\nYou have to set a user password to continue. If you have not done so, please abort this script and do it now."
read -p "Interrupt script execution to set password? y/n: " -n 1 -r
   echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo -e "\nPlease execute command: sudo passwd _username_"
      exit 1
fi

#Adding hostname to HOST
if [ $(grep "${pckg_address} ${pckg_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${pckg_address} ${pckg_server}.${domain_name}" >> /etc/hosts
fi

#Adding our local repo to repo-list
echo "Adding our repo to Repo list..."
if [ $(grep "http://vm-pckg-srv" /etc/apt/sources.list | wc -l) -eq 0 ]; then
    echo "deb [trusted=yes] http://vm-pckg-srv/debian ./" | tee -a /etc/apt/sources.list > /dev/null
fi

echo "Updating packages..."
apt-get update && echo "repo list updated" || exit 1

#Installing package deploy-ca
if dpkg -l deploy-ca; then echo "deploy-ca has been already installed"
else
     apt-get install deploy-ca && echo "Our package installed" || exit 1
fi

echo "Checking installed software..."
# Our variables
source ca_paths.sh

#Adding hostname to HOST
if [ $(grep "${mon_address} ${mon_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${mon_address} ${mon_server}.${domain_name}" >> /etc/hosts
fi
if [ $(grep "${ovpn_address} ${ovpn_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${ovpn_address} ${ovpn_server}.${domain_name}" >> /etc/hosts
fi
if [ $(grep "${back_address} ${back_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${back_address} ${back_server}.${domain_name}" >> /etc/hosts
fi

check_installed "easy-rsa"
check_installed "iptables-persistent"
echo "To continue, please run script prepare_net.sh"
