#!/bin/bash
## This script builds a deb package to install the openvpn exporter.
## The package is built from a compiled binary and, when installed, installs a service to run the exporter.

# Check the script is being run by user (no sudo)
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi

#Our Variables
source pckg_paths.sh

packages_dir="${git_dir}/packages"
pckg_dir="${packages_dir}/ovpn-exporter-0.1"
data_dir="${git_dir}/source/ovpn-exp"

# Checking for installed software
check_installed "openssl"
check_installed "dh-make"
check_installed "dpkg-dev"
check_installed "gnupg"

#Checking packages directory
if [ ! -d ${packages_dir} ]; then
   #mkdir ${packages_dir}
   echo "There is no package directory. Run another script first (make_repo_clone)"
   exit 1
fi

cd ${packages_dir}

if [ ! -d $pckg_dir ]; then mkdir $pckg_dir
else
   echo "Directory $pckg_dir already exist. Please, remove it manually to continue setup"
   exit 1
fi

#Checking if pckg already exists
ls ovpn-exporter_* 2>/dev/null && echo "Package ovpn-exporter already exist. Please, remove it manually to continue setup" && exit 1

#Copy config files
echo "Copying config files..."

if [ ! -f ${data_dir}/ovpn_exp_list ]; then
   echo "File ${data_dir}/ovpn_exp_list not found!"
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
done < ${data_dir}/ovpn_exp_list

echo "Please edit ~/.bashrc; Add keys: export CITY, export DEBEMAIL, export DEBFULLNAME"
sleep 3
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
echo "openvpn_exporter usr/bin/" >> debian/install
echo "openvpn-exporter.service usr/lib/systemd/system/" >> debian/install

#Copy config files
[ -f $data_dir/preinst ] && cp $data_dir/preinst debian/ || cp debian/preinst.ex preinst
[ -f $data_dir/postinst ] && cp $data_dir/postinst debian/ || cp debian/postinst.ex postinst
[ -f $data_dir/prerm ] && cp $data_dir/prerm debian/
[ -f $data_dir/postrm ] && cp $data_dir/postrm debian/ || cp debian/postrm.ex postrm
[ -f $data_dir/control ] && rm -f debian/control && cp $data_dir/control debian/
[ -f $data_dir/changelog ] && rm -f debian/changelog && cp $data_dir/changelog debian/

#Remove .ex files
rm debian/*.ex

#Edit config files
if [ -f debian/install ]; then
  echo "Please, check config file install"
  nano debian/install
fi
if [ -f debian/changelog ]; then
  echo "Please, check config file changelog"
  nano debian/changelog
fi
if [ -f debian/control ]; then
  echo "Please, check config file control"
  nano debian/control
fi
if [ -f debian/preinst ]; then
  echo "Please, check config file preinst"
  nano debian/preinst
fi
if [ -f debian/postinst ]; then
  echo "Please, check config file postinst"
  nano debian/postinst
fi
if [ -f debian/postrm ]; then
  echo "Please, check config file postrm"
  nano debian/postrm
fi

#Create a pckg with sign
debuild -b  && echo "Package created" || exit 1

echo "Done"
