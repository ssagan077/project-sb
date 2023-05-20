#!/bin/bash
#Our Variables
source pckg_paths.sh
dt=$(date +%Y_%m_%d_%H:%M)
descr="Update for ${dt}"
log_file="${git_dir}/synch-git.log"

# Checking git directory

if [ ! -d ${git_dir} ]; then
   #echo "ERROR: There is no directory ${git_dir}. Operation canceled!" 
   exit 1
fi

# git commit and push
cd ${git_dir}
git add .
git commit -m "${descr}" &>> ${log_file}
git push ${remote_git_name} &>> ${log_file}

