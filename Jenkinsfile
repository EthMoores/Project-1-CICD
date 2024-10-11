pipeline {
    agent any

    environment {
        FILENAME = 'oreoProgram'
        BACKUP_SUFFIX = '_Version_'
    }

    stages {
        stage('Check for Existing File') {
            steps {
                script {
                    // Check if the file exists on the deployment machine
                    def fileExists = sh(script: "if [ -f ${FILENAME} ]; then echo 'yes'; else echo 'no'; fi", returnStdout: true).trim()
                    if (fileExists == 'yes') {
                        // Get the current version number by counting existing backup files
                        def version = sh(script: "ls ${FILENAME}${BACKUP_SUFFIX}* 2>/dev/null | wc -l", returnStdout: true).trim()
                        int versionNumber = version.toInteger() + 1
                        // Rename the existing file with the new version number
                        sh "mv ${FILENAME} ${FILENAME}${BACKUP_SUFFIX}${versionNumber}"
                        echo "Existing file renamed to ${FILENAME}${BACKUP_SUFFIX}${versionNumber}"
                    } else {
                        // Pull the file from the Git repository if it doesn't exist..
                        sh "git checkout ${FILENAME}"
                        echo "File ${FILENAME} pulled from the Git repository"
                    }
                }
            }
        }

        stage('Make Executable') {
            steps {
                // Make the oreoProgram file executable
                sh "chmod +x ${FILENAME}"
                echo "${FILENAME} is now executable"
            }
        }

        stage('Archive Script') {
            steps {
                // Archive the oreoProgram as a build artifact..
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

