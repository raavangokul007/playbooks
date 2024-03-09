#!/bin/bash

# Define the files for which you want to find the owner, group, and permissions
file1="/root/gokul/gokul.conf"
file2="/root/gokul/gokul2.conf"

# Loop through each server
for server in `cat /root/hosts_list.txt`
do
    echo "Server: $server"
    ssh "$server" "
        echo 'File 1:'
        ls -l \"$file1\"
        echo ''
        echo 'File 2:'
        ls -l \"$file2\"
    "
    echo ""
done
