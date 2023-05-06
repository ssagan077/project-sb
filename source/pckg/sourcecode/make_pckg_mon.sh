#!/bin/bash
# Check the script is being run by user (no sudo)
pckg_dir="/home/$USER/packages/deploy-mon-0.1"
data_dir="/home/$USER/data/mon"

if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
# Checking for installed software
if dpkg -l openssh-server &> /dev/null
then
   echo "ssh installed. Continue..."
else
   echo "ssh not installed! Break"
   exit 1
fi
if [ ! -d "/home/${USER}/packages" ]; then mkdir ~/packages
fi
cd ~/packages
if [ ! -d $pckg_dir ]; then mkdir $pckg_dir
else
   echo "Directory $pckg_dir already exist. Please, remove it manually to continue setup"
   exit 1
fi

#Checking if pckg already exists
ls deploy-mon_* 2>/dev/null && echo "Package deploy-mon already exist. Please, remove it manually to continue setup" && exit 1

#Copy config files
echo "Copying config files..."

if [ ! -f ${data_dir}/mon_list ]; then
   echo "File ${data_dir}/mon_list not found!"
   exit 1
fi

while IFS= read -r p_file
do
    if [ ! -f ${data_dir}/${p_file} ]; then
         echo "ERROR: file ${data_dir}/${p_file} not found!"
         exit 1
    else
         cp ${data_dir}/${p_file} $pckg_dir
    fi
done < ${data_dir}/mon_list

echo "Please edit ~/.bashrc; Add keys: export CITY, export DEBEMAIL, export DEBFULLNAME"
sleep 5
nano ~/.bashrc
source ~/.bashrc

#Create gpg-keys
if [  $(gpg --list-keys --with-colons | grep fpr | wc -l) -ne 0 ]; then
   echo "List of existed keys:"\n
   gpg --list-keys
   read -p "There are gpg keys in profile. Do you want use them for our project? y/n: " -n 1 -r
   echo    # (optional) move to a new line
   if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Please, remove the gpg keys manually and run this script again"
      sleep 1
      exit 1
   fi
else
    echo "Creating gpg-keys"
    gpg --gen-key && echo "gpg keys generated" || exit 1
fi

#Creating template of our deb-package
echo "Creating template of our deb-package..."
cd $pckg_dir
dh_make --indep --createorig && echo "Template created" || exit 1

if [ ! -d "debian" ]; then
   echo "Something went wrong. There is no folder debian"
   exit 1
fi

#Creating file install
echo "*.sh usr/bin/" >> debian/install
echo "*.yml etc/prometheus/" >> debian/install
echo "prometheus_mon etc/default/" >> debian/install
echo "prometheus-node-exporter_mon etc/default/" >> debian/install
echo "prometheus-nginx-exporter_mon etc/default/" >> debian/install
echo "prometheus-blackbox-exporter_mon etc/default/" >> debian/install
echo "nginx-mon.conf etc/nginx/sites-available/" >> debian/install

#Copy config files
[ -f $data_dir/preinst ] && cp $data_dir/preinst debian/ || cp debian/preinst.ex preinst
[ -f $data_dir/postinst ] && cp $data_dir/postinst debian/ || cp debian/postinst.ex postinst
[ -f $data_dir/postrm ] && cp $data_dir/postrm debian/ || cp debian/postrm.ex postrm
[ -f $data_dir/control ] && rm -f debian/control && cp $data_dir/control debian/
[ -f $data_dir/changelog ] && rm -f debian/changelog && cp $data_dir/changelog debian/
#if [ ! -f $data_dir/deploy-mon.links ]; then
#   echo "File $data_dir/deploy-mon.links not found!"
#   exit 1
#else
#   cp $data_dir/deploy-mon.links $pckg_dir/debian/
#fi

#Remove .ex files
rm debian/*.ex

#Edit config files
echo "Please, check config file install"
nano debian/install
echo "Please, check config file changelog"
nano debian/changelog
echo "Please, check config file control"
nano debian/control
echo "Please, check config file preinst"
nano debian/preinst
echo "Please, check config file postinst"
nano debian/postinst
echo "Please, check config file postrm"
nano debian/postrm

#Create a pckg with sign
debuild -b  && echo "Package created" || exit 1

echo "Done"
