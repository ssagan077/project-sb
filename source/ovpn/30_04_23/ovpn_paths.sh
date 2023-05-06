#!/bin/bash
op_user="ssagan077"
ovpn_address="10.186.0.4"   ## Change to 10.88.10.3 after testing !!!!!!
ca_address="10.88.10.4"  ## Change to 10.88.10.2 after testing !!!!!!
pckg_address="10.88.10.6"
rsa_dir="/home/$op_user/easy-rsa"
conf_dir="/tmp/vm-ca-files"  ## needs to change!
ovpn_conf_dir="/etc/openvpn/server"
cli_conf_dir="/home/$op_user/client-conf"
exch_dir="/home/$op_user/exchange"
remote_exch_dir="/home/$op_user/exchange"
exch_srv_dir="/home/$op_user/exchange/server"
exch_cli_dir="/home/$op_user/exchange/client"
