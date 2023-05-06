#!/bin/bash
# Check the script is being run by user (no sudo)
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
# Our Variables
source ca_paths.sh

echo "Preparing an environment.."
#Checking folders for echanging with OVPN-server
[ ! -d $exch_srv_dir ] && mkdir -p $exch_srv_dir
[ ! -d $exch_cli_dir ] && mkdir -p $exch_cli_dir

# Checking Easy-RSA
if [ ! -d "/usr/share/easy-rsa" ]; then
    echo "Easy-RSA is not installed. Run another script first!"
    exit 1
fi

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
chown -R $USER:$USER $rsa_dir
chmod 700 $rsa_dir

echo "We are ready for creating certificates..."

echo "Checking directory with keys..."
# Check if pki directory exists
if [ -d "$rsa_dir/pki" ]; then
   echo "Directory ~/easy-rsa/pki already exists. Please, remove it manually before continue"
   echo "Break"
   exit 1
fi

# init-pki
cd $rsa_dir
./easyrsa init-pki && echo "init-pki completed successfully" || exit 1

# Check our configuration file
if [ ! -f "$rsa_dir/vars" ]; then
   read -p "Can't find config file VARS, you may have missed installing deploy-ca package. Created it from template? y/n: " -n 1
   echo    # (optional) move to a new line
   if [[ $REPLY =~ ^[Yy]$ ]]; then
     #copy template
     cp vars.example vars
   else
     echo "To continue, please provide right configuration file VARS"
     exit 1
   fi
fi
echo "Please, check and edit configuration file vars..."
sleep 2
nano vars

echo "Building certificates..."
./easyrsa build-ca

# Checking ca.crt
if [ ! -f "pki/ca.crt" ]; then
   echo "ca.crt hasn't been created! Check configuration please and try again"
else
   echo "Done. ca.crt has been created, we can sign requests"
fi
