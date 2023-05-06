#!/bin/bash
# Check the script is being run by user (no sudo)

if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
#Check parameters
if [ $# -eq 0 ]; then
   echo "Must be 1 parameter - client name! For example: make_cli_req.sh client1"
   exit 1
fi

#Our Variables
source ovpn_paths.sh

cli_name=$1
req_dir="${rsa_dir}/pki/reqs"

#This send server request to CA server (actually it's PCKG server)
function send_request() {
  cli_file="${cli_name}.req"
  out_dir="${remote_in_dir}/${ovpn_server}/client"
  echo "Sending request to CA server..."
  scp ${req_dir}/${cli_file} ${USER}@${pckg_address}:${out_dir}/ && echo "Client request has been sent"
}

# Checking server certificate
if [ ! -f "${ovpn_conf_dir}/server.crt" ]; then
   echo "Please, sign server request first"
   exit 1
fi

# Checking Easy-RSA
if [ ! -d "/usr/share/easy-rsa" ]; then
    echo "Easy-RSA has not installed. Run another script first!"
    exit 1
fi

echo "Checking easy-rsa directory..."
if [ ! -d "${rsa_dir}/pki" ]; then
   echo "Directory $rsa_dir/pki does not exist. Run another script first!"
   exit 1
fi

#Checking connection
check_connect $pckg_address

#Checking if client req exists
if [ ! -f ${req_dir}/${cli_name}.req ]; then
    echo "Creating client request..."
    cd ${rsa_dir}
    ./easyrsa gen-req ${cli_name} nopass && echo "Request has been created"
    if [ $? -ne 0 ]; then echo "Can't generate request. Please check log files"; exit 1; fi
    #Copying client secret key
    if [ -f "${rsa_dir}/pki/private/${cli_name}.key" ]; then
       cp "${rsa_dir}/pki/private/${cli_name}.key" "${cli_conf_dir}/keys/"
    else
       echo "ERROR: There is no ${cli_name} secret key! Abort"
       exit 1
    fi
else
    echo "Client request already exists. We will send it"
fi

send_request
if [ $? -ne 0 ]; then echo "Can't send client request. Probably PCKG server doesn't have our public key"
   echo "or exchange directory doesn't exist. Please, fix it"
   exit 1
fi


echo "Next step: sign request on CA server (run make_sign_req_all.sh on CA server) and run script recv_sign_cli.sh"
