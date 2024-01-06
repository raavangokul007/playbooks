#/bin/bash

echo "Please enter which job need to execute...!"
echo "------------------------------------------"
read JobName

JenkinsUrl=`cat jenkins_details.txt | grep JENKINS_URL| cut -d "=" -f2`
JenkinsUsername=`cat jenkins_details.txt | grep JENKINS_USERNAME| cut -d "=" -f2`
JenkinsToken=`cat jenkins_details.txt | grep JENKINS_TOKEN| cut -d "=" -f2`

echo "Triggering the Jenkins jobs...!"
echo "--------------------------------"
java -jar jenkins-cli.jar -auth $JenkinsUsername:$JenkinsToken -s $JenkinsUrl  build $JobName