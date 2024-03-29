#!/bin/bash
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi

#Our Variables
source mon_paths.sh

#Client name (for secure connection to Prometheus exporters)
cli_name="client-mon"
req_dir="/home/${op_user}/ssl"

#This send server request to CA server
function send_request() {
  cli_file="${cli_name}.req"
  out_dir="$remote_in_dir/${mon_server}/client"
  echo "Sending request to CA server..."
  scp "${req_dir}/${cli_file}" ${op_user}@$pckg_address:$out_dir/ && echo "Client request has been sent"
}

# Checking server certificate
if [ -f '/etc/nginx/ssl/server-mon.crt' ]; then
    echo -e "\nPlease, sign server request first"
    exit 1
fi

echo -e "\nGenerating SSL keys and request..."
if [ ! -d $req_dir ]; then
   mkdir $req_dir
fi

cd $req_dir
if openssl genrsa -out "${cli_name}.key" 4096
then
  echo "Key generated"
else
  echo "Can't generate secret key" ; exit 1
fi

#Checking if server-mon.req exists
if [ ! -f "${req_dir}/${cli_name}.req" ]; then
   echo "Creating client request..."
   openssl req -new -subj "/C=ME/ST=./L=Moscow/O=SigmaNet/OU=IT/CN=${mon_server}.${domain_name}" -key ${cli_name}.key -out ${cli_name}.req && echo "Request created"
   if [ $? -ne 0 ]; then echo "Can't generate request. Please check log files"; exit 1; fi
else
    echo "Server request already exists. We will send it"
fi

#Checking connection
check_connect $pckg_address

#Sending request
send_request
if [ $? -ne 0 ]; then echo "Can't send client request. Probably PCKG server doesn't have our public key"
   echo "or exchange directory doesn't exist. Please, fix it"
   exit 1
fi

echo "Next step: sign request on CA server (run make_sign_req.sh on CA server) and run script recv_sign_cli.sh"
