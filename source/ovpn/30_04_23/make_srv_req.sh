#!/bin/bash
# Check the script is being run by user (no sudo)

if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
#Our Variables
source ovpn_paths.sh

req_dir=$rsa_dir/pki/reqs


#This send server request to CA server
function send_request() {
  out_dir="$remote_exch_dir/server"
  echo "Sending request to CA server..."
  scp $req_dir/server.req $USER@$ca_address:$out_dir/ && echo "Server request has been sent"
}

# Checking Easy-RSA
if [ ! -d "/usr/share/easy-rsa" ]; then
    echo "Easy-RSA has not installed. Run another script first!"
    exit 1
fi

echo "Checking easy-rsa directory..."
if [ ! -d "$rsa_dir/pki" ]; then
   echo "Directory $rsa_dir/pki does not exist. Run another script first!"
   exit 1
fi
#Checking if server.req exists
if [ ! -f $req_dir/server.req ]; then
    echo "Creating server request..."
    cd $rsa_dir
    ./easyrsa gen-req server nopass && echo "Request has been created"
    if [ $? -ne 0 ]; then echo "Can't generate request. Please check log files"; exit 1; fi
else
    echo "Server request already exists. We will send it"
fi

send_request
if [ $? -ne 0 ]; then echo "Can't send server request. Probably CA server doesn't have our public key"
   #Copy public key to CA-server
   read -p "Are you sure you want to copy the ssh public key to the CA-server? y/n: " -n 1 -r
   echo    # (optional) move to a new line
   if [[ $REPLY =~ ^[Yy]$ ]]
      then
      ssh-copy-id $USER@$ca_address && echo -e "\nssh keys copied to CA-server"
      if [ $? -ne 0 ]; then
          echo "Can't copy public key"
          echo "Run script copy_pub_key2ca.sh"
          sleep 3
          exit 1
      else
         send_request
         if [ $? -ne 0 ]; then echo "Can't send server request. Please check log files"; exit 1; fi
      fi
   else
      echo "Break"
      exit 1
   fi
fi
# Removing server request
##if [ -f $req_dir/server.req ]; then rm -f $req_dir/server.req; fi

echo "Next step: sign request on CA server (run make_sign_req.sh on CA server) and run script recv_sign_srv.sh"
