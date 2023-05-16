#!/bin/bash
## This script checks for signed client certificates in the exchange directory with the CA.
## Script is not currently used (At this time we don't use client certificates for connections to exporters).


# Check the script is being run by root (with sudo)
if [ "$(id -u)" = "0" ]; then
   echo "This script must be run as user, not root"
   exit 1
fi
#Our Variables
source ovpn_paths.sh

#ovpn_conf_dir=/etc/openvpn/server
req_dir=$exch_cli_dir
#Checking if *.req exists
if [ $(find ${req_dir}/ -type f -name *.crt | wc -l) -eq 0 ]; then
    echo "There are no signed client requests..."
    exit 1
fi

cd $req_dir
#Import certificates
for crt_file in ${req_dir}/*.crt
do
      if [[ ! -e "$crt_file" ]]; then continue; fi
      echo $crt_file
      file_name=$(basename $crt_file)
      # Checking if file already exists in Prometheus directory
      if [ -f ${prom_ssl_dir}/${file_name} ]; then
         echo "file $file_name already exists in directory $prom_ssl_dir. Please check"
         exit 1
      fi
      cp $crt_file ${prom_ssl_dir}/ && echo "File $crt_file has copied"
      if [ $? -ne 0 ]; then
          echo "Can't copy signed certificate"
          exit 1
      else
          rm $crt_file
      fi
      echo "Client certificate has been signed. Please, reload Prometheus configuration..."
done
