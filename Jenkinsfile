pipeline {
    agent any
	
	environment {
		package_version = readMavenPom().getVersion()
		dockerRegistry = "devops.maddoudou.click:5000"
		dockerRepo = "api-javaspringboot"
		applicationName = 'API-javaSpringboot' // Same as artifactId in pom.xml
		kubernetesNode = 'rancher.maddoudou.click'
		deploymentConfigurationPathSource = "deploy-k8s" // Location of the K8s deployment configuration on the pipeline instance
		deploymentConfigurationPathKubernetes = "/home/ubuntu/k8s-deployments" // Location of the K8s deployment configuration on the K8s instace
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building ...'
				//sh 'mvn -T 10 -Dmaven.test.skip=true clean install'
				sh 'mvn -T 10 -Dmaven.test.skip=true clean package'
            }
        }
		
		stage('Unit test') {
            steps {
                echo 'Unit testing ...'
				sh 'mvn test'
            }
        }

		stage('Publish snapshot') {
            steps {
                echo 'Publising into the snapshot repo ...'
				sh 'mvn jar:jar deploy:deploy'
            }
        }
		
		stage('OWASP - Dependencies check') {
            steps {
                echo 'Check OWASP dependencies ...'
				sh 'mvn dependency-check:check'
            }
        }
		
		stage('Sonar - Code Quality') {
            steps {
                echo 'Check Code Quality ...'
				sh 'mvn sonar:sonar' // -Dsonar.dependencyCheck.reportPath=target/dependency-check-report.xml'
            }
        }
		
        stage('Contract testing') {
            steps {
                echo 'Testing application conformity according to its Swagger definition ...'

            }
        }
		
        stage('Bake') {
            steps {
                echo 'Building Docker image ...'
				sh 'docker build --rm --build-arg PACKAGE_VERSION=${package_version} --build-arg APPLICATION_NAME=${applicationName} -t ${dockerRegistry}/${dockerRepo}:${package_version} .'
				echo 'Removing dangling Docker image from the local registry ...'
				//sh "docker rmi $(docker images --filter "dangling=true" -q --no-trunc) 2>/dev/null"
				echo 'Publishing Docker image into the private registry ...'
				sh 'docker push ${dockerRegistry}/${dockerRepo}:${package_version}'
            }
        }

		stage('Deploy') {
            steps {
                echo 'Checking Kubernetes readiness ...'
				sh 'ssh -oStrictHostKeyChecking=no -i /var/lib/keys/ireland.pem ubuntu@${kubernetesNode} "kubectl get nodes"'
				echo 'Sending deployment configuration files to Kubernetes ...'
				sh 'pwd'
				sh 'scp -oStrictHostKeyChecking=no -i /var/lib/keys/ireland.pem ${deploymentConfigurationPathSource}/* ubuntu@${kubernetesNode}:${deploymentConfigurationPathKubernetes}/${applicationName}'
				//sh 'docker run -d -p 8088:8080 ${dockerRegistry}/${dockerRepo}:${package_version}'
            }
        }
    }
}