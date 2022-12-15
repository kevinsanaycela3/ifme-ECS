pipeline {
  agent any
    stages {
      stage ('Build Image'){
        steps {
          sh '''#!/bin/bash
          docker context use default
          docker context ls
          docker-compose build
          '''
        }
      }
      stage ('Push Image'){
        steps {
          withCredentials([string(credentialsId: 'DOCKERHUB_UNAME', variable: 'dockerhub_uname'),
                                    string(credentialsId: 'DOCKERHUB_PASSWD', variable: 'dockerhub_passwd')]) {
          sh '''#!/bin/bash
          docker login --username=${dockerhub_uname} --password=${dockerhub_passwd}
          docker push kingmant/ifmeorg
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
          docker compose up -d
          '''
        }
      }
      stage('Clean up') {
        steps {
          sh '''#!/bin/bash
          docker context use default
          docker image rm kingmant/ifmeorg:latest
          '''
        }
      }
    }
}
          
