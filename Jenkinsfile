pipeline {
  agent any
  options {
    skipDefaultCheckout(true)
  }
  stages{
    stage('clean workspace') {
      steps {
        cleanWs()
      }
    }
    stage('checkout') {
      steps {
        checkout scm
      }
    }
    stage('tfsec') {
      agent {
        docker { 
          image 'tfsec/tfsec-ci' 
          reuseNode true
        }
      }
      steps {
        sh '''
          tfsec . --no-color
        '''
      }
    }
    stage('terraform') {
      withAWS(credentials: 'aadi_aws', region: 'us-east-2') {
        steps {
          sh 'terraform init'
          sh 'terraform apply -auto-approve -no-color'
         }
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
