pipeline {
    agent any

    environment {
        FILENAME = 'oreoProgram'
        BACKUP_SUFFIX = '_Version_'
        HOME_DIR = sh(script: 'echo $HOME', returnStdout: true).trim()  // Get the home directory of the Jenkins agent user
    }

    stages {
        stage('Check for Existing File') {
            steps {
                script {
                    // Check if the file exists on the deployment machine...
                    def fileExists = sh(script: "if [ -f ${FILENAME} ]; then echo 'yes'; else echo 'no'; fi", returnStdout: true).trim()
                    if (fileExists == 'yes') {
                        // Get the current version number by counting existing backup files
                        def version = sh(script: "ls ${FILENAME}${BACKUP_SUFFIX}* 2>/dev/null | wc -l", returnStdout: true).trim()
                        int versionNumber = version.toInteger() + 1
                        // Rename the existing file with the new version number
                        sh "mv ${FILENAME} ${FILENAME}${BACKUP_SUFFIX}${versionNumber}"
                        echo "Existing file renamed to ${FILENAME}${BACKUP_SUFFIX}${versionNumber}"
                        echo "......., \n"
                        echo "......., \n"
                        echo "......., \n"

                        // Copy the newly renamed file to the home directory
                        sh "cp ${FILENAME}${BACKUP_SUFFIX}${versionNumber} ${HOME_DIR}/"
                        echo "Copied ${FILENAME}${BACKUP_SUFFIX}${versionNumber} to the home folder (${HOME_DIR})"
                        echo "......., \n"
                        echo "......., \n"
                        echo "......., \n"
                        echo "......., \n"
                    } else {
                        // Pull the file from the Git repository if it doesn't exist..
                        sh "git checkout ${FILENAME}"
                        echo "File ${FILENAME} pulled from the Git repository"
                        echo "......., \n"
                        echo "......., \n"
                        echo "......., \n"

                        // Copy the pulled file to the home directory
                        sh "cp ${FILENAME} ${HOME_DIR}/"
                        echo "Copied ${FILENAME} to the home folder (${HOME_DIR})"
                        echo "......., \n"
                        echo "......., \n"
                        echo "......., \n"
                        echo "......., \n"

                    }
                }
            }
        }

        stage('Make Executable') {
            steps {
                script {
                    // Make sure the file exists before attempting to change permissions
                    def fileExists = sh(script: "if [ -f ${FILENAME} ]; then echo 'yes'; else echo 'no'; fi", returnStdout: true).trim()
                    if (fileExists == 'yes') {
                        try {
                            // Attempt to make the file executable
                            sh "chmod +x ${FILENAME}"
                            echo "${FILENAME} is now executable"
                            echo "......., \n"
                            echo "......., \n"
                            echo "......., \n"
                        } catch (Exception e) {
                            error "Failed to make ${FILENAME} executable. Check file permissions."
                        }
                    } else {
                        error "File ${FILENAME} does not exist. Cannot make it executable."
                    }
                }
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
