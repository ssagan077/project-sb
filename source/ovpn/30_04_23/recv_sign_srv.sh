#!/bin/bash
# Check the script is being run by root (with sudo)

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
#Our Variables
source ovpn_paths.sh

#ovpn_conf_dir=/etc/openvpn/server
req_dir=$exch_srv_dir
#Checking if *.req exists
if [ $(find $req_dir/ -type f -name *.crt | wc -l) -eq 0 ]; then
    echo "There are no signed server requests..."
    exit 1
fi

cd $req_dir
#Import certificates
for crt_file in $req_dir/*.crt
do
      if [[ ! -e "$crt_file" ]]; then continue; fi
      echo $crt_file
      file_name=$(basename $crt_file)
      # Checking if file already exists in OVPN directory
      if [ -f $ovpn_conf_dir/$file_name ]; then
         echo "file $file_name already exists in directory $ovpn_conf_dir. Please check"
         exit 1
      fi
      cp $crt_file $ovpn_conf_dir/ && echo "File $crt_file has copied"
      if [ $? -ne 0 ]; then
          echo "Can't copy signed certificate"
          exit 1
      else
         rm $crt_file
      fi
done

#Checking certificates
if [ ! -f "$ovpn_conf_dir/server.crt" ]; then
   echo "There is no file $ovpn_conf_dir/server.crt. Please, send request to CA server: run script make_srv_req.sh"
fi
if [ ! -f "$ovpn_conf_dir/ca.crt" ]; then
   echo "There is no file $ovpn_conf_dir/ca.crt. Please, send request to CA server: run script make_srv_req.sh"
fi

# Copying tls-crypt key to OVPN conf directory
if [ ! -f "$ovpn_conf_dir/ta.key" ]; then
   if [ -f "$rsa_dir/ta.key" ]; then
      cp "$rsa_dir/ta.key" $ovpn_conf_dir/ && echo "File ta.key has copied"
   else
     echo "There is no file $rsa_dir/ta.key. Please, fix it. Probably you need to run script make_env_ovpn.sh"
     exit 1
   fi
fi

# Copying server secret key to OVPN conf directory
if [ ! -f "$ovpn_conf_dir/server.key" ]; then
   if [ -f "$rsa_dir/pki/private/server.key" ]; then
      cp "$rsa_dir/pki/private/server.key" $ovpn_conf_dir/ && echo "File server.key has copied"
   else
     echo "There is no file $rsa_dir/pki/private/server.key. Please, fix it. Probably you need to run script make_env_ovpn.sh"
     exit 1
   fi
fi

# Copying config files to Clients keys directory
cp "$ovpn_conf_dir/ta.key" "$cli_conf_dir/keys/"
cp "$ovpn_conf_dir/ca.crt" "$cli_conf_dir/keys/"
if [ -f "$ovpn_conf_dir/cli_base.conf" ]; then
   cp "$ovpn_conf_dir/cli_base.conf" "$cli_conf_dir/keys/"
else
   echo "There is no client configuration file cli_base.conf in OVPN config folder. You may have missed installing deb-package"
   sleep 3
fi

# Checking configuration file
if [ ! -f "$ovpn_conf_dir/server.conf" ]; then
   echo "There is no file $ovpn_conf_dir/server.conf. Please, fix it. Probably you need to run script make_env_ovpn.sh"
   exit 1
fi

#restart ovpn server
echo "Restarting OVPN service..."
if [ $(systemctl is-enabled openvpn-server@server.service) != "enable" ]; then
   systemctl enable openvpn-server@server.service
fi
systemctl restart openvpn-server@server.service


echo "Now we can create client requests. Run script make_cli_req.sh <CLIENT_NAME>"
