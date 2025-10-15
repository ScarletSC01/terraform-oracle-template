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
        PROJECT_ID = 'jenkins-terraform-demo-472920'
        REGION     = 'us-central1'
        ZONE       = 'us-central1-a'
    }

    stages {
        stage('Preparar credenciales') {
            steps {
                withCredentials([file(credentialsId: 'gcp-sa-key', variable: 'GCP_KEY_FILE')]) {
                    script {
                        // Leer contenido del archivo JSON para pasarlo como variable a Terraform
                        env.CREDENTIALS_JSON = readFile(env.GCP_KEY_FILE).trim()
                    }
                }
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
                    def tfvars = "-var='credentials_content=${env.CREDENTIALS_JSON}' -var='project_id=${PROJECT_ID}' -var='region=${REGION}' -var='zone=${ZONE}'"
                    
                    if (params.ACTION == 'plan') {
                        sh "terraform plan ${tfvars} -out=tfplan"
                    } else if (params.ACTION == 'apply') {
                        // Aplicar directamente sin volver a pasar variables al plan
                        sh "terraform apply -auto-approve ${tfvars}"
                    } else if (params.ACTION == 'destroy') {
                        sh "terraform destroy -auto-approve ${tfvars}"
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
