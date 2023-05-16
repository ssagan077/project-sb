#!/bin/bash
## This script is required to add the user's public key to the OpenVPN server (vm-ovpn-srv).
## This action is necessary to provide CRL directly to the vm-ovpn-srv
## In order for the copying procedure to be successful,
## you must install first a deb package with a temporary ssh configuration on the vm-ovpn-srv server
## (immediately remove it after copying!!!)

# Check the script is being run by user (no sudo)
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
#Our Variables
source ca_paths.sh

#Create folder for echanging with OVPN-server
[ ! -d $exch_srv_dir ] && mkdir -p $exch_srv_dir
[ ! -d $exch_cli_dir ] && mkdir -p $exch_cli_dir

#Create pub and secret ssh keys for exchanging with OVPN-server
if [ ! -f /home/${op_user}/.ssh/id_rsa.pub ]; then
  echo "Creating ssh keys..."
  ssh-keygen -t rsa && echo "ssh keys created" || exit 1
fi
#Copy public key to OVPN-server
read -p "Are you sure you want to copy the public key to the OVPN-server? y/n: " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
      then
      ssh-copy-id ${op_user}@${ovpn_address} && echo -e "\nssh keys have copied to OVPN-server"
      if [ $? -ne 0 ]; then
          echo -e "\nCan't copy pulic key. Probably there is network problem "
          echo "or you should install package deb-ssh-tmp on OVPN server "
          echo "run on OVPN server: sudo apt-get install deb-ssh-tmp"
          echo "!!!after copying the key, please remove this package!!!"
          echo "run on OVPN server: sudo apt-get remove deb-ssh-tmp"
          read -p "Retry copying after installing the package on OVPN server? n - abort the operation. y/n: " -n 1 -r
                echo    # (optional) move to a new line
          if [[ $REPLY =~ ^[Yy]$ ]]; then
                ssh-copy-id ${op_user}@${ovpn_address} && echo -e "\nssh keys copied to OVPN-server"
                if [ $? -ne 0 ]; then
                    echo "Can't copy public key"
                    exit 1
                fi
          else exit 1
          fi
      fi
 else
      echo "Break"
      exit 1
 fi
echo "Done. Now we can send signed requests to OVPN server"
