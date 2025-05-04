pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = 'your_aws_account_id'
        AWS_REGION = 'your_aws_region'
        ECR_REPOSITORY = 'your_ecr_repository'
        ECS_CLUSTER = 'your_ecs_cluster'
        ECS_SERVICE = 'your_ecs_service'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/MAcikel/karavel-react-starter.git'
            }
        }
        stage('Build Docker Images') {
            steps {
                script {
                    docker.build('backend', './backend')
                    docker.build('frontend', './frontend')
                }
            }
        }
        stage('Login to AWS ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com'
                }
            }
        }
        stage('Push Docker Images to ECR') {
            steps {
                script {
                    docker.tag('backend', "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:backend")
                    docker.push("$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:backend")
                    docker.tag('frontend', "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:frontend")
                    docker.push("$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:frontend")
                }
            }
        }
        stage('Deploy to AWS ECS') {
            steps {
                script {
                    sh 'aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE --force-new-deployment --region $AWS_REGION'
                }
            }
        }
    }
}
