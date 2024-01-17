#!/bin/bash

echo "1) Displaying the Jenkins Jobs..!"

echo "2) Build the Jenkins Jobs...!"

echo "3) Delete the Jenkins Job...!"

echo "4) Delete the Jenkins Node..!"

echo "5) Delete the Jenkins Views..!"

echo "6) Getting the Job configuration XML format..!"

echo "7) Create the Jenkins Job...!"

echo "Please select your choice"
read choice

case $choice in
1) sh displayJob.sh
;;
2) sh buildjob.sh
;;
3) sh delete_job.sh
;;
4) sh delete_node.sh
;;
5) sh deleteView.sh
;;
6) sh getjob_config.sh
;;
7) sh create_job.sh
;;
*) echo "Please select the correct choice"
;;
esac;