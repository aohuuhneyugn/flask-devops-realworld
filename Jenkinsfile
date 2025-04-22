pipeline {
    agent any

    stages {
        stage('Clone code') {
            steps {
                git 'https://github.com/your-username/flask-devops-realworld.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("flask-devops-realworld")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                    script {
                        docker.image("flask-devops-realworld").push("latest")
                    }
                }
            }
        }
    }
}
