#!/bin/bash      
#title           :
#description     :
#author		     :Mithun Technologies
#date            :08112012
#version         :1.0    
#usage		     :sh javaInstall.sh


#execute below command to see which version of Java has installed if its already installed.
java -version
#Check the Previous command execution status
if [ $? -eq 0 ]
then
echo "Java has alaredy installed.."
else
echo "Installing the Java"
echo "Please type the java package name: "
read javapackage
sudo yum install $javapackage -y
echo "Java has installed successfully"
echo "Java version is : "
java -version
fi

