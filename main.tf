pipeline {
    agent any

    environment {
        backendRegistry = '939083599624.dkr.ecr.us-east-2.amazonaws.com/node-backend-repo'
        frontendRegistry = '939083599624.dkr.ecr.us-east-2.amazonaws.com/node-frontend-repo'
        registryCredential = 'node-credentials'
        backendImage = ''
        frontendImage = ''
    }

    stages {
        stage ('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Freensh/Node_app.git'
            }
        }

        stage ('Installing depencies'){
            steps {
                sh 'npm install'
            }
        }
        stage('Buiding backend container'){
            steps {
                dir('backend') {
                    script{
                        backendImage = docker.build backendRegistry + ":$BUILD_NUMBER"
                    }
                }
            } 
        }
        stage ('Buiilding frontend image') {
            steps {
                dir('frontend') {
                    script {
                        frontendImage = docker.build frontendRegistry + ":$BUILD_NUMBER"
                    }
                }
            }
        }
        stage ('Pushing Backend Image to ECR'){
            steps {
                script {
                    docker.withRegistry("https://"+backendRegistry, "ecr:us-east-2:"+registryCredential){
                        backendImage.push()
                    }
                }
            }
        }
        stage ('Pushing Frontend Image to ECR'){
            steps {
                script {
                    docker.withRegistry("https://"+frontendRegistry, "ecr:us-east-2:"+ registryCredential){
                        frontendImage.push()
                    }
                }
            }
        }
        stage ('Initialysing the terraform code'){
            steps{
                
                sh 'terraform init'
            }
        }
        stage ('Deploying tthe app to ECS'){
            steps{
                sh 'terraform apply --auto-approve -var="image_tag=$BUILD_NUMBER"'
            }
        }
    }
}
