#!/bin/bash
## This script checks for signed server certificates in the exchange folder with the CA server,
## copies them to the appropriate directories, restarts services using these certificates


# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
#Our Variables
source ovpn_paths.sh

req_dir=$exch_srv_dir
key_dir=${rsa_dir}/pki/private

#Checking connection to PCKG server
check_connect $pckg_address

#Copying exchange dir with signed server requests
copy_signed_reqs "server"
if [ ! -d $exch_srv_dir ]; then
   echo "There is no directory with signed server requests. Abort operation"
   exit 1
fi

#Checking if *.crt exists
if [ $(find ${req_dir}/ -type f -name *.crt | wc -l) -eq 0 ]; then
    echo "There are no signed server requests..."
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
      if [ -f "${ovpn_conf_dir}/${file_name}" ]; then
         echo "file ${file_name} already exists in directory ${ovpn_conf_dir}. Please check"
         continue
      fi
       cp $crt_file ${ovpn_conf_dir}/ && echo "File $crt_file has copied"
      if [ $? -ne 0 ]; then
          echo "Can't copy signed certificate"
          continue
      else
         rm $crt_file
         remove_remote_req "server" "${file_name}"
      fi
done

#Checking main certificates
if [ ! -f "${ovpn_conf_dir}/server.crt" ]; then
   echo "There is no file ${ovpn_conf_dir}/server.crt. Please, send request to CA server: run script make_srv_req.sh"
   exit 1
else
    # Add server certificate to Prometheus ssl folder
   if [ ! -f "${prom_ssl_dir}/server.crt" ]; then
      cp "${ovpn_conf_dir}/server.crt" "${prom_ssl_dir}/"
      chmod 644 "${prom_ssl_dir}/server.crt"
   fi
fi
if [ ! -f "${ovpn_conf_dir}/ca.crt" ]; then
   echo "There is no file ${ovpn_conf_dir}/ca.crt. Please, send request to CA server: run script make_srv_req.sh"
else
   # Add root certificate to Prometheus folder
   if [ ! -f "${prom_ssl_dir}/ca.crt" ]; then
      cp "${ovpn_conf_dir}/ca.crt" "${prom_ssl_dir}/"
      chmod 644 "${prom_ssl_dir}/ca.crt"
   fi
   #Add root certificate
   if [ ! -f "/usr/local/share/ca-certificates/ca.crt" ]; then
       cp "${ovpn_conf_dir}/ca.crt" /usr/local/share/ca-certificates/
       update-ca-certificates -v
   fi
fi

# Copying tls-crypt key to OVPN conf directory
if [ ! -f "${ovpn_conf_dir}/ta.key" ]; then
   if [ -f "${rsa_dir}/ta.key" ]; then
       cp "${rsa_dir}/ta.key" ${ovpn_conf_dir}/ && echo "File ta.key has copied"
   else
     echo "There is no file $rsa_dir/ta.key. Please, fix it. Probably you need to run script make_env_ovpn.sh"
     exit 1
   fi
fi

# Copying server secret key to OVPN and prometheus-node-exporter config directory
if [ ! -f "${ovpn_conf_dir}/server.key" ]; then
   if [ -f "${key_dir}/server.key" ]; then
      cp "${key_dir}/server.key" "${ovpn_conf_dir}/" && echo "File server.key has been copied to OVPN"
      chmod 600 "${ovpn_conf_dir}/server.key"
      cp "${key_dir}/server.key" "${prom_ssl_dir}/" && echo "File server.key has been copied to Prometheus"
      if [ $? -ne 0 ]; then
         rm -f "${key_dir}/server.key"
      fi
      chown prometheus:prometheus "${prom_ssl_dir}/server.key"
      chmod 600 "${prom_ssl_dir}/server.key"
   else
      echo "There is no file ${key_dir}/server.key. Please, fix it."; exit 1
   fi
fi

# Copying config files to Clients keys directory
 cp "${ovpn_conf_dir}/ta.key" "${cli_conf_dir}/keys/"
 cp "${ovpn_conf_dir}/ca.crt" "${cli_conf_dir}/keys/"
if [ -f "${ovpn_conf_dir}/cli_base.conf" ]; then
    cp "${ovpn_conf_dir}/cli_base.conf" "${cli_conf_dir}/keys/"
else
   echo "There is no client configuration file cli_base.conf in OVPN config folder. You may have missed installing deb-package"
   sleep 3
fi
if [ -f "${ovpn_conf_dir}/cli_base_wsk.conf" ]; then
    cp "${ovpn_conf_dir}/cli_base_wsk.conf" "${cli_conf_dir}/keys/"
else
   echo "There is no client configuration file cli_base_wsk.conf in OVPN config folder. You may have missed installing deb-package"
   sleep 3
fi

# Checking configuration file
if [ ! -f "${ovpn_conf_dir}/server.conf" ]; then
   echo "There is no file ${ovpn_conf_dir}/server.conf. Please, fix it. Probably you need to run script make_env_ovpn.sh"
   exit 1
fi

#restart ovpn server
echo "Restarting OVPN service..."
if [ $(systemctl is-enabled openvpn-server@server.service) != "enable" ]; then
    systemctl enable openvpn-server@server.service
fi
systemctl restart openvpn-server@server.service

echo "Restarting Prometheus-node-exporter service..."
#if [ -f /etc/default/prometheus-node-exporter_ovpn ]; then
#  cp /etc/default/prometheus-node-exporter_ovpn /etc/default/prometheus-node-exporter
#  if [ $? -ne 0 ]; then
#     rm -f "/etc/default/prometheus-node-exporter_ovpn"
#  fi
  if [ $(systemctl is-enabled prometheus-node-exporter.service) != "enable" ]; then
      systemctl enable prometheus-node-exporter.service
  fi
  systemctl restart prometheus-node-exporter.service
#else
#  echo "There is no file /etc/default/prometheus-node-exporter_ovpn. You may have missed installing deploy_ovpn package"
#fi
echo "Restarting openvpn-exporter service..."
if [ $(systemctl is-enabled openvpn-exporter.service) != "enable" ]; then
    systemctl enable openvpn-exporter.service
fi
systemctl restart openvpn-exporter.service

#Opening access to the status file for the openvpn-exporter
if [ -f /var/log/openvpn/openvpn-status.log ]; then
   chmod +r /var/log/openvpn/openvpn-status.log
fi

echo "Now we can create client requests. Run script make_cli_req.sh <CLIENT_NAME>"
