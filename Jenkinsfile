pipeline {
    agent any

    stages {
        stage('Clone Source') {
            steps {
                git branch: 'main', url: 'https://github.com/aohuuhneyugn/flask-devops-realworld.git'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                    pip install pytest
                    pytest test_app.py
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t aohuuhneyugn/flask-cicd .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push aohuuhneyugn/flask-cicd:latest
                    '''
                }
            }
        }

        stage('Deploy New Container') {
            steps {
                sh '''
                    docker rm -f flask-app-prod || true
                    docker pull aohuuhneyugn/flask-cicd:latest
                    docker-compose -f docker-compose.prod.yml up -d
                '''
            }
        }
    }
}
