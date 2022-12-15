pipeline {
  agent any
  environment {
    dockerhub = credentials('dockerhub')
  } 
    stages {
      stage ('Build Image'){
        steps {
          
          sh '''#!/bin/bash
          echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin
          sudo docker login --username=${dockerhub_uname} --password=${dockerhub_passwd}
          sudo docker context use default
          sudo docker context ls
          
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
          sudo docker push kos44/kura_apps
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
          sudo docker image rm kos44/kura_apps
          '''
          
        }
      }
    }
}
          
