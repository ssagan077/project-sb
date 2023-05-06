#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
pckg_address="10.88.10.6"
domain_name="sigmanet.site"
first_run=0

# Checking password
echo -e "\nYou have to set a user password to continue. If you have not done so, please abort this script and do it now"
read -p "Interrupt script execution to set password? y/n: " -n 1 -r
   echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo -e "\nPlease execute command: sudo passwd _username_"
      exit 1
fi

#Adding hostname to HOST
if [ $(grep "${pckg_address} vm-pckg-srv" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${pckg_address} vm-pckg-srv.${domain_name}" >> /etc/hosts
fi

#Adding our local repo to repo-list
echo "Adding our repo to Repo list..."
if [ $(grep "http://vm-pckg-srv" /etc/apt/sources.list | wc -l) -eq 0 ]; then
    echo "deb [trusted=yes] http://vm-pckg-srv/debian ./" | tee -a /etc/apt/sources.list > /dev/null
fi

echo "Updating packages..."
apt-get update && echo "repo list updated" || exit 1

#Installing package deploy-ovpn
if dpkg -l deploy-ovpn
then echo "deploy-ovpn has been already installed"
else
     apt-get -y install deploy-ovpn && echo "Our package installed" || exit 1
     first_run=1
fi

#Installing package ovpn-exporter
if dpkg -l ovpn-exporter
then echo "ovpn-exporter has been already installed"
else
     apt-get -y install ovpn-exporter && echo "Our package installed" || exit 1
fi

echo "Checking installed software..."
# Our variables
source ovpn_paths.sh

#Adding hostname to HOST
if [ $(grep "${mon_address} ${mon_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${mon_address} ${mon_server}.${domain_name}" >> /etc/hosts
fi
if [ $(grep "${ovpn_address} ${ovpn_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${ovpn_address} ${ovpn_server}.${domain_name}" >> /etc/hosts
fi
if [ $(grep "${back_address} ${back_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${back_address} ${back_server}.${domain_name}" >> /etc/hosts

check_installed "openvpn"
check_installed "easy-rsa"
check_installed "prometheus-node-exporter"
check_installed "iptables-persistent"
check_installed "ovpn-exporter"

#Check if we run this script the first time
if [ $first_run -eq 1 ]; then
        echo "For security reason we disable some services"
        echo "Disabling prometheus-node-exporter service..."
        if [ $(systemctl is-enabled prometheus-node-exporter.service) = "enable" ]; then
            systemctl disable prometheus-node-exporter.service
        fi
        systemctl stop prometheus-node-exporter.service

        echo "Disabling openvpn-exporter service..."
        if [ $(systemctl is-enabled openvpn-exporter.service) = "enable" ]; then
            systemctl disable openvpn-exporter.service
        fi
        systemctl stop openvpn-exporter.service

        echo "To continue, please run script prepare_net.sh"
fi
