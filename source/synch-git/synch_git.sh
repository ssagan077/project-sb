#!/bin/bash
#Our Variables
source pckg_paths.sh
descr="Update for "$(date +%Y_%m_%d)
log_file="${git_dir}/synch-git.log"

# Checking git directory

if [ ! -d ${git_dir} ]; then
   echo "ERROR: There is no directory ${git_dir}. Operation canceled!" >> $log_file
   exit 1
fi

# git commit and push
cd ${git_dir}
git add . &>> $log_file
git commit -m $descr &>> $log_file
git -f push &>> $log_file

