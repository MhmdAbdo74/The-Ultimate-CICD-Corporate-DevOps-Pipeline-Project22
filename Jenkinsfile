pipeline {
    agent any
    
    tools {
        maven 'mvn'
        jdk 'jdk17'
        // Add SonarQube Scanner tool
        
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/MhmdAbdo74/The-Ultimate-CICD-Corporate-DevOps-Pipeline-Project.git'
            }
        }
        
        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('File System Scan') {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh "$SCANNER_HOME/bin/sonar-scanner  \
                        -Dsonar.projectName=BoardGame \
                        -Dsonar.projectKey=BoardGame \
                        -Dsonar.java.binaries=src/"
                }
            }
        }
   stage('Quality Gate') {
 steps {
 script {
 waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
 }
 }
 }
       stage ('Build')
        {
            steps {
                sh 'mvn clean package'
            }
           
        }
        
        stage('publish to nexus ')
        {
            steps {
               withMaven(globalMavenSettingsConfig: 'nexus-setting', jdk: 'jdk17',
               maven: 'mvn', mavenSettingsConfig: '', traceability: true) {
              sh "mvn deploy"

            }
        }




    }
    stage('Build & Tag Docker Image') {
 steps {
 script {
 withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
 sh "docker build -t   mohamed222/boardgame:latest ."
 }
 }
 }
 }
  stage('Docker Image Scan') {
steps {
sh "trivy image --format table -o trivy-image-report.html mohamed222/boardgame:latest"
}
}
stage('Push Docker Image') {
steps {
script {
withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
sh "docker push mohamed222/boardgame:latest"
}
}
}
}

   stage('Deploy To Kubernetes') {
steps {
withKubeConfig(caCertificate: '', clusterName: 'fghfh', contextName: '',
credentialsId: 'k8s-cred', namespace: 'web-apps', restrictKubeConfigAccess: false,
serverUrl: 'https://10.0.1.181:6443') {
sh "kubectl apply -f deployment-service.yaml"
}
}
   }
stage('Verify the Deployment') {
steps {
withKubeConfig(caCertificate: '', clusterName: 'fghfh', contextName: '',
credentialsId: 'k8s-cred', namespace: 'web-apps', restrictKubeConfigAccess: false,
serverUrl: 'https://10.0.1.181:6443') {
sh "kubectl get pods -n web-apps"
sh "kubectl get svc -n web-apps"
}
}



}


    
    }
}