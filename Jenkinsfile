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

        stage('Crear Imagen') {
            agent any

            steps {
                script {
                    imagen = docker.build("${NOMBRE_USUARIO}/${NOMBRE_IMAGEN}:${TAG_IMAGEN}", "-f imagen-pwsh/Dockerfile imagen-pwsh")
                }
            }
        }

        stage('Publicar Imagen') {
            agent any

            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'credenciales-dockerhub') {
                        imagen.push("${TAG_IMAGEN}")
                    }
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