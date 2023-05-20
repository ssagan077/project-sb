#!/bin/bash
## This script creates a clone of a remote git repository with our scripts and deb-packages on a new virtual machine.
## This is beginning of the deployment of the infrastructure of our project

# Check the script is being run by current user(no root)
if [ "$(id -u)" = "0" ]; then
   echo "This script must be run as current user, not root"
   exit 1
fi

op_user="user"   ## You should change it before start!!
git_dir="/home/${op_user}/project-sb" 
pckg_dir="${git_dir}/packages"

#Checking git
if dpkg -l git; then echo "git has not been installed. Installing..."
   sudo apt-get install git && echo "Git has been installed" || exit 1
fi

#Create pub and secret ssh keys for exchanging with OVPN-server
if [ ! -f /home/${op_user}/.ssh/id_rsa.pub ]; then
  echo "Creating ssh keys..."
  ssh-keygen -t rsa && echo "ssh keys created" || exit 1
fi

echo -e "Please, copy this public key to clipboard and add to your repository on github:\n"
cat /home/${op_user}/.ssh/id_rsa.pub
sleep 3

read -p "Did you add your public key to GitHub? y/n: " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
   echo "Ok, let's create repository"
else
   echo "Next time"; exit 1
fi

if [ -d "${git_dir}/packages" ]; then
   echo "It seems that the directory ${git_dir}/packages has already exists. Please, check it..."
   exit 1
fi

cd /home/${op_user}

git config --global user.name "$op_user"
git config --global user.email "${op_user}@gmail.com"
git config --global core.editor nano


if git clone git@github.com:"${op_user}/project-sb.git"
then echo "Local Repository has been created"
else
   echo "Something went wrong...Try it manually"
   exit 1
fi
##git remote add remote-git git@github.com:"${op_user}/project-sb.git"

echo "Now you should run the script start_pckg.sh"
