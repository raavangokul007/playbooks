#!/bin/bash      
#title           :
#description     :
#author		     :Mithun Reddy Lacchannagari
#date            :08112012
#version         :1.0    
#usage		     :


echo "Enter the name of the file: "
read file_name
if [ -f $file_name ]
 then
	if [ -w $file_name ]
	then
		echo "Type something, the type Ctrl +d to Quit"
		cat >> $file_name
	else
		echo "The file do not have write permissions"
	fi
 else
	 echo "$file_name not exists"
fi
