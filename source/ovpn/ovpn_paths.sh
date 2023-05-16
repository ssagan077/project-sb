#!/bin/bash
## This script contains variables used by other scripts, as well as some useful functions.

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
rsa_dir="/home/$op_user/easy-rsa"
ovpn_conf_dir="/etc/openvpn/server"
prom_ssl_dir="/etc/prometheus/ssl"
cli_conf_dir="/home/$op_user/client-conf"
exch_dir="/home/$op_user/exchange"
remote_exch_dir="/home/$op_user/exchange"
remote_in_dir="${remote_exch_dir}/in"
remote_out_dir="${remote_exch_dir}/out"
exch_srv_dir="${exch_dir}/server"
exch_cli_dir="${exch_dir}/client"
exch_revoke_dir="${exch_dir}/revoked"
domain_name="sigmanet.site"

#This for checking the packages installation
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
scp -i "/home/${op_user}/.ssh/id_rsa" test ${op_user}@${addr}:/tmp/ && echo "Ok"
if [ $? -ne 0 ]; then
   echo "Problem with uploading files to address $1"
   echo "Run script copy_pub_key2<HOST>.sh"
   exit 1
fi
}

#Copy exchange folder wuth requests from PCKG server
function copy_signed_reqs() {
rdir=$1
cd $exch_dir
echo "Copying exchange folder with ${rdir} requests..."
echo -e "get -r ${remote_out_dir}/${ovpn_server}/${rdir}/" | sftp -i "/home/${op_user}/.ssh/id_rsa" "${op_user}@${pckg_address}"
if [ $? -ne 0 ]; then
   echo "ERROR: can't copy exchange folder"
   exit 1
fi
}


#Remove request file on remote side
function remove_remote_req() {
rdir=$1
file_name=$2
echo "Removing request file ${file_name} in exchange folder..."
echo -e "rm ${remote_out_dir}/${ovpn_server}/${rdir}/${file_name}" | sftp -i "/home/${op_user}/.ssh/id_rsa" "${op_user}@${pckg_address}"
if [ $? -ne 0 ]; then
   echo "ERROR: can't copy exchange folder"
   exit 1
else
   echo "File removed"
fi
}
