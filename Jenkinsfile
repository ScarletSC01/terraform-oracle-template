pipeline {
    agent any

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

        stage('Planificar Infraestructura') {
            steps {
                sh '''
                terraform plan -var="credentials_file=$GOOGLE_APPLICATION_CREDENTIALS" \
                               -var="project_id=$PROJECT_ID" \
                               -out=tfplan
                '''
            }
        }

        stage('Aplicar Cambios') {
            steps {
                sh '''
                terraform apply -auto-approve tfplan
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Despliegue completado con éxito."
        }
        failure {
            echo "❌ Error en el despliegue de Terraform."
        }
    }
}
