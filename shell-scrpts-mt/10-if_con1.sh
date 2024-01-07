#!/bin/bash      
#title           :
#description     :
#author		     :Mithun Reddy Lacchannagari
#date            :08112012
#version         :1.0    
#usage		     :


echo  "Enter the name of the file:"
read file_name
if [ -f $file_name ]
   then      
echo "$file_name is existed..." 
cat $file_name
else     
echo "$file_name not existed"
touch $file_name
fi

