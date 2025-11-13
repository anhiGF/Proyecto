pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo "Contenido del workspace después del checkout:"
                bat 'dir'
            }
        }

        stage('Backend - Composer') {
            steps {
                dir('proyecto-tutorias\\backend') {
                    echo "Verificando backend Laravel..."
                    bat 'dir'

                    bat '''
IF EXIST composer.json (
  echo Ejecutando composer install...
  composer install
  echo Executando php artisan --version...
  php artisan --version
) ELSE (
  echo composer.json NO encontrado. Omitiendo instalación de backend.
)
                    '''
                }
            }
        }

        stage('Frontend - npm build') {
            steps {
                dir('proyecto-tutorias\\frontend') {
                    echo "Verificando frontend React..."
                    bat 'dir'

                    bat '''
IF EXIST package.json (
  echo Ejecutando npm install y npm run build...
  npm install
  npm run build
) ELSE (
  echo package.json NO encontrado. Omitiendo build de frontend.
)
                    '''
                }
            }
        }

        stage('Code Analysis') {
            steps {
                dir('proyecto-tutorias\\backend') {
                    bat '''
IF EXIST app (
  echo Analizando código PHP...
  php -l app\\Http\\Controllers\\*.php
) ELSE (
  echo Carpeta app NO encontrada. Omitiendo analisis.
)
                    '''
                }
            }
        }

        stage('Deploy (simulado)') {
            steps {
                echo 'Despliegue simulado completado.'
            }
        }
    }

    post {
        success {
            echo 'Pipeline ejecutado correctamente.'
        }
        failure {
            echo 'Pipeline falló, revisa errores arriba.'
        }
    }
}
