#!/bin/bash      
#title           :
#description     :
#author		     : Mithun Reddy Lacchannagari
#date            : 08112012
#version         : 1.0    
#usage		     :
#CopyRights      : Mithun Technologies
#Contact         : 9980923226

echo "Nested if else demo starts"
a=10
b=20
c=30

if [[ ( $a -gt $b && $a -gt $c ) ]]
then
echo "$a is bigger than $b and $c"
elif [[ ( $b -gt $a && $b -gt $c ) ]]
then
echo "$b is bigger than $a and $c"
else
echo "$c is bigger than $a and $b"
fi





