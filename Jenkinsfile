pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ghcr.io/roopagotur/angular-app:latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Roopagotur/jenkins-CICD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image to GitHub Container Registry') {
            steps {
                withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {
                    sh 'echo $GITHUB_TOKEN | docker login ghcr.io -u Roopagotur --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                sh 'docker stop angular-container || true'
                sh 'docker rm angular-container || true'
                sh 'docker run -d -p 80:80 --name angular-container $DOCKER_IMAGE'
            }
        }
    }

    post {
        success {
            echo 'Build and Deployment Successful!'
        }
        failure {
            echo 'Build Failed. Check logs.'
        }
    }
}
