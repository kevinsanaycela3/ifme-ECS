pipeline {
  agent any
  environment {
    dockerhub = credentials('dockerhub')
  } 
    stages {
      stage ('Build Image'){
        steps {
          
          sh '''#!/bin/bash
          docker context use default
          docker context ls
          
          '''
          
        }
      }
      stage ('Push Image'){
        steps {
          withCredentials([string(credentialsId: $dockerhub_USR, variable: 'dockerhub_uname'),
                           string(credentialsId: $dockerhub_PSW, variable: 'dockerhub_passwd')
                           ]) {
          sh '''#!/bin/bash
          sudo docker login --username=${dockerhub_uname} --password=${dockerhub_passwd}
          sudo docker push kingmant/ifmeorg
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
          
          sh '''#!/bin/bash
          sudo docker compose up -d
          '''
          
        }
      }
      stage('Clean up') {
        steps {
         
          sh '''#!/bin/bash
          docker context use default
          sudo docker image rm kingmant/ifmeorg:latest
          '''
          
        }
      }
    }
}
          
