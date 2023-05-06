#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
#Our Variables
source ovpn_paths.sh

#Setup parameters
tm_eth=$(ip link | grep ens | awk -F ":" '{print $2}' | sed 's/ //')
proto=udp
port=1194

read -e -i $tm_eth -p "Enter network interface. (or press Enter for default value): " eth
#read -e -i 1194 -p "
#Enter port. (or press Enter for default value): " port

#Allow ip forwarding
if [ -f $conf_dir/sysctl.conf ]; then
  mv /etc/sysctl.conf /etc/sysctl.conf.bak
  cp $conf_dir/sysctl.conf /etc/sysctl.conf
fi
echo "Please, check the setting. Forwarding must be allowed"
sleep 3
nano /etc/sysctl.conf
sysctl -p

echo "Updating packages..."
apt-get update

echo "Installing software for Firewall..."
#Install iptables-persistent
if apt-get -y install iptables-persistent
then
   echo "iptables-persistent is installed"
else
   echo "iptables-persistent has not been installed! Try it manually" ; exit 1
fi
echo "Creating firewall rules..."
#Delete all rules
iptables -F

#Common INPUT rules
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
#Rules OpenVPN
iptables -A INPUT -i "$eth" -m state --state NEW -p "$proto" --dport "$port" -j ACCEPT
#ALLOW TUN iface conn to OpenVPN Server
iptables -A INPUT -i tun+ -j ACCEPT
iptables -P INPUT DROP
# ALLOW TUN iface conn FORWARD THROUGH other ifaces
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -o "$eth" -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i "$eth" -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT
# NAT VPN clients traffic to the Internet
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o "$eth" -j MASQUERADE
#COMMON OUTRUP rules
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
#iptables -P OUTPUT DROP
echo "Saving firewall rules..."
service netfilter-persistent save && echo "Rules are saved"
if [ $? -ne 0 ]; then echo "Rules have not been saved! Check the settings"; exit 1; fi

echo "Done. Please check the firewall rules:"
iptables -L
sleep 1
