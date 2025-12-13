pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "us-east-1"
        REPOSITORY_URI = "717279705656.dkr.ecr.us-east-1.amazonaws.com/devops-lab"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    tools {
        nodejs 'node18'
        jdk 'jdk17'
    }

    stages{
        stage ('Checkout Code'){
            steps {
                checkout scm
            }
        }

        stage ('Login to ECR'){
            steps {
                withCredentials([aws(credentialsId: 'AWS-ECR-CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        aws ecr get-login-password --region $AWS_DEFAULT_REGION \
                        | docker login --username AWS --password-stdin $REPOSITORY_URI
                    '''
                }
            }
        }
        
        stage ('Build Docker Image'){
            steps{

            sh '''
                docker build -t my-app:$IMAGE_TAG app/
                docker tag my-app:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG
            '''
            }
        }

        stage ('Push to ECR'){
            steps {
                sh '''
                    docker push $REPOSITORY_URI:$IMAGE_TAG
                '''
            }
        }

        stage ('Deploy to Kubernetes'){
            steps {
                withCredentials([file(credentialsId: 'KUBECONFIG_DEVOPS', variable: 'KUBECONFIG'), aws(credentialsId: 'AWS-ECR-CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG
                        export AWS_DEFAULT_REGION=us-east-1

                        echo "Updating image tag in deployment.yaml"
                        kubectl set image deployment/node-app app=${REPOSITORY_URI}:${IMAGE_TAG}


                        echo "Applying Kubernetes manifests..."
                        kubectl apply -f K8s/

                        echo "Verifying rollout..."
                        kubectl rollout status deployment/node-app
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build and Docker image push successful!'
            echo "Pushed Image: $REPOSITORY_URI:$IMAGE_TAG"
        }
        failure {
            echo '❌ Build failed. Check logs above.'
        }
    }
}