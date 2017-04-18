#!groovy

pipeline {
  agent none
  options {
    ansiColor('xterm')
    timestamps()
  }
  stages {
    stage('Build') {
      agent { docker 'manala/hugo' }
      steps {
        sh 'make install@staging'
        sh 'make build@staging'
        stash includes: 'public/', name: 'public'
      }
    }
    stage('Deploy') {
      agent { docker 'manala/deploy' }
      when { branch 'staging' }
      environment {
          DEPLOY_DESTINATION = credentials('DEPLOY_DESTINATION')
          DEPLOY_RSH = credentials('DEPLOY_RSH')
      }
      steps {
        unstash 'public'
        sshagent (credentials: ['deploy']) {
          sh 'make deploy-staging'
        }
      }
    }
  }
}
