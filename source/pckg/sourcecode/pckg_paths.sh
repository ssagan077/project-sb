#!/bin/bash
op_user="ssagan077"
ovpn_address="10.186.0.4"   ## Change to 10.88.10.3 after testing !!!!!!
ca_address="10.88.10.4"  ## Change to 10.88.10.2 after testing !!!!!!
pckg_address="10.88.10.6"
ovpn_server="vm-ovpn-srv"
mon_server="vm-mon-srv"
rsa_dir="/home/$op_user/easy-rsa"
exch_dir="/home/$op_user/exchange"
exch_in_dir="/home/$op_user/exchange/in"
exch_out_dir="/home/$op_user/exchange/out"

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
scp test ${USER}@${addr}:/tmp/ && echo "Ok"
if [ $? -ne 0 ]; then
   echo "Problem with uploading files to address $1"
   echo "Run script copy_pub_key2<HOST>.sh"
   exit 1
fi
}
