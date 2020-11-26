pipeline {
    stages {
        stage('Pull code') {
            steps {
                cleanWs()
                git branch: "develop", credentialsId: 'git-ci-user', url: "$GIT_APP_URL"
            }
        }
        stage('Build') {
            steps {
                // build
                script {
                    // defind app name and get version from build.gradle
                    env.APP_NAME='sbthapi0'
                    env.APP_VERSION=sh(returnStdout: true, script: 'grep "version = " build.gradle | tr -d " ""\'" | cut -d "=" -f 2').trim()
                    sh """
                        docker build \
                            --build-arg APP_NAME=$APP_NAME \
                            --build-arg APP_VERSION=$APP_VERSION \
                            --file Dockerfile \
                            --tag $APP_NAME:$APP_VERSION .
                    """
                }
            }
        }
        stage('Upload to repository') {
            steps {
                sh "docker push $APP_NAME:$APP_VERSION"
            }
        }
    }
    post {
        always {
            // remove deployment image after push to repository
            sh "docker image rm ${DOCKER_IMAGE}:${APP_VERSION} || exit 0"
        }
    }
}
