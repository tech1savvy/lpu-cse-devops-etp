pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'devakay/app:latest'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/tech1savvy/lpu-cse-devops-etp.git', branch: 'main'
            }
        }

        stage('Build Image') {
            steps {
                sh "docker build -t devakay/app:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                    docker login -u $DOCKER_USER -p $DOCKER_PASS
                    docker push ${DOCKER_IMAGE}
                    docker logout
                    """
                }
            }
        }

        stage('Deploy with Compose') {
            steps {
                sh """
                docker compose down
                docker compose up -d
                """
            }
        }
    }
    post {
        always {
            sh "docker rmi ${DOCKER_IMAGE} || true"
        }
    }
}
