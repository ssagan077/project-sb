#!/bin/bash
# Check the script is being run by root (with sudo)

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
#Our Variables
source mon_paths.sh

req_dir=$exch_srv_dir
key_dir="/home/${op_user}/ssl"

#Check SSL NGINX directory
[ ! -d ${nginx_ssl_dir} ] mkdir ${nginx_ssl_dir}
[ ! -d ${prom_ssl_dir} ] mkdir ${prom_ssl_dir}

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
for crt_file in $req_dir/*.crt
do
      if [[ ! -e "$crt_file" ]]; then continue; fi
      echo $crt_file
      file_name=$(basename $crt_file)
      # Checking if file already exists in NGINX directory
      if [ -f "${nginx_ssl_dir}/${file_name}" ]; then
         echo "file ${file_name} already exists in directory ${nginx_ssl_dir}. Please check"
         continue
      fi
         cp $crt_file "${nginx_ssl_dir}/" && echo "File $crt_file has been copied"
      if [ $? -ne 0 ]; then
          echo "Can't copy signed certificate"
          continue
      else
         rm $crt_file
         remove_remote_req "server" "${file_name}"
      fi
done

#Checking main certificate
if [ ! -f "${nginx_ssl_dir}/server-mon.crt" ]; then
   echo "There is no file ${nginx_ssl_dir}/server-mon.crt. Please, send request to CA server: run script make_srv_req.sh"
else
   # Add server certificate to Prometheus
   if [ ! -f "${prom_ssl_dir}/server-mon.crt" ]; then
      cp "${nginx_ssl_dir}/server-mon.crt" "${prom_ssl_dir}/"
   fi
fi
if [ ! -f "${nginx_ssl_dir}/ca.crt" ]; then
   echo "There is no file ${nginx_ssl_dir}/ca.crt. Please, send request to CA server: run script make_srv_req.sh"
else
   # Add root certificate to Prometheus
   if [ ! -f "${prom_ssl_dir}/ca.crt" ]; then
      cp "${nginx_ssl_dir}/ca.crt" "${prom_ssl_dir}/"
   fi
   #Add root certificate to system
   if [ ! -f "/usr/local/share/ca-certificates/ca.crt" ]; then
       cp "${nginx_ssl_dir}/ca.crt" /usr/local/share/ca-certificates/
       update-ca-certificates -v
   fi
fi

# Copying server secret key to NGINX and Prometheus conf directory
if [ ! -f "$nginx_ssl_dir/server-mon.key" ]; then
   if [ -f "${key_dir}/server-mon.key" ]; then
      cp "${key_dir}/server-mon.key" "${nginx_ssl_dir}/" && echo "File server-mon.key has been copied to NGINX"
      chmod 600 "${nginx_ssl_dir}/server-mon.key"
      cp "${key_dir}/server-mon.key" "${prom_ssl_dir}/" && echo "File server-mon.key has been copied to Prometheus"
      if [ $? -ne 0 ]; then
         rm -f "${key_dir}/server-mon.key"
      fi
      chown prometheus:prometheus "${prom_ssl_dir}/server-mon.key"
      chmod 600 "${prom_ssl_dir}/server-mon.key"
   else
      echo "There is no file ${key_dir}/server-mon.key. Please, fix it."; exit 1
   fi
fi

#restart nginx and Prometheus servers
[ -f /etc/nginx/sites-enabled/default ] && rm -f /etc/nginx/sites-enabled/default
[ -f /etc/nginx/sites-available/nginx-mon.conf ] && ln -s /etc/nginx/sites-available/nginx-mon.conf /etc/nginx/sites-enabled/nginx-mon.conf
echo "Restarting NGINX service..."
invoke-rc.d nginx restart
echo "Restarting Prometheus service..."
invoke-rc.d prometheus restart
invoke-rc.d prometheus-node-exporter restart
invoke-rc.d prometheus-nginx-exporter restart
invoke-rc.d prometheus-blackbox-exporter restart
invoke-rc.d prometheus-alertmanager restart

echo "Done"
##echo "Now we can create client requests. Please, run script make_cli_req.sh"
