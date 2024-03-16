pipeline {
    agent any
    
    tools{
    maven "maven3.9.6"
    }
   
   environment {
        buildNumber = "${env.BUILD_NUMBER}"
    }
   
    stages {
        stage('CheckOutCode') {
            steps {
             git 'https://github.com/MithunTechnologiesDevOps/maven-web-application.git'
            }
        }
        stage('Build'){
            steps {
                sh "mvn clean package"
            }
        }
        stage('BuildDockerImage'){
            steps {
                sh "docker build -t 495218826230.dkr.ecr.us-east-2.amazonaws.com/raavangokulecr:appV${buildNumber} ."
            }
        }
        stage('DockerLoginAndPush'){
            steps {
                sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 495218826230.dkr.ecr.us-east-2.amazonaws.com"
                sh "docker push 495218826230.dkr.ecr.us-east-2.amazonaws.com/raavangokulecr:appV${buildNumber}"
            }
        }
         stage('DockerContainerDeploymentOnQaEnv'){
            steps {
                sshagent(['Docker_QA_SSH']) {
                    
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.25.1 docker stop mavenwebapp|| true"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.25.1 docker rm mavenwebapp || true"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.25.1 aws ecr get-login-password --region us-east-2 | ssh -o StrictHostKeyChecking=no ubuntu@172.31.25.1 docker login --username AWS --password-stdin 495218826230.dkr.ecr.us-east-2.amazonaws.com"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.25.1  docker run --name mavenwebapp -d -p 8080:8080 495218826230.dkr.ecr.us-east-2.amazonaws.com/raavangokulecr:appV${buildNumber}" 
                }
            }
        }
    }
}
