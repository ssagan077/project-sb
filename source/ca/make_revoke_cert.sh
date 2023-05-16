#!/bin/bash
## This script revokes certificates, generates a CRL and sends it to the openvpn server

# Check the script is being run by user (no sudo)
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
# Our Variables
source ca_paths.sh

cert_id=$1
if [ "$cert_id" == "" ]; then
      echo "ERROR: No certificate CN provided"
      exit 1
fi

echo "Preparing an environment.."
#Checking folders for echanging with OVPN-server
[ ! -d $exch_srv_dir ] && mkdir -p $exch_srv_dir
[ ! -d $exch_cli_dir ] && mkdir -p $exch_cli_dir

# Checking Easy-RSA
if [ ! -d "/usr/share/easy-rsa" ]; then
    echo "Easy-RSA is not installed. Run another script first!"
    exit 1
fi

if [ ! -d "$rsa_dir" ]; then "Easy-RSA is not prepared. Run another script first!"
    exit 1
fi

echo "Checking directory with keys..."
# Check if pki directory exists
if [ ! -d "$rsa_dir/pki" ]; then
   echo "Directory ~/easy-rsa/pki not exists. Please, run another script first!"
   echo "Break"
   exit 1
fi

# Checking ca.crt
if [ ! -f "${rsa_dir}/pki/ca.crt" ]; then
   echo "ca.crt hasn't been created! Check configuration please and try again"
   exit 1
fi

cd $rsa_dir
./easyrsa revoke $cert_id && echo "Certificate $cert_id revoked" || exit 1
./easyrsa gen-crl && echo "Revocation list generated" || exit 1
if [ -f "${rsa_dir}/pki/crl.pem" ]; then
   echo "Sending Revocation list to OVPN server..."
   if scp "${rsa_dir}/pki/crl.pem" ${op_user}@${ovpn_address}:${remote_exch_dir}/revoked/
   then echo "Revocation list was sent"
   else
        echo "Can't send Revocation list to OVPN server. Run script copy_pub_key2ovpn.sh"
   fi
else
   echo "ERROR: Revocation list hasn't been created"
fi
