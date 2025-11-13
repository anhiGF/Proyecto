pipeline {
    agent any

    stages {

        //  CHECKOUT
        stage('Checkout') {
            steps {
                checkout scm
                echo "Contenido del workspace después del checkout:"
                bat 'dir'
            }
        }

        //  BACKEND (Laravel)
        stage('Backend') {
            steps {
                dir('proyecto-tutorias\\backend') {
                    echo "Verificando backend Laravel..."
                    bat 'dir'

                    bat '''
        IF EXIST composer.json (
        echo Ejecutando composer install...
        composer install

        echo.
        echo Configurando archivo .env...
        IF NOT EXIST .env (
            copy .env.example .env
        )

        echo.
        echo Generando APP_KEY...
        php artisan key:generate

        echo.
        echo Verificando version de Laravel...
        php artisan --version
        ) ELSE (
        echo composer.json NO encontrado. Omitiendo instalación de backend.
        )
                    '''
                }
            }
        }


        //  FRONTEND (React/Vite)
        stage('Frontend') {
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

        // TEST (Pruebas de Laravel)
        stage('Test') {
            steps {
                dir('proyecto-tutorias\\backend') {
                    bat '''
IF EXIST artisan (
  echo Ejecutando pruebas de Laravel con php artisan test...
  php artisan test
) ELSE (
  echo artisan NO encontrado. Omitiendo pruebas.
)
                    '''
                }
            }
        }

        // DEPLOY (simulado)
        stage('Deploy') {
            steps {
                echo ' Despliegue simulado completado.'
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
