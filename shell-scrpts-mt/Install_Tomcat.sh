#!/bin/bash

# Install Java
dnf install -y java-17-amazon-corretto-devel.x86_64

# Check Java version
java_version=$(java --version)
echo "Java version: $java_version"

# Download Tomcat package
tomcat_url="https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.83/bin/apache-tomcat-9.0.83.zip"
curl -O $tomcat_url

# Display download status and content
download_status=$?
if [ $download_status -eq 0 ]; then
  echo "Download successful."
  unzip apache-tomcat-9.0.83.zip -d /opt

  # Find the name of the Tomcat home
  tomcat_name=$(ls /opt | grep -v zip | grep -i apache)

  # Display the name of the Tomcat home
  echo "Tomcat home: $tomcat_name"

  # Change the name of the Tomcat directory
  mv "/opt/$tomcat_name" /opt/tomcat9

  # Find script files inside Tomcat
  script_files=$(find /opt/tomcat9/bin/ -name "*.sh")

  # Change execute permissions for script files
  for script_file in $script_files; do
    chmod +x "$script_file"
  done

  # Start the Tomcat service
  sh /opt/tomcat9/bin/startup.sh
else
  echo "Download failed."
fi
