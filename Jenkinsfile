pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/anhiGF/Proyecto.git'
            }
        }

        stage('Backend Composer') {
            steps {
                dir('backend') {
                    sh 'composer install'
                    sh 'php artisan --version'
                }
            }
        }

        stage('Frontend Build') {
            steps {
                dir('frontend') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Code Analysis') {
            steps {
                sh 'php -l backend/app/**/*.php || true'
            }
        }

        stage('Deploy') {
            steps {
                echo "Despliegue completado "
            }
        }
    }
}
