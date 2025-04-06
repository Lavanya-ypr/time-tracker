pipeline {
  agent { label 'remote_agent' }
    stages {
      stage('checkout') {
        steps {
          checkout scm
        }
      }
      stage('build') {
        steps {
          sh 'mvn clean package'
        }
      }
   }  
}
