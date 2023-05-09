#!/bin/bash
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi

#Our Variables
source pckg_paths.sh

#Checking exchange directories
#Create folder for echanging with CA-server
[ ! -d ${exch_srv_dir_in} ] && mkdir -p ${exch_srv_dir_in}
[ ! -d ${exch_cli_dir_in} ] && mkdir -p ${exch_cli_dir_in}
[ ! -d ${exch_srv_dir_out} ] && mkdir -p ${exch_srv_dir_out}
[ ! -d ${exch_cli_dir_out} ] && mkdir -p ${exch_cli_dir_out}

[ ! -d "${exch_in_dir}/${mon_server}/server" ] && mkdir -p "${exch_in_dir}/${mon_server}/server"
[ ! -d "${exch_in_dir}/${mon_server}/client" ] && mkdir -p "${exch_in_dir}/${mon_server}/client"
[ ! -d "${exch_out_dir}/${mon_server}/server" ] && mkdir -p "${exch_out_dir}/${mon_server}/server"
[ ! -d "${exch_out_dir}/${mon_server}/client" ] && mkdir -p "${exch_out_dir}/${mon_server}/client"

[ ! -d "${exch_in_dir}/${ovpn_server}/server" ] && mkdir -p "${exch_in_dir}/${ovpn_server}/server"
[ ! -d "${exch_in_dir}/${ovpn_server}/client" ] && mkdir -p "${exch_in_dir}/${ovpn_server}/client"
[ ! -d "${exch_out_dir}/${ovpn_server}/server" ] && mkdir -p "${exch_out_dir}/${ovpn_server}/server"
[ ! -d "${exch_out_dir}/${ovpn_server}/client" ] && mkdir -p "${exch_out_dir}/${ovpn_server}/client"

[ ! -d "${exch_dir}/revoked" ] && mkdir -p "${exch_dir}/revoked"

req_dir="/home/${op_user}/ssl"

#This send server request to CA server
function send_request() {
  echo "Sending request to CA server..."
  cp "${req_dir}/server-pckg.req" ${exch_srv_dir_in}/ && echo "Server request has been sent"
}

# Checking ssl keys
if [ -f '/etc/nginx/ssl/server-pckg.crt' ]; then
    echo -e "\nLooks like the ssl keys are already created. Exit"
    exit 1
fi
echo -e "\nGenerating SSL keys and request..."

if [ ! -d $req_dir ]; then
   mkdir $req_dir
fi

cd $req_dir
if openssl genrsa -out server-pckg.key 4096
then
  echo "Key generated"
else
  echo "Can't generate secret key" ; exit 1
fi

#Checking if server-pckg.req exists
if [ ! -f "${req_dir}/server-pckg.req" ]; then
   echo "Creating server request..."
   openssl req -new -subj "/C=ME/ST=./L=Herceg Novi/O=SigmaNet/OU=IT/CN=${pckg_server}.${domain_name}" -key server-pckg.key -out server-pckg.req && echo "Request created"
   if [ $? -ne 0 ]; then echo "Can't generate request. Please check log files"; exit 1; fi
else
    echo "Server request already exists. We will send it"
fi


#Sending request
send_request
if [ $? -ne 0 ]; then echo "Can't send server request. Check if directory ${exch_srv_dir_in} exists"
   exit 1
fi

# Removing server request
##if [ -f $req_dir/server.req ]; then rm -f $req_dir/server.req; fi

echo "Next step: sign request on CA server (run make_sign_req_all.sh on CA server) and run script recv_sign_srv.sh"
