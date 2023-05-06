#!/bin/bash
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
#Our Variables
source mon_paths.sh

req_dir="/home/${op_user}/ssl"

#This send server request to CA server
function send_request() {
  out_dir="${remote_in_dir}/${mon_server}/server"
  echo "Sending request to CA server..."
  scp "${req_dir}/server-mon.req" ${op_user}@${pckg_address}:${out_dir}/ && echo "Server request has been sent"
}

# Checking ssl keys
if [ -f '/etc/nginx/ssl/server-mon.crt' ]; then
    echo -e "\nLooks like the ssl keys are already created. Exit"
    exit 1
fi
echo -e "\nGenerating SSL keys and request..."

if [ ! -d $req_dir ]; then
   mkdir $req_dir
fi

cd $req_dir
if openssl genrsa -out server-mon.key 4096
then
  echo "Key generated"
else
  echo "Can't generate secret key" ; exit 1
fi

#Checking if server-mon.req exists
if [ ! -f "${req_dir}/server-mon.req" ]; then
   echo "Creating server request..."
   openssl req -new -subj "/C=ME/ST=./L=Herceg Novi/O=SigmaNet/OU=IT/CN=${mon_server}.${domain_name}" -key server-mon.key -out server-mon.req && echo "Request created"
   if [ $? -ne 0 ]; then echo "Can't generate request. Please check log files"; exit 1; fi
else
    echo "Server request already exists. We will send it"
fi

#Checking connection
check_connect $pckg_address

#Sending request
send_request
if [ $? -ne 0 ]; then echo "Can't send server request. Probably PCKG server doesn't have our public key"
   echo "or exchange directory doesn't exist. Please, fix it"
   exit 1
fi

# Removing server request
##if [ -f $req_dir/server.req ]; then rm -f $req_dir/server.req; fi

echo "Next step: sign request on CA server (run make_sign_req_all.sh on CA server) and run script recv_sign_srv.sh"
