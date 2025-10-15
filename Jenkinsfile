pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION', 
            choices: ['plan', 'apply', 'destroy'], 
            description: 'Selecciona la acción de Terraform a ejecutar'
        )
    }

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sa-key') // tu Service Account
        PROJECT_ID = 'jenkins-terraform-demo-472920'
        REGION = 'us-central1'
        ZONE = 'us-central1-a'
    }

    stages {
        stage('Preparar credenciales') {
            steps {
                // Guardar el contenido de la credencial en un archivo temporal
                sh '''
                echo "$GOOGLE_APPLICATION_CREDENTIALS" > ./gcp-key.json
                '''
            }
        }

        stage('Inicializar Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Ejecutar Terraform') {
            steps {
                script {
                    if (params.ACTION == 'plan') {
                        sh '''
                        terraform plan \
                            -var="credentials_file=./gcp-key.json" \
                            -var="project_id=$PROJECT_ID" \
                            -var="region=$REGION" \
                            -var="zone=$ZONE" \
                            -out=tfplan
                        '''
                    } else if (params.ACTION == 'apply') {
                        sh '''
                        terraform apply -auto-approve \
                            -var="credentials_file=./gcp-key.json" \
                            -var="project_id=$PROJECT_ID" \
                            -var="region=$REGION" \
                            -var="zone=$ZONE" \
                            tfplan
                        '''
                    } else if (params.ACTION == 'destroy') {
                        sh '''
                        terraform destroy -auto-approve \
                            -var="credentials_file=./gcp-key.json" \
                            -var="project_id=$PROJECT_ID" \
                            -var="region=$REGION" \
                            -var="zone=$ZONE"
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Acción de Terraform '${params.ACTION}' completada correctamente."
        }
        failure {
            echo "Error ejecutando la acción de Terraform '${params.ACTION}'."
        }
    }
}
