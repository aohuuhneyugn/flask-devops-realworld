pipeline {
    agent any

    environment {
        IMAGE_NAME = "aohuuhneyugn/flask-cicd"
    }

    stages {
        stage('Clone Source') {
            steps {
                git 'https://github.com/your-username/flask-cicd'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push $IMAGE_NAME
                        """
                    }
                }
            }
        }
    }
}
