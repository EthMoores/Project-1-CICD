pipeline {
    agent any

    environment {
        FILENAME = 'oreoProgram'
        BACKUP_SUFFIX = '_Version_'
        HOME_DIR = sh(script: 'echo $HOME', returnStdout: true).trim()  // Get the home directory of the Jenkins agent user
        CURRENT_FILENAME = FILENAME  // Variable to track the current filename
    }

    stages {
        stage('Check for Existing File') {
            steps {
                script {
                    // Print the current directory to verify the working directory
                    sh 'pwd'

                    // List files in the current directory to verify if the file is present
                    sh 'ls -la'

                    // Check if the file exists on the deployment machine........
                    def fileExists = sh(script: "if [ -f ${FILENAME} ]; then echo 'yes'; else echo 'no'; fi", returnStdout: true).trim()
                    if (fileExists == 'yes') {
                        // Get the current version number by counting existing backup files
                        def version = sh(script: "ls ${FILENAME}${BACKUP_SUFFIX}* 2>/dev/null | wc -l", returnStdout: true).trim()
                        int versionNumber = version.toInteger() + 1
                        // Rename the existing file with the new version number
                        sh "mv ${FILENAME} ${FILENAME}${BACKUP_SUFFIX}${versionNumber}"
                        echo "Existing file renamed to ${FILENAME}${BACKUP_SUFFIX}${versionNumber}"
                        echo " "
                        echo " "
                        echo " "
                        echo " "

                        // Update the CURRENT_FILENAME to reflect the renamed file
                        CURRENT_FILENAME = "${FILENAME}${BACKUP_SUFFIX}${versionNumber}"

                        // Copy the newly renamed file to the home directory
                        sh "cp ${CURRENT_FILENAME} ${HOME_DIR}/"
                        echo "Copied ${CURRENT_FILENAME} to the home folder (${HOME_DIR})"
                        echo " "
                        echo " "
                        echo " "
                        echo " "
                    } else {
                        echo "File ${FILENAME} does not exist, pulling from Git repository."
                        // Pull the file from the Git repository if it doesn't exist..
                        sh "git checkout ${FILENAME}"

                        // Verify that the file was pulled correctly
                        sh 'ls -la'

                        // Check if the file exists after the pull
                        def fileExistsAfterPull = sh(script: "if [ -f ${FILENAME} ]; then echo 'yes'; else echo 'no'; fi", returnStdout: true).trim()
                        if (fileExistsAfterPull == 'yes') {
                            echo "File ${FILENAME} pulled successfully from the Git repository"
                            echo " "
                            echo " "
                            echo " "
                            echo " "
                            // Use the original filename since no renaming has occurred yet
                            CURRENT_FILENAME = FILENAME

                            // Copy the pulled file to the home directory
                            sh "cp ${CURRENT_FILENAME} ${HOME_DIR}/"
                            echo "Copied ${CURRENT_FILENAME} to the home folder (${HOME_DIR})"
                            echo " "
                            echo " "
                            echo " "
                            echo " "
                        } else {
                            error "File ${FILENAME} could not be found after Git checkout. Please ensure it exists in the repository."
                        }
                    }
                }
            }
        }

        stage('Make Executable') {
            steps {
                script {
                    // Make sure the file exists before attempting to change permissions
                    def fileExists = sh(script: "if [ -f ${CURRENT_FILENAME} ]; then echo 'yes'; else echo 'no'; fi", returnStdout: true).trim()
                    if (fileExists == 'yes') {
                        try {
                            // Attempt to make the file executable
                            sh "chmod +x ${CURRENT_FILENAME}"
                            echo "${CURRENT_FILENAME} is now executable"
                            echo " "
                            echo " "
                            echo " "
                            echo " "
                        } catch (Exception e) {
                            error "Failed to make ${CURRENT_FILENAME} executable. Check file permissions."
                        }
                    } else {
                        error "File ${CURRENT_FILENAME} does not exist. Cannot make it executable."
                    }
                }
            }
        }

        stage('Archive Script') {
            steps {
                // Archive the CURRENT_FILENAME as a build artifact
                archiveArtifacts artifacts: "${CURRENT_FILENAME}", allowEmptyArchive: false
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
            echo " "
            echo " "
            echo " "
            echo " "
        }
        failure {
            echo 'Pipeline failed.'
            echo " "
        }
    }
}
