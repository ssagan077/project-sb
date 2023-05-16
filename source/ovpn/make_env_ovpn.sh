#!/bin/bash
## This script checks for the installation of all necessary packages,
## sets up the easy-rsa environment for generating private keys, certificate requests, and so on.

# Check the script is being run by user (no sudo)
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
#Our Variables
source ovpn_paths.sh

# Checking Easy-RSA
if [ ! -d "/usr/share/easy-rsa" ]; then
    echo "Easy-RSA is not installed. Run another script first!"
    exit 1
fi

echo "Preparing an environment.."
#Create folders for echanging with CA-server
[ ! -d $exch_dir ] && mkdir -p $exch_dir
#[ ! -d $exch_cli_dir ] && mkdir -p $exch_cli_dir
[ ! -d $exch_revoke_dir ] && mkdir -p $exch_revoke_dir

if [ ! -d "$rsa_dir" ]; then mkdir $rsa_dir
else
   # Delete all symlinks in directory easy-rsa
    echo "Removing old synlinks..."
   find $rsa_dir -type l -delete
   if [ $? -ne 0 ]; then echo "Can't delete symlinks in directory easy-rsa"; exit 1; fi
fi

#Create symlinks in our home directory
if ln -s /usr/share/easy-rsa/* $rsa_dir; then
 echo "Symlinks created"
else
 echo "Can't create symlink on directory easy-rsa. Break" ; exit 1
fi
chown -R ${op_user}:${op_user} $rsa_dir
chmod 700 ~/easy-rsa

#Checking clients config and keys dir
if [ ! -d "$cli_conf_dir/keys" ]; then
   mkdir -p "$cli_conf_dir/keys"
   chmod -R 700 $cli_conf_dir
fi

echo "We are ready for creating certificates..."

echo "Checking directory with keys..."
# Check if еру pki directory exists
if [ -d "$rsa_dir/pki" ]; then
   echo "Directory $rsa_dir/pki already exists. Please, remove it manually before continue"
   echo "Break"
   exit 1
fi

# init-pki
cd $rsa_dir
./easyrsa init-pki && echo "init-pki completed successfully" || exit 1

# Check our configuration file
if [ ! -f "$rsa_dir/vars" ]; then
   read -p "Can't find config file VARS, you may missed installing deploy-ovpn package. Created it from template? y/n: ">   echo    # (optional) move to a new line
   if [[ $REPLY =~ ^[Yy]$ ]]; then
     #copy template
     cp vars.example vars
   else
     echo "To continue, please provide right config file vars"
     exit 1
   fi
fi
echo "Please, check and edit configuration file vars..."
sleep 2
nano vars


#Checking OpenVPN config file
if [ ! -f $ovpn_conf_dir/server.conf ]; then
      echo "There is no OVPN server configuration file /etc/openvpn/server/server.conf. You may have missed installing deb-package."
      exit 1
      #cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf $ovpn_conf_dir/
fi

#Make tls-crypt key
if [ ! -f "$rsa_dir/ta.key" ] && [ ! -f "$ovpn_conf_dir/ta.key" ]; then
    /usr/sbin/openvpn --genkey secret ta.key &>/dev/null && echo "tls-crypt key has been created"
    if [ $? -ne 0 ]; then echo "Can't create tls-crypt key. Check if openvpn is installed"; exit 1; fi
fi

#Create pub and secret ssh keys for exchanging with CA-server
if [ ! -f /home/$USER/.ssh/id_rsa.pub ]; then
  echo "Creating ssh keys..."
  ssh-keygen -t rsa && echo "ssh keys created" || exit 1
fi
#Copy public key to PCKG-server
read -p "Are you sure you want to copy the public key to the PCKG-server? y/n: " -n 1
   echo    # (optional) move to a new line
   if [[ $REPLY =~ ^[Yy]$ ]]
      then
      ssh-copy-id ${op_user}@$pckg_address && echo "ssh keys has copied to PCKG-server" || exit 1
   fi
echo "Done. Now we can create requests to CA server"
