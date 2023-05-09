#!/bin/bash

op_user="ssagan077"
ovpn_address="10.88.10.3"   ## Change to 10.88.10.3 after testing !!!!!!
ca_address="10.88.10.2"  ## Change to 10.88.10.2 after testing !!!!!!
pckg_address="10.88.10.6"
mon_address="10.88.10.4"
back_address="10.88.10.5"
ovpn_server="vm-ovpn-srv"
mon_server="vm-mon-srv"
pckg_server="vm-pckg-srv"
back_server="vm-backup-srv"
nginx_ssl_dir="/etc/nginx/ssl"
prom_ssl_dir="/etc/prometheus/ssl"
git_dir="/home/${op_user}/project-sb"  ## git dir

exch_dir="/home/$op_user/exchange"
exch_in_dir="${exch_dir}/in"        ## Directory for requests 
exch_out_dir="${exch_dir}/out"      ## Directory for signed certificates
exch_srv_dir_in="${exch_in_dir}/${pckg_server}/server"
exch_cli_dir_in="${exch_in_dir}/${pckg_server}/client"
exch_srv_dir_out="${exch_out_dir}/${pckg_server}/server"
exch_cli_dir_out="${exch_out_dir}/${pckg_server}/client"
exch_revoke_dir="${exch_dir}/revoked"
domain_name="sigmanet.site"

function check_installed() {
soft=$1
echo "Checking ${soft}..."
if dpkg -l $soft &> /dev/null
then
   echo "$soft installed"
else
   if apt-get install $soft
   then
       echo "$soft installed"
    else
       echo "ERROR: Can't install $soft. Please, try it manually"
       exit 1
    fi
fi
}

#This for Checking connection
function check_connect() {
echo "Checking connection with $1..."
echo "test" > test
addr=$1
scp test ${op_user}@${addr}:/tmp/ && echo "Ok"
if [ $? -ne 0 ]; then
   echo "Problem with uploading files to address $1"
   echo "Run script copy_pub_key2<HOST>.sh"
   exit 1
fi
}
