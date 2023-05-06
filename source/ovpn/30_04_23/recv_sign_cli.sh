#!/bin/bash
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
      # Checking if file already exists in OVPN directory
      if [ -f ${cli_conf_dir}/keys/${file_name} ]; then
         echo "file $file_name already exists in directory $cli_conf_dir/keys. Please check"
         exit 1
      fi
      cp $crt_file ${cli_conf_dir}/keys/ && echo "File $crt_file has copied"
      if [ $? -ne 0 ]; then
          echo "Can't copy signed certificate"
          exit 1
      else
          rm $crt_file
      fi
      echo "Now we can create client configuration file. Please run script: make_cli_config.sh $(basename ${crt_file} .crt)"
done
