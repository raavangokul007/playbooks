#/bin/bash

echo "Please enter the view name  which view need to Delete...!"
echo "------------------------------------------"
read ViewName

JenkinsUrl=`cat jenkins_details.txt | grep JENKINS_URL| cut -d "=" -f2`
JenkinsUsername=`cat jenkins_details.txt | grep JENKINS_USERNAME| cut -d "=" -f2`
JenkinsToken=`cat jenkins_details.txt | grep JENKINS_TOKEN| cut -d "=" -f2`

echo "Deleting the Jenkins view...!"
echo "--------------------------------"
java -jar jenkins-cli.jar -auth $JenkinsUsername:$JenkinsToken -s $JenkinsUrl  delete-view $ViewName