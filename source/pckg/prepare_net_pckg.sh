#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

# Our variables
source pckg_paths.sh


echo "Updating packages..."
apt-get update &> /dev/null && echo "package list updated" || exit 1

echo "Checking installed software..."
check_installed "iptables-persistent"

echo "Creating firewall rules..."
#Delete all rules
iptables -F
#adding firewall rules
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 10.88.10.0/24 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -s 10.88.10.0/24 -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -s ${mon_address}/32 -p tcp --dport 9100 -j ACCEPT
iptables -A INPUT -s ${mon_address}/32 -p tcp --dport 9113 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
iptables -P INPUT DROP
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
#iptables -P OUTPUT DROP
echo "Saving firewall rules..."
service netfilter-persistent save && echo "Rules are saved" || exit 1
echo "Done. Please check the firewall rules:"
iptables -L -v
sleep 3

echo "Done. Now you can get out packages from local Repository"
