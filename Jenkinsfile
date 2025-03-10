pipeline {
    environment {
        IMAGEN = "kiko4/django_tutorial"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent any
    stages {
        stage("Pruebas") {
            agent {
                docker {
                    image "python:3"
                    args '-u root:root'
                }
            }
            stages {
                stage('Clonar') {
                    steps {
                        git branch:'master',url:'https://github.com/josedom24/django_tutorial.git'
                    }
                }
                stage('Instalar') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'python3 manage.py test'
                    }
                }
            }
        }
        stage("Docker") {
            agent any
            stages {
                stage('Construir imagen') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:latest"
                        }
                    }
                }
                stage('Subir imagen') {
                    steps {
                        script {
                            docker.withRegistry('', LOGIN) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('Eliminar imagen') {
                    steps {
                        sh "docker rmi $IMAGEN:latest"
                    }
                }
            }
        }
    }
    post {
        always {
            mail to: 'kiko4da4@gmail.com',
            subject: "Pipeline Django Tutorial: ${currentBuild.fullDisplayName}",
            body: "El pipeline ${env.BUILD_URL} ha finalizado con resultado: ${currentBuild.result}"
        }
    }
}
