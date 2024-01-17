pipeline {
    agent any

    stages {
        stage('Exe_ansible_playbook') {
            steps {
               ansiblePlaybook credentialsId: 'cbf988e6-4127-4d04-943b-f86d6f4f4b8f', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: '/home/ansible/playbooks'
            }
        }
    }
}
