#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
#Our Variables
source ca_paths.sh

check_installed "iptables-persistent"

#Delete all rules
iptables -F
#adding firewall rules
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
iptables -P INPUT DROP
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
#iptables -P OUTPUT DROP
echo "Saving firewall rules..."
service netfilter-persistent save && echo "Rules saved"
if [ $? -ne 0 ]; then echo "Rules have not been saved! Check the settings"; exit 1; fi

echo "Done. Please check the firewall rules:"
iptables -L -v
sleep 3

echo "To continue, please run script make_env_ca.sh..."
