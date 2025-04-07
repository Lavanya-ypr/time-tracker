pipeline {
  agent { label 'remote_agent' }

  environment {
    REGISTRY = "docker.io/lavanyakn"
    IMAGE_NAME = "time-tracker"
    IMAGE_TAG = "${env.BUILD_NUMBER}"
    DOCKER_CREDENTIALS_ID = "docker-credentials-id"
    RELEASE_NAME = "my-java-release"
    HELM_CHART_PATH = "helm/time-tracker"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."
      }
    }

    stage('Publish Docker Image') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: "${DOCKER_CREDENTIALS_ID}",
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS')]) {

          sh """
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
          """
        }
      }
    }
   
    stage('Deploy to Kubernetes') {
      steps {
        sh """
          helm upgrade --install ${RELEASE_NAME} ${HELM_CHART_PATH} \
            --set image.repository=${REGISTRY}/${IMAGE_NAME} \
            --set image.tag=${IMAGE_TAG} \
            --namespace default --create-namespace
        """
      }
    }
  }
}
