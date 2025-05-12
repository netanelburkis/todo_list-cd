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
                    // Requires "SSH Agent" plugin in Jenkins:
                    // Manage Jenkins → Plugin Manager → Install "SSH Agent"
                    echo 'Deploy to staging...'
                    // Extract version number from stage_version.txt
                    script {
                        def VERSION = readFile('stage_version.txt').trim()
                        echo "📦 Extracted version from stage_version.txt: ${VERSION}"
                    }
                    // Note: Make sure the remote user (ubuntu@...) is in the "docker" group
                    // Run on remote server: sudo usermod -aG docker ubuntu
                    // Then reconnect SSH or run: newgrp docker
                    // Without this, you'll get "permission denied" when running docker
                    withCredentials([usernamePassword(credentialsId: 'DB_PASS', passwordVariable: 'DB_PASSWORD', usernameVariable: 'DB_USERNAME')]) {
                    sshagent (credentials: ['ubuntu-frankfurt']) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST_STAGE} \\
                            "docker pull ${IMAGE_NAME}:${VERSION} && \\
                            docker rm -f myapp || true && \\
                            docker run -d --name myapp --restart unless-stopped \\
                            -e DB_NAME=todo \\
                            -e DB_USER=${DB_USERNAME} \\
                            -e DB_PASSWORD=\${DB_PASSWORD} \\
                            -e DB_HOST=${DB_HOST} \\
                            -p 5000:5000 ${IMAGE_NAME}:${VERSION}"
                        """
                    }    
                }                                               
            }    
        }  
    }
    
    post {
        // Requires "Slack Notification" plugin in Jenkins:
        // Manage Jenkins → Plugin Manager → Install "Slack Notification"
        failure {
            slackSend(
                channel: '#jenkins',
                color: 'danger',
                message: "FAILED to deploy version ${VERSION}"
            )
            emailext(
                subject: "${JOB_NAME}.${BUILD_NUMBER} FAILED",
                mimeType: 'text/html',
                to: "$email",
                body: "FAILED to deploy version ${VERSION}"
            )
        }

        success {
            slackSend(
                channel: '#jenkins',
                color: 'good',
                message: "PASSED to deploy version ${VERSION}, link for remote host stage for checking: http://stage.netaneltodolist.wuaze.com/"
            )
            emailext(
                subject: "${JOB_NAME}.${BUILD_NUMBER} PASSED",
                mimeType: 'text/html',
                to: "$email",
                body: "PASSED to deploy version ${VERSION}, link for remote host stage for checking: http://stage.netaneltodolist.wuaze.com/"
            )
        }
    }
}
 
