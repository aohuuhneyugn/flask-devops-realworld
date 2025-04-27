pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {
        stage('Clone Source') {
            steps {
                git 'https://github.com/aohuuhneyugn/flask-devops-realworld.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t aohuuhneyugn/flask-cicd .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push aohuuhneyugn/flask-cicd:latest
                    '''
                }
            }
        }
        stage('Deploy New Container') {   // <<< THÊM NÈ
            steps {
                sh '''
                    docker rm -f flask-app-prod || true
                    docker pull aohuuhneyugn/flask-cicd:latest
                    docker compose -f docker-compose.prod.yml up -d
                '''
            }
        }
    }
}
