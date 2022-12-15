pipeline {
  agent any
    stages {
      stage ('Build Image'){
        steps {
          withCredentials([string(credentialsId: 'SUDO_JENKINS', variable: 'sudo_jenkins')]) {
          sh '''#!/bin/bash
          docker context use default
          docker context ls
          echo ${sudo_jenkins} | sudo -S docker-compose build
          '''
          }
        }
      }
      
      stage ('Push Image'){
        steps {
          withCredentials([string(credentialsId: 'DOCKERHUB_UNAME', variable: 'dockerhub_uname'),
                            string(credentialsId: 'DOCKERHUB_PASSWD', variable: 'dockerhub_passwd'),
                               string(credentialsId: 'SUDO_JENKINS', variable: 'sudo_jenkins')]) {
          sh '''#!/bin/bash
          echo "Does it get to this step?"
          # echo ${sudo_jenkins} | sudo -S docker login --username=${dockerhub_uname} --password=${dockerhub_passwd}
          echo ${sudo_jenkins} | sudo -S docker push kingmant/ifmeorg
          '''
          }
        }
      }
      
      stage ('Change Context'){
        steps {
          sh '''#!/bin/bash
          docker context use myecscontext
          docker context ls
          '''
        }
      }
      
      stage('Docker Compose to ECS') {
        steps {
          withCredentials([string(credentialsId: 'SUDO_JENKINS', variable: 'sudo_jenkins')]) {
          sh '''#!/bin/bash
          echo ${sudo_jenkins} | sudo -S docker compose up -d
          '''
          }
        }
      }
      
      stage('Clean up') {
        steps {
          withCredentials([string(credentialsId: 'SUDO_JENKINS', variable: 'sudo_jenkins')]) {
          sh '''#!/bin/bash
          docker context use default
          echo ${sudo_jenkins} | sudo -S docker image rm kingmant/ifmeorg:latest
          '''
          }
        }
      }
    }
}
          