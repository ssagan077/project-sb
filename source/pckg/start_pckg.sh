#!/bin/bash
## This script is the second step in deploying the infrastructure of our project.
## After creating a local branch of the git repository,
## we create a local deb package repository to deploy servers with the services

# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

pckg_address="10.88.10.5"
op_user="user"   ## You should change it before start!!!
data_dir="/home/${op_user}/project-sb"
rep_dir="/var/www/html/debian"
pckg_dir="${data_dir}/packages"
pckg_server="vm-backup-srv"
domain_name="sigmanet.site"

# Checking password
echo -e "\nYou have to set a user password to continue. If you have not done so, please abort this script and do it now."
read -p "Interrupt script execution to set password? y/n: " -n 1 -r
   echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo -e "\nPlease execute command: sudo passwd _username_"
      exit 1
fi

echo "Updating packages..."
apt-get update &>/dev/null && echo "repo list updated" || exit 1

#Installing nginx
if dpkg -l nginx &>/dev/null; then echo "nginx has been already installed"
else
     apt-get install nginx && echo "Our package installed" || exit 1
fi

#Installing git
if dpkg -l git &>/dev/null; then echo "git has been already installed"
else
     apt-get install git && echo "Our package installed" || exit 1
fi

if [ ! -d "${pckg_dir}" ]; then
  echo "There is no directory ${pckg_dir}. Please run make_repo_clone.sh first!"
  exit 1
fi

# Checking our directory with deb-packages
if [ $(find $pckg_dir/ -type f -name *.deb | wc -l) -eq 0 ]; then
   echo "There are no deb-packages in our repository ($pckg_dir). Please check it "
   exit 1
fi


#Adding hostname to HOST
if [ $(grep $pckg_address" ${pckg_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo $pckg_address" ${pckg_server}.${domain_name}" >> /etc/hosts
fi


echo "Checking local repository dir..."
[ ! -d  $rep_dir ] && mkdir $rep_dir

# Request for clean deb-reposotory
if [ $(find $rep_dir/ -type f | wc -l) -gt 0 ]; then
     read -p "Delete all deb-packages in our repository ($rep_dir) before creating new list? y/n: " -n 1 -r
     if [[ $REPLY =~ ^[Yy]$ ]]; then rm -f $rep_dir/* ; fi
fi

# Copying our packages to repository from directory ~/packages/
echo -e "\nCopying files to repository..."

find $pckg_dir -type f -name *.deb -exec cp {} $rep_dir/ \; || exit 1

#dpkg -l dpkg-dev &>/dev/null || apt-get install dpkg-dev && echo "dpkg-dev installed"
apt-get install dpkg-dev && echo "dpkg-dev installed"

echo "Creating list of packages..."
cd $rep_dir
dpkg-scanpackages . | gzip -c9 > Packages.gz && echo "Packages list has created!" || exit 1

echo "Adding our repo to Repo list..."
if [ $(grep "http://${pckg_server}.${domain_name}" /etc/apt/sources.list | wc -l) -eq 0 ]; then
    echo "deb [trusted=yes] http://${pckg_server}.${domain_name}/debian ./" | tee -a /etc/apt/sources.list > /dev/null
fi

echo "Updating repo list..."
apt-get update || exit 1

echo "Now we can install deb-packages from our repository"

#Installing package that deploying PCKG-server
echo -e "\nInstalling package deploy-pckg..."
if dpkg -l deploy-pckg &>/dev/null; then echo "deploy-pckg has been already installed"
else
     apt-get install deploy-pckg && echo "package deploy-pckg installed" || exit 1
fi

#Installing package that synchronizing local git repository with remote one
echo -e "\nInstalling package synch-git..."
if dpkg -l synch-git &>/dev/null; then echo "synch-git has been already installed"
else
     apt-get install synch-git && echo "package synch-git installed"
fi

##Our Variables
source pckg_paths.sh

#Adding hostnames to HOST
if [ $(grep "${mon_address} ${mon_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${mon_address} ${mon_server}.${domain_name}" >> /etc/hosts
fi
if [ $(grep "${ovpn_address} ${ovpn_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${ovpn_address} ${ovpn_server}.${domain_name}" >> /etc/hosts
fi
if [ $(grep "${pckg_address} ${pckg_server}" /etc/hosts | wc -l ) -eq 0 ]; then
    echo "${pckg_address} ${pckg_server}.${domain_name}" >> /etc/hosts
fi

echo "Checking installed software..."
check_installed "nginx"
check_installed "openssl"
check_installed "prometheus-node-exporter"
check_installed "prometheus-nginx-exporter"
check_installed "iptables-persistent"

echo "To continue, please run script prepare_net_pckg.sh"
