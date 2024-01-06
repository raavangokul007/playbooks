#/bin/bash

echo "Please enter the job name to Create...!"
echo "------------------------------------------"
read JobName

JenkinsUrl=`cat jenkins_details.txt | grep JENKINS_URL| cut -d "=" -f2`
JenkinsUsername=`cat jenkins_details.txt | grep JENKINS_USERNAME| cut -d "=" -f2`
JenkinsToken=`cat jenkins_details.txt | grep JENKINS_TOKEN| cut -d "=" -f2`

echo "Creating  the Jenkins job...!"
echo "--------------------------------"
java -jar jenkins-cli.jar -auth $JenkinsUsername:$JenkinsToken -s $JenkinsUrl  create-job $JobName < parallel-pipeline.xml