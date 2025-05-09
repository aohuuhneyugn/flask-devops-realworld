pipeline {
    agent any

    environment {
        DOCKER_USER = 'aohuuhneyugn'
        DOCKER_IMAGE = 'flask-cicd'
        DOCKER_TAG = 'latest'
        CONTAINER_NAME = 'flask-app-prod'
    }

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
                sh 'docker build -t $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Tag Backup Image for Rollback') {
            steps {
                sh '''
                docker tag $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG $DOCKER_USER/$DOCKER_IMAGE:rollback
                docker push $DOCKER_USER/$DOCKER_IMAGE:rollback
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        stage('Deploy New Container') {
            steps {
                script {
                    try {
                        sh '''
                        docker rm -f $CONTAINER_NAME || true
                        docker run -d --name $CONTAINER_NAME -p 5000:5000 $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG
                        '''
                    } catch (Exception e) {
                        echo '⚠️ Deploy failed! Rolling back...'
                        sh '''
                        docker rm -f $CONTAINER_NAME || true
                        docker run -d --name $CONTAINER_NAME -p 5000:5000 $DOCKER_USER/$DOCKER_IMAGE:rollback
                        '''
                    }
                }
            }
        }
    }
}
