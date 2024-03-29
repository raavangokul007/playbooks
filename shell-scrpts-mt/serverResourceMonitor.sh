#!/bin/bash 
#######################################################################################
#Script Name    : .sh
#Description    :send alert mail when server memory is running low
#Args           :       
#Author         : Mithun Technologies
#Email          : devopstrainingblr@gmail.com
#License        : MSS
#######################################################################################
## declare mail variables
##email subject 
subject="Server Memory Status Alert"
##sending mail as
from="raavangokuldd@gmail.com"
## sending mail to
to="raavangokuldd@gmail.com"
## send carbon copy to
##also_to="devopstrainingblr@gmail.com

## get total free memory size in megabytes(MB) 
free=$(free -mt | grep Total | awk '{print $4}')

## check if free memory is less or equals to  100MB
if [[ "$free" -le 100  ]]; then
        ## get top processes consuming system memory and save to temporary file 
        ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head >/tmp/top_proccesses_consuming_memory.txt

        file=/tmp/top_proccesses_consuming_memory.txt
        ## send email if system memory is running low
        echo -e "Hi Team \n\n Please take care of below server \n\n Hostname : $hostname \n\nWarning, server memory is running low!\n\nFree memory: $free MB" | mailx -a "$file" -s "$subject" -r "$from" -c "$to" "$also_to"
fi

exit 0