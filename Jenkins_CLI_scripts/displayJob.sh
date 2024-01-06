#/bin/bash

echo "Diplaying the Jenkins Jobs...!"
echo "------------------------------"

JenkinsUrl=`cat jenkins_details.txt | grep JENKINS_URL| cut -d "=" -f2`
JenkinsUsername=`cat jenkins_details.txt | grep JENKINS_USERNAME| cut -d "=" -f2`
JenkinsToken=`cat jenkins_details.txt | grep JENKINS_TOKEN| cut -d "=" -f2`

java -jar jenkins-cli.jar -auth $JenkinsUsername:$JenkinsToken -s $JenkinsUrl list-jobs

