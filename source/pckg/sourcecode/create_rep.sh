#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

rep_dir="/var/www/html/debian"
pckg_dir=/home/ssagan077/packages

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

dpkg -l dpkg-dev &>/dev/null || apt-get install dpkg-dev && echo "dpkg-dev installed"

echo "Creating list of packages..."
cd $rep_dir
dpkg-scanpackages . | gzip -c9 > Packages.gz && echo "Packages list has created!" || exit 1

echo "Adding our repo to Repo list..."
if [ $(grep "http://vm-pckg-srv" /etc/apt/sources.list | wc -l) -eq 0 ]; then
    echo "deb [trusted=yes] http://vm-pckg-srv/debian ./" | tee -a /etc/apt/sources.list > /dev/null
fi
echo "Done"
