pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning repo...'
                // Git đã được Jenkins clone sẵn, không cần làm gì thêm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker compose build'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running tests...'
                sh 'docker compose run --rm flask-app pytest'
            }
        }
    }

    post {
        success {
            echo '✅ CI pipeline completed successfully!'
        }
        failure {
            echo '❌ CI pipeline failed!'
        }
    }
}
