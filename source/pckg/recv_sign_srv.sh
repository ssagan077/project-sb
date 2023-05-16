#!/bin/bash
## This script checks for signed server certificates in the exchange folder with the CA server,
## copies them to the appropriate directories, restarts services using these certificates

# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
#Our Variables
source pckg_paths.sh

req_dir=$exch_srv_dir_out
key_dir="/home/${op_user}/ssl"

#Check SSL NGINX directory
[ ! -d ${nginx_ssl_dir} ] && mkdir ${nginx_ssl_dir}
[ ! -d ${prom_ssl_dir} ] && mkdir ${prom_ssl_dir}


#Checking exchange dir with signed server requests

if [ ! -d $req_dir ]; then
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
      fi
done

#Checking main certificate
if [ ! -f "${nginx_ssl_dir}/server-pckg.crt" ]; then
   echo "There is no file ${nginx_ssl_dir}/server-pckg.crt. Please, send request to CA server: run script make_srv_req.sh"
else
   # Add server certificate to Prometheus
   if [ ! -f "${prom_ssl_dir}/server-pckg.crt" ]; then
      cp "${nginx_ssl_dir}/server-pckg.crt" "${prom_ssl_dir}/"
      chmod 644 "${prom_ssl_dir}/server-pckg.crt"
   fi
fi
if [ ! -f "${nginx_ssl_dir}/ca.crt" ]; then
   echo "There is no file ${nginx_ssl_dir}/ca.crt. Please, send request to CA server: run script make_srv_req.sh"
else
   # Add root certificate to Prometheus
   if [ ! -f "${prom_ssl_dir}/ca.crt" ]; then
      cp "${nginx_ssl_dir}/ca.crt" "${prom_ssl_dir}/"
      chmod 644 "${prom_ssl_dir}/ca.crt"
   fi
   #Add root certificate to system
   if [ ! -f "/usr/local/share/ca-certificates/ca.crt" ]; then
       cp "${nginx_ssl_dir}/ca.crt" /usr/local/share/ca-certificates/
       update-ca-certificates -v
   fi
fi
# Copying server secret key to NGINX and Prometheus conf directory
if [ ! -f "$nginx_ssl_dir/server-pckg.key" ]; then
   if [ -f "${key_dir}/server-pckg.key" ]; then
      cp "${key_dir}/server-pckg.key" "${nginx_ssl_dir}/" && echo "File server-pckg.key has been copied to NGINX"
      chmod 600 "${nginx_ssl_dir}/server-pckg.key"
      cp "${key_dir}/server-pckg.key" "${prom_ssl_dir}/" && echo "File server-pckg.key has been copied to Prometheus"
      if [ $? -ne 0 ]; then
         rm -f "${key_dir}/server-pckg.key"
      fi
      chown prometheus:prometheus "${prom_ssl_dir}/server-pckg.key"
      chmod 600 "${prom_ssl_dir}/server-pckg.key"
   else
      echo "There is no file ${key_dir}/server-pckg.key. Please, fix it."; exit 1
   fi
fi

#restart nginx and Prometheus servers
[ -f /etc/nginx/sites-enabled/default ] && rm -f /etc/nginx/sites-enabled/default
[ -f /etc/nginx/sites-available/nginx-pckg.conf ] && ln -s /etc/nginx/sites-available/nginx-pckg.conf /etc/nginx/sites-enabled/nginx-pckg.conf
echo "Restarting NGINX service..."
invoke-rc.d nginx restart
echo "Restarting Prometheus service..."
invoke-rc.d prometheus-node-exporter restart
invoke-rc.d prometheus-nginx-exporter restart

echo "Done"
