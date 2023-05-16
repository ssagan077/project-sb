#!/bin/bash
## This is the script that initiates installation of the monitoring server on newly created virtual machine.
## It adds our local repository to the list of trusted repo and installs the necessary packages (deploy_mon)

# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
# Our variables
#source mon_paths.sh
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

#Adding local repo
echo "Adding our repo to Repo list..."
if [ $(grep "http://${pckg_server}.${domain_name}" /etc/apt/sources.list | wc -l) -eq 0 ]; then
    echo "deb [trusted=yes] http://${pckg_server}.${domain_name}/debian ./" | tee -a /etc/apt/sources.list > /dev/null
fi

echo "Updating packages..."
apt-get update && echo "repo list updated" || exit 1

#if dpkg -l deploy-mon; then echo "deploy-mon has been already installed"
#else
     apt-get -y install deploy-mon && echo "Our package installed" || exit 1
#fi

# Our variables
source mon_paths.sh

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

echo "Checking installed software..."
check_installed "nginx"
check_installed "openssl"
check_installed "prometheus"
check_installed "prometheus-node-exporter"
check_installed "prometheus-nginx-exporter"
check_installed "prometheus-blackbox-exporter"
check_installed "iptables-persistent"
echo "To continue, please run script prepare_net_mon.sh"
