pipeline {
    environment {
        IMAGEN = "kiko4/django_tutorial"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent any
    stages {
        stage("Bajar_imagen") {
            agent {
                docker {
                    image "python:3"
                    args '-u root:root'
                }
            }
            stages {
                stage('Repositorio') {
                    steps {
                        git branch:'master',url:'https://github.com/K1K04/django_tutorial.git'
                    }
                }
                stage('Requirements') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test')
                {
                    steps {
                        sh 'python manage.py test --settings=django_tutorial.desarrollo'
                    }
                }

            }
        }
        stage("Gen_imagen") {
            agent any
            stages {
                stage('build') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:latest"
                        }
                    }
                }
                stage('Subir') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('Borrar') {
                    steps {
                        sh "docker rmi $IMAGEN:latest"
                    }
                }
            }
        }
        stage('VPS') {
        agent any
        steps {
            sshagent(credentials: ['VPS_SSH']) {
                sh '''
                ssh -p 4444 -o StrictHostKeyChecking=no debian@popeye.kiko4da.fun <<EOF
                    cd ~/jenkins || exit
                    docker-compose down
                    docker rmi -f kiko4/django_tutorial:latest
                    docker-compose up -d --force-recreate
                '''
            }
        }
    }
    }
    post {
        always {
            mail to: 'kiko4da4@gmail.com',
            subject: "Pipeline IC: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
