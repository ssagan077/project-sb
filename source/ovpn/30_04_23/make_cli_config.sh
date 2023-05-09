#!/bin/bash
# Check the script is being run by root (with sudo)
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi

#Our Variables
source ovpn_paths.sh

# Directory where EasyRSA outputs the client keys and certificates
KEY_DIR=${cli_conf_dir}/keys

# Where this script should create the OpenVPN client config files
OUTPUT_DIR=$KEY_DIR

# Base configuration for the client
BASE_CONFIG=${KEY_DIR}/cli_base.conf
user_id=$1

 if [ "$user_id" == "" ]; then
      echo "ERROR: No user id provided"
      exit 1
 fi
 if [ ! -f ${KEY_DIR}/ca.crt ]; then
     echo "ERROR: CA certificate not found"
     exit 1
 fi

 if [ ! -f ${KEY_DIR}/${user_id}.crt ]; then
    echo "ERROR: User certificate not found"
    exit 1
 fi

 if [ ! -f ${KEY_DIR}/${user_id}.key ]; then
    echo "ERROR: User private key not found"
    exit 1
 fi
 if [ ! -f ${KEY_DIR}/ta.key ]; then
    echo "ERROR: TLS Auth key not found"
    exit 1
 fi

cat ${BASE_CONFIG} \
<(echo -e '<ca>') \
${KEY_DIR}/ca.crt \
<(echo -e '</ca>\n<cert>') \
${KEY_DIR}/${user_id}.crt \
<(echo -e '</cert>\n<key>') \
${KEY_DIR}/${user_id}.key \
<(echo -e '</key>\n<tls-crypt>') \
${KEY_DIR}/ta.key \
<(echo -e '</tls-crypt>') \
> ${OUTPUT_DIR}/${user_id}.ovpn

chown ${op_user}:${op_user} "${OUTPUT_DIR}/${user_id}.ovpn"

echo "User config file created in ${OUTPUT_DIR}/${user_id}.ovpn"