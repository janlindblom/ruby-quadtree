pipeline {
  agent {
    label 'ruby'
  }

  stages {
    stage('Setup') {
      steps {
        sh 'bundle install'
      }
    }

    stage('Build') {
      steps {
        sh 'bundle exec rake build'
      }
    }

    stage('Test production branch') {
      when {
        branch 'master'
      }
      steps {
        sh 'bundle exec rake yard'
        sh 'bundle exec rake rubocop'
        sh 'bundle exec rake spec'
      }
    }

    stage('Test development branch') {
      when {
        not {
          branch 'master'
        }
      }
      steps {
        sh 'bundle exec rake spec'
      }
    }
  }

  post {
    always {
      junit 'test-reports/**/*.xml'
    }
  }
}
