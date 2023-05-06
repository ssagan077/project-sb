
#!/bin/bash
# Check the script is being run by user (no sudo)

if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
#Our Variables
source ca_paths.sh

#This send signed requests to PCKG server
function send_signed_req() {
  srv_hostname=$1
  #rdir=server or client request
  rdir=$2
  signed_file=$3
  echo -e "\nSending signed request to PCKG server..."
  scp $signed_file ${USER}@${pckg_address}:${remote_out_dir}/${srv_hostname}/${rdir}/ && echo "Signed request was sent"
}

function remove_remote_file() {
  srv_hostname=$1
  #rdir=server or client request
  rdir=$2
  req_file=$3
  echo -e "\nRemoving request from PCKG server..."
  echo -e "rm ${remote_in_dir}/${srv_hostname}/${rdir}/${req_file}" | sftp ${op_user}@${pckg_address} -b && echo "Request file ${req_file} was removed"
}

function sign_request() {
  full_path=$1
  rdir=$2
  srv_hostname=$3
  cd $rsa_dir
  #Import request
  for req_file in ${full_path}/*.req
  do
      [ -e "$req_file" ] || continue
      file_name=$(basename $req_file .req)
      echo -e "\nRequest file: ${file_name}"
      ./easyrsa import-req $req_file $file_name && echo -e "\nRequest has been imported"
      if [ $? -ne 0 ]; then echo -e "\nCan't import request. Probably you need to remove previous request file in ${rsa_dir}/pki/reqs/"; continue; fi
       #Sign request
      ./easyrsa sign-req $rdir $file_name && echo "Request has been signed"
      if [ $? -ne 0 ]; then echo -e "\nCan't sign request. Please check log files"; continue; fi
      signed_file=${rsa_dir}/pki/issued/${file_name}.crt
      send_signed_req "$srv_hostname" "$rdir" "$signed_file"
      if [ $? -ne 0 ]; then
          echo -e "\nCan't send signed request. Probably OVPN server doesn't have our public key"
          echo "Run script copy_pub_key2pckg.sh"
          sleep 2
          continue
          #exit 1
      else
          # Cleaning input directories
          remove_remote_file "$srv_hostname" "$rdir" "${file_name}.req"
          rm "${rsa_dir}/pki/reqs/${file_name}.req"
          #rm "${exch_dir}/$rdir/${file_name}.req"
      fi
      if [ $rdir = "server" ]; then
          signed_file="${rsa_dir}/pki/ca.crt"
          send_signed_req "$srv_hostname" "$rdir" "$signed_file"
      fi
  done
}

#Checking current folder
function check_folder() {
#Checking if folder exists
srv_hostname=$1
curr_dir="${exch_dir}/in/${srv_hostname}"
if [ -d "${curr_dir}" ]; then
   #Checking if *.req exists
   echo -e "\nChecking requests from the server ${srv_hostname}"
   if [ $(find "${curr_dir}/server/" -type f -name *.req | wc -l) -eq 0 ]; then
      echo "There are no server requests..."
   else
       sign_request "${curr_dir}/server" "server" "$srv_hostname"
       if [ $? -ne 0 ]; then
          echo "There are errors on signing requests"
     	  #exit 1
       fi
   fi
   if [ $(find "${curr_dir}/client/" -type f -name *.req | wc -l) -eq 0 ]; then
       echo "There are no client requests..."
       #exit 1
   else
       sign_request "${curr_dir}/client" "client" "$srv_hostname"
       if [ $? -ne 0 ]; then
          echo "There are errors on signing requests"
     	  #exit 1
       fi
   fi
fi
}

# Checking Easy-RSA
if [ ! -d "/usr/share/easy-rsa" ]; then
    echo "Easy-RSA has not installed. Run another script first!"
    exit 1
fi
echo "Checking easy-rsa directory..."
if [ ! -d "$rsa_dir/pki" ]; then
   echo "Directory ~/easy-rsa/pki does not exist. Run another script first!"
   exit 1
fi

#Checking connection
check_connect $pckg_address

#copy all exchange folders
cd $exch_dir
echo -e "get -r ${remote_in_dir}" | sftp "${op_user}@${pckg_address}"
if [ $? -ne 0 ]; then
   echo "ERROR: can't copy exchange folder"
   exit 1
fi

#Checking all requests from OVPN server
check_folder $ovpn_server

#Checking all requests from Monitoring server
check_folder $mon_server

#Checking all requests from Package server
check_folder $pckg_server

#Checking all requests from Backup server
check_folder $back_server

#Removing temporary folder
cd $exch_dir
[ -d "in" ] && rm -r in && echo "Temporary folder deleted"
echo "Done"
