pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                //  "Pipeline script from SCM", esto basta:
                checkout scm
            }
        }

        stage('Backend Composer') {
            steps {
                dir('backend') {
                    // Comandos en Windows usan bat
                    bat 'composer --version'
                    bat 'composer install'
                    bat 'php artisan --version'
                }
            }
        }

        stage('Frontend Build') {
            steps {
                dir('frontend') {
                    bat 'npm -v'
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }

        stage('Code Analysis') {
            steps {
                dir('backend') {
                    // Validación sintáctica básica
                    bat 'php -l app\\Http\\Controllers\\*.php'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Despliegue simulado completado'
            }
        }
    }

    post {
        success {
            echo 'Pipeline ejecutado correctamente.'
        }
        failure {
            echo 'Error en la ejecución del pipeline.'
        }
    }
}
