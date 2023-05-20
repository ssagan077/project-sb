#!/bin/bash
# Check the script is being run by user (no sudo)
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi

#Check parameters
if [ $# -eq 0 ]; then
   echo "Must be 1 parameter - client name! For example: make_req_lin.sh client1"
   exit 1
fi

cli_name=$1
rsa_dir="/home/${USER}/easy_rsa"
cli_conf_dir="/home/${USER}/openvpn/config"

# Checking OpenVPN client config directory
if [ ! -d "${cli_conf_dir}" ]; then
  mkdir -p ${cli_conf_dir}
  chmod 700 ${cli_conf_dir}
fi

# Checking Easy-RSA
if [ ! -d "/usr/share/easy-rsa" ]; then
    echo "Easy-RSA has not installed. Please, follow Instruction!"
    exit 1
fi

# Checking Easy-RSA in our profile
if [ ! -d "${rsa_dir}" ]; then mkdir $rsa_dir
else
   # Delete all symlinks in directory easy-rsa
    echo "Removing old synlinks..."
   find $rsa_dir -type l -delete
   if [ $? -ne 0 ]; then echo "Can't delete symlinks in directory easy-rsa"; exit 1; fi
fi

#Copying configuration template to rsa-dir
if [ ! -f "vars_tmpl" ]; then echo "Can't find file vars_tmpl. Please ask your company's admin"; exit 1; fi
cp vars_tmpl "${rsa_dir}/vars" && echo "Template copied" || exit 1

#Create symlinks in our home directory
if ln -s /usr/share/easy-rsa/* $rsa_dir; then
 echo "Symlinks created"
else
 echo "Can't create symlink on directory easy-rsa. Break" ; exit 1
fi
chown -R $USER:$USER $rsa_dir
chmod 700 ~/easy-rsa


echo "Checking easy-rsa directory..."
if [ ! -d "${rsa_dir}/pki" ]; then
   # init-pki
   cd $rsa_dir
   ./easyrsa init-pki && echo "init-pki completed successfully" || exit 1
fi

#Checking if client key exists
if [ -f "${cli_conf_dir}/client.key" ]; then
   echo "File client.key already exists in directory $cli_conf_dir. It seems like request has already created."
   echo "Please, check it..."
   exit 1
fi

echo "We are ready for creating requests..."
#Creating certificate request
if [ ! -f "${rsa_dir}/pki/reqs/${cli_name}.req" ]; then
    ./easyrsa gen-req ${cli_name} nopass && echo "Request has been created"
    if [ $? -ne 0 ]; then echo "Can't generate request. Please check log files"; exit 1; fi
    #Copying client secret key
    if [ -f "${rsa_dir}/pki/private/${cli_name}.key" ]; then
       mv "${rsa_dir}/pki/private/${cli_name}.key" "${cli_conf_dir}/client.key" && echo "Key ${cli_name}.key has been copied to folder ${>    else
       echo "ERROR: There is no ${cli_name} secret key! Abort"
       exit 1
    fi
else
    echo "Client request already exists in folder pki/reqs. Please, send it to Administrator"
fi

echo "Next step: send request ${rsa_dir}/pki/reqs/${cli_name}.req to your company's administrator"