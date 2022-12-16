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
                            string(credentialsId: 'DOCKERHUB_PW', variable: 'dockerhub_pw'),
                               string(credentialsId: 'SUDO_JENKINS', variable: 'sudo_jenkins')]) {
          sh '''#!/bin/bash
          echo ${sudo_jenkins} | sudo -S docker login --username=${dockerhub_uname} --password=${dockerhub_pw}
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
    }
}