#!/bin/bash
# Check the script is being run by user (no sudo)
if [ "$(id -u)" == "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi
# Our Variables
source pckg_paths.sh

echo "Preparing an environment.."
#Checking folders for echanging
[ ! -d "${exch_in_dir}/${ovpn_server}/server" ] && mkdir -p "${exch_in_dir}/${ovpn_server}/server"
[ ! -d "${exch_in_dir}/${ovpn_server}/client" ] && mkdir -p "${exch_in_dir}/${ovpn_server}/client"
[ ! -d "${exch_out_dir}/${ovpn_server}/server" ] && mkdir -p "${exch_out_dir}/${ovpn_server}/server"
[ ! -d "${exch_out_dir}/${ovpn_server}/client" ] && mkdir -p "${exch_out_dir}/${ovpn_server}/client"

[ ! -d "${exch_in_dir}/${mon_server}/server" ] && mkdir -p "${exch_in_dir}/${mon_server}/server"
[ ! -d "${exch_in_dir}/${mon_server}/client" ] && mkdir -p "${exch_in_dir}/${mon_server}/client"
[ ! -d "${exch_out_dir}/${mon_server}/server" ] && mkdir -p "${exch_out_dir}/${mon_server}/server"
[ ! -d "${exch_out_dir}/${mon_server}/client" ] && mkdir -p "${exch_out_dir}/${mon_server}/client"

echo "Done"
