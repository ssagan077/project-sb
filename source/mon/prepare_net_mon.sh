#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
#Our Variables
source mon_paths.sh

echo "Updating packages..."
apt-get update

echo "Installing software for Firewall..."
#Install iptables-persistent
if dpkg -l iptables-persistent
then echo "iptables-persistent installed"
else
    apt-get -y install iptables-persistent && echo "iptables-persistent installed"
     if [ $? -ne 0 ]; then echo "iptables-persistent has not been installed! Try it manually" ; exit 1; fi
fi
echo "Creating firewall rules..."
#Delete all rules
iptables -F

#Common INPUT rules
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -p tcp --dport 9093 -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -p tcp --dport 9115 -j ACCEPT
iptables -A INPUT -p tcp --dport 9090 -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -p tcp --dport 9100 -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -p tcp --dport 9113 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
iptables -P INPUT DROP

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
iptables -L -v
sleep 1

echo "Next step: run script make_srv_req.sh"
