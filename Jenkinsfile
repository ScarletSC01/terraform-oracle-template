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
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sa-key')
        PROJECT_ID = 'jenkins-terraform-demo-472920'
    }

    stages {
        stage('Inicializar Terraform') {
            steps {
                sh '''
                terraform init
                '''
            }
        }

        stage('Ejecutar Terraform') {
            steps {
                script {
                    if (params.ACTION == 'plan') {
                        sh '''
                        terraform plan -var="credentials_file=$GOOGLE_APPLICATION_CREDENTIALS" \
                                       -var="project_id=$PROJECT_ID" \
                                       -out=tfplan
                        '''
                    } else if (params.ACTION == 'apply') {
                        sh '''
                        terraform apply -auto-approve tfplan
                        '''
                    } else if (params.ACTION == 'destroy') {
                        sh '''
                        terraform destroy -auto-approve -var="credentials_file=$GOOGLE_APPLICATION_CREDENTIALS" \
                                                           -var="project_id=$PROJECT_ID"
                        '''
                    } else {
                        error "Acción inválida: ${params.ACTION}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Terraform ejecutado correctamente: ${params.ACTION}"
        }
        failure {
            echo "Error en la ejecución de Terraform"
        }
    }
}
