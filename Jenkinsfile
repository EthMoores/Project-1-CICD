pipeline {
    agent any

    environment {
        FILENAME = 'oreoProgram'
    }

    stages {
        stage('Make Executable') {
            steps {
                // Make the file executable
                sh "chmod +x ${FILENAME}"
                echo "${FILENAME} is now executable"
            }
        }

        stage('Archive Script') {
            steps {
                // Archive the file as a build artifact
                archiveArtifacts artifacts: "${FILENAME}", allowEmptyArchive: false
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
