/*
This pipeline will carry out the following on the project:

1. Git secret checker
2. Software Composition Analysis
3. Static Application Security Testing
4. Container security audit 
5. Dynamic Application Security Testing
6. Host security audit

Additionally, endpoint protection will be added to deployed server
*/

/* Which python project is it in git */
def pythonproject = "https://github.com/globocom/secDevLabs.git"
def testenv = ""

pipeline {

    /* Which agent are we running this pipeline on? We can configure different OS */
    agent any
    
    stages {
      stage('Prepare tools'){
        steps{
          sh """
              pip install safety
              pip install trufflehog
              pip install ansible
              pip install boto boto3
              #virtualenv --no-site-packages .
              #source bin/activate
              pip install bandit
              #deactivate
           """
        }    
      }
      stage('Checkout code'){
        steps {
          echo 'downloading git directory..'
		git '{$pythonproject}'
        }
      }      
      stage('git secret check'){
        steps{
          echo 'running trufflehog to check project history for secrets'
	  sh 'trufflehog --regex --entropy=False {$pythonproject}'
        }
      }
      stage('SCA'){
        steps{
          echo 'running python safety check on requirements.txt file'
          sh 'safety check -r secDevLabs/owasp-top10-2017-apps/a7/gossip-world/app/requirements.txt'
        }
      }  
      stage('SAST') {
          steps {
              echo 'Testing source code for security bugs and vulnerabilities'
              sh """
              #source bin/activate
              bandit -r secDevLabs/owasp-top10-2017-apps/a7/gossip-world/app/ -lll
              #deactivate
              """
          }
      }
      stage('Container audit') {
          steps {
              echo 'Audit the dockerfile used to spin up the web application'
              sh """
                lynis audit dockerfile owasp-top10-2017-apps/a7/gossip-world/deployments/Dockerfile
              """
          }
      }	    
      stage('Setup stage env') {
          steps {
              sh """
              ssh-keygen -t rsa -N "" -f ~/.ssh/ansible_key || true
              ansible-playbook createAwsEc2.yml
              """
          }
      }
/*
        stage('DAST') {
          steps {
                //Test the web application from its frontend
		def exists = fileExists 'nikto-master/program/nikto.pl'
		if(exists){
			echo 'already exists'
		}else{
			sh 'wget https://github.com/sullo/nikto/archive/master.zip'
			sh 'unzip master.zip'
			sh 'rm master.zip'
			sh 'perl nikto-master/program/nikto.pl -h http://{$testenv}:10007/login'
		}          
          }
      }
      stage('Host audit') {
          steps {
              echo 'Use ansible for this'
          }
      }
      
*/      
    }
}
