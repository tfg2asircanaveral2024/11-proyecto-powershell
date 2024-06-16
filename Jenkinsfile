pipeline {
    agent none
    
    options {
        skipDefaultCheckout true
    }

    environment {
        NOMBRE_USUARIO = 'tfg2asircanaveral2024'
        NOMBRE_IMAGEN = 'pwsh'
        TAG_IMAGEN = '11-proyecto-eficiente'
    }

    stages {
        stage ('Importar Repositorio') {
            agent any

            steps {
                git branch: 'correcto', url: 'https://github.com/tfg2asircanaveral2024/11-proyecto-powershell.git'
            }
        }

        // hacemos un Docker Pull para evitar que la imagen sea construida de nuevo en caso de que en Docker Hub ya exista la misma imagen
        stage('Obtener Imagen (Docker Pull)') {
            agent any

            steps {
                script {
                    docker.image("${NOMBRE_USUARIO}/${NOMBRE_IMAGEN}:${TAG_IMAGEN}").pull()
                }
            }
        }

        // solo se perderá tiempo en esta fase si la imagen obtenida de Docker Hub no está suficientemente actualizada en cuanto a dependencias instaladas
        stage('Crear Imagen') {
            agent any

            steps {
                script {
                    imagen = docker.build("${NOMBRE_USUARIO}/${NOMBRE_IMAGEN}:${TAG_IMAGEN}", "-f imagen-pwsh/Dockerfile imagen-pwsh")
                }
            }
        }

        stage('Tests (Pester)') {
            agent { 
                docker {
                    image "${NOMBRE_USUARIO}/${NOMBRE_IMAGEN}:${TAG_IMAGEN}"
                }
            }

            steps {
                pwsh 'Invoke-Pester -ErrorAction Stop'             
            }
        }

        stage('Tests (PSScriptAnalyzer)') {
            agent {
                docker { 
                    image "${NOMBRE_USUARIO}/${NOMBRE_IMAGEN}:${TAG_IMAGEN}"
                }
            }

            steps {
                pwsh './Gestionar-Datos.ScriptAnalyzer.ps1'            
            }
        }
        
        stage('Despliegue a la rama Produccion de GitHub') {
            agent any
            steps {
                sh 'chmod u+x script-despliegue-git.sh'                
                sh './script-despliegue-git.sh'
            }
        }
    }
}