pipeline {
   agent any
    environment {
        IMAGE_NAME = 'netanelbukris/to_do_list'
        email = 'netanel.nisim.bukris@gmail.com'
        REMOTE_USER = 'ubuntu'
        REMOTE_HOST_STAGE = '172.31.45.253'
        REMOTE_HOST_PRODUCTION = '172.31.39.147'
        DB_HOST = '172.31.42.36'
    }

    stages {
        // 🔒 Stage to test that credentials are properly masked in Jenkins logs.
        // Make sure:
        // 1. The "Mask Passwords" plugin is installed (Manage Jenkins → Plugin Manager).
        // 2. Jenkins was restarted after installing the plugin.
        // 3. The credentialsId ('TEST_MASK_PASSWORD') is correctly configured under Jenkins → Credentials.
        // 4. Passwords are only used or echoed inside withCredentials {} blocks.
        // 5. In the Console Output, the actual password should appear as ******** (masked), not in plain text.
        // 6. The password should not be echoed or logged outside the withCredentials {} block.
        // 7. Avoid printing the password in any post or error section to ensure masking.
        stage('Test Mask Password') {
            steps {
                echo 'Testing Masked Password Output...'
                withCredentials([usernamePassword(credentialsId: 'TEST_MASK_PASSWORD', passwordVariable: 'TEST_PASS_PASSWORD', usernameVariable: 'TEST_PASS_USERNAME')]) {                    
                    sh('echo 🔐 TEST MASCK PASS Username is: ' + TEST_PASS_USERNAME)
                    sh('echo 🔐 TEST MASCK PASS Password is: ' + TEST_PASS_PASSWORD)                    
                }
                echo 'Masked Password Test Completed.'
            }
        }

        stage('Deploy to staging') {
            when { changeset "stage_version.txt" }
            steps {
                script {
                    env.ENVIRONMENT = 'staging'
                    env.VERSION = readFile('stage_version.txt').trim()
                    echo "📦 Extracted version from file: ${env.VERSION}"
                    withCredentials([usernamePassword(credentialsId: 'DB_PASS', passwordVariable: 'DB_PASSWORD', usernameVariable: 'DB_USERNAME')]) {
                    sshagent (credentials: ['ubuntu-frankfurt']) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST_STAGE} \\
                            "docker pull ${IMAGE_NAME}:${env.VERSION} && \\
                            docker rm -f myapp && \\
                            docker run -d --name myapp --restart unless-stopped \\
                            -e DB_NAME=todo \\
                            -e DB_USER=${DB_USERNAME} \\
                            -e DB_PASSWORD=\${DB_PASSWORD} \\
                            -e DB_HOST=${DB_HOST} \\
                            -p 5000:5000 ${IMAGE_NAME}:${env.VERSION}"
                         """
                        }
                    }
                }    
            }
        }

        stage('Deploy to production') {
            when { changeset "production_version.txt" }
            steps {
                script {
                    env.ENVIRONMENT = 'production'
                    env.VERSION = readFile('production_version.txt').trim()
                    echo "📦 Extracted version from file: ${env.VERSION}"
                    withCredentials([usernamePassword(credentialsId: 'DB_PASS', passwordVariable: 'DB_PASSWORD', usernameVariable: 'DB_USERNAME')]) {
                    sshagent (credentials: ['ubuntu-frankfurt']) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST_PRODUCTION} \\
                            "docker pull ${IMAGE_NAME}:${env.VERSION} && \\
                            docker rm -f myapp && \\
                            docker run -d --name myapp --restart unless-stopped \\
                            -e DB_NAME=todo \\
                            -e DB_USER=${DB_USERNAME} \\
                            -e DB_PASSWORD=$\{DB_PASSWORD} \\
                            -e DB_HOST=${DB_HOST} \\
                            -p 5000:5000 ${IMAGE_NAME}:${env.VERSION}"
                         """
                        }
                    }
                }    
            }
        }
    }
        
    post {
        failure {
            script {
                def msg = ''
                if (env.VERSION && env.ENVIRONMENT) {
                    msg = "FAILED to deploy ${env.ENVIRONMENT} version ${env.VERSION} "
                } else {
                    msg = "FAILED "
                }
                
                slackSend(
                    channel: '#jenkins',
                    color: 'danger',
                    message: msg
                )
                
                emailext(
                    subject: "${JOB_NAME}.${BUILD_NUMBER} FAILED",
                    mimeType: 'text/html',
                    to: "$email",
                    body: msg
                )
            }
        }

        success {
            script {
                def msg = ''
                if (env.VERSION && env.ENVIRONMENT) {
                        msg = "success to deploy ${env.ENVIRONMENT} version ${env.VERSION}  http://stage.yp3yp3.online/"
                } else {
                        msg = "success"
                }
                    
                
                slackSend(
                    channel: '#jenkins',
                    color: 'good',
                    message: msg
                )  

                emailext(
                    subject: "${JOB_NAME}.${BUILD_NUMBER} PASSED",
                    mimeType: 'text/html',
                    to: "$email",
                    body: msg
                )
            }
        }
    }
}           