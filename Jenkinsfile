pipeline {
    agent any

	tools {
        maven 'Maven 3.5.2'
        jdk 'jdk8'
    }
	
    stages {
        stage('Build') {
            steps {
                echo 'Building in the snapshot repo ...'
				sh 'pwd' 
				//sh 'mvn clean package -DtargetRepo /root/repositories/API-javaSpringboot_local/snapshot/'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Clean') {
            steps {
                echo 'Cleaning ...'
				//sh 'rm target/API-javaSpringboot*.jar'
            }
        }
    }
}