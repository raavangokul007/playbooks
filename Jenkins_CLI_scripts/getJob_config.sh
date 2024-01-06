#/bin/bash

echo "Please enter the Job name  which Job config  need to get...!"
echo "------------------------------------------"
read JobName

JenkinsUrl=`cat jenkins_details.txt | grep JENKINS_URL| cut -d "=" -f2`
JenkinsUsername=`cat jenkins_details.txt | grep JENKINS_USERNAME| cut -d "=" -f2`
JenkinsToken=`cat jenkins_details.txt | grep JENKINS_TOKEN| cut -d "=" -f2`

echo "Taking  the Jenkins job configuration...!"
echo "--------------------------------"
java -jar jenkins-cli.jar -auth $JenkinsUsername:$JenkinsToken -s $JenkinsUrl  get-job $JobName > $JobName.xml