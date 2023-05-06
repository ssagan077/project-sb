#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
pckg_address="10.88.10.6"

echo "Updating packages..."
apt-get update
echo "Installing software for Firewall..."
#Install iptables-persistent
apt-get -y install iptables-persistent && echo "iptables-persistent is installed" || exit 1
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
iptables -L
sleep 3
echo "Installing nginx..."
sleep 1
apt-get -y install nginx && echo "nginx installed" || exit 1
echo "Adding SSL to nginx..."
if dpkg -l openssl &> /dev/null
then
     echo "openssl installed..."
else
     echo "Installing openssl"
     apt-get -y install openssl || exit 1
fi

#Adding hostname to HOST
if [ $(grep $pckg_address" vm-pckg-srv" /etc/hosts | wc -l ) -eq 0 ]; then
    echo $pckg_address" vm-pckg-srv.local" >> /etc/hosts
fi

echo "Installing dh-make..."
sleep 1
apt-get -y install dh-make devscripts && echo "dh-make installed" || exit 1

# Checking ssl keys
if [ -f '/etc/nginx/ssl/server.crt' ]; then
   read -p "Directory /etc/nginx/ssl already exists and not empty! Delete it with all keys? y/n: " -n 1 -r
   echo    # (optional) move to a new line
   if [[ $REPLY =~ ^[Yy]$ ]]
      then
      rm -rf /etc/nginx/ssl
      mkdir /nginx/ssl
   else
      echo -e "\nLooks like the ssl keys are already installed. Exit"
      exit 1
   fi
fi
echo -e "\nGenerating SSL keys and certificates..."

if openssl genrsa -out server.key 4096
then
  echo "Key generated"
else
  echo "Can't generate secret key" ; exit 1
fi
openssl req -new -subj "/C=RU/ST=Moscow/L=Moscow/O=SBTraining/OU=IT/CN=vm-pckg-srv.local" -key server.key -out server.csr || exit 1
echo "Request created"
#openssl x509 –req –days 365 –in server.csr –signkey server.key –out server.crt || echo "Can't sign cert" && exit 1
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt || exit 1
echo "Certificate signed"


if [ ! -d '/etc/nginx/ssl' ]; then mkdir /etc/nginx/ssl; fi
mv server.key server.crt /etc/nginx/ssl
rm -f server.csr
echo "__________________________________________________________________________________________________"
echo "Done. To create deb-package deb-pckgs, please run make_pckg_pckg.sh script"
sleep 1
echo "Then create local repo: run create_rep.sh script"
sleep 1
echo "After that, install the deb-pckgs package from the local repository: sudo apt-get install deb-pckgs"
