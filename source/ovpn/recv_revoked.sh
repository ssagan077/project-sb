#!/bin/bash
## This script checks for the presence of a CRL-list in the exchange directory with the CA. 
## If it exists, copies it to the openvpn server configuration directory and restarts the service

# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root (sudo)"
   exit 1
fi
#Our Variables
source ovpn_paths.sh

#Checking directory
if [ ! -d $exch_revoke_dir ]; then
   echo "There is no directory ${exch_revoke_dir}. Abort operation"
   exit 1
fi


#Checking if *.pem exists
if [ $(find ${exch_revoke_dir}/ -type f -name *.pem | wc -l) -eq 0 ]; then
    echo "There is no list of revoked certificates..."
    exit 1
fi

cd ${exch_revoke_dir}
#Import certificates
for pem_file in ${exch_revoke_dir}/*.pem
do
      if [[ ! -e "$pem_file" ]]; then continue; fi
      echo $pem_file
      cp $pem_file ${ovpn_conf_dir}/ && echo "File $pem_file has copied"
      if [ $? -ne 0 ]; then
          echo "Can't copy list of revoked certificates"
          continue
      else
          rm $pem_file
      fi
done

echo "Restart OpenVPN server..."
systemctl restart openvpn-server@server.service
