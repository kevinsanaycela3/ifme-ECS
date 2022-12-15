pipeline {
  agent any
    stages {
      stage ('Build Image'){
        steps {
          sh '''#!/bin/bash
          sudo docker context use default
          sudo docker context ls
          sudo docker-compose build
          '''
        }
      }
      stage ('Push Image'){
        steps {
          withCredentials([string(credentialsId: 'DOCKERHUB_UNAME', variable: 'dockerhub_uname'),
                                    string(credentialsId: 'DOCKERHUB_PASSWD', variable: 'dockerhub_passwd')]) {
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
          sudo docker context use myecscontext
          sudo docker context ls
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
          sudo docker context use default
          sudo docker image rm kingmant/ifmeorg:latest
          '''
        }
      }
    }
}
          
