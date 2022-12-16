pipeline {
  agent any
  environment {
    dockerhub = credentials('dockerhub')
  }
    stages {
      stage ('Build Image'){
        steps {
          withCredentials([string(credentialsId: 'SUDO_JENKINS', variable: 'sudo_jenkins')]) {
          sh '''#!/bin/bash
          docker context use default
          docker context ls
          docker-compose build
          '''
          }
        }
      }
      
      stage ('Push Image'){
        steps {
          withCredentials([
                string(credentialsId: 'SUDO_JENKINS', variable: 'sudo_jenkins')]) {
          sh '''#!/bin/bash
          
          echo $dockerhub_PSW | sudo docker login -u $dockerhub_USR --password-stdin
          echo ${sudo_jenkins} | sudo -S docker push kos44/kura_apps
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
          