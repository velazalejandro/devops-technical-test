pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'python3 -m compileall app'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t devops-test:${env.BUILD_NUMBER} ."
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker stop devops-test || true
                    docker rm devops-test || true

                    docker run -d \
                      --name devops-test \
                      -p 5000:5000 \
                      --restart unless-stopped \
                      devops-test:${BUILD_NUMBER}
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    echo "Comprobando estado de la aplicación..."

                    for i in $(seq 1 10); do
                        if curl -fs http://localhost:5000/health; then
                            echo ""
                            echo "Health Check OK"
                            exit 0
                        fi

                        echo "La aplicación todavía no está disponible. Reintentando..."
                        sleep 3
                    done

                    echo "Health Check FAILED"
                    exit 1
                '''
            }
        }
    }

    post {
        success {
            echo 'Despliegue completado con éxito'
        }

        failure {
            echo 'La pipeline ha fallado. Revisa los logs.'

        }
    }
}
