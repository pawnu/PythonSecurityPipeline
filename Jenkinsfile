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
      stage('Checkout code'){
        steps {
          echo 'downloading git directory..'
	  git 'https://github.com/globocom/secDevLabs.git'
        }
      }      
      stage('git secret check'){
        steps{
	  script{
		echo 'running trufflehog to check project history for secrets'
		sh 'trufflehog --regex --entropy=False --max_depth=3 https://github.com/globocom/secDevLabs'
	  }
        }
      }
      stage('SCA'){
        steps{
          echo 'running python safety check on requirements.txt file'
          sh 'safety check -r $WORKSPACE/owasp-top10-2017-apps/a7/gossip-world/app/requirements.txt'
        }
      }  
      stage('SAST') {
          steps {
              echo 'Testing source code for security bugs and vulnerabilities'
	      sh 'bandit -r $WORKSPACE/owasp-top10-2017-apps/a7/gossip-world/app/ -lll'
          }
      }
      stage('Container audit') {
          steps {
              echo 'Audit the dockerfile used to spin up the web application'
		script{				
			def exists = fileExists '/var/jenkins_home/lynis/lynis'
			if(exists){
				echo 'lynis already exists'
			}else{
			      sh """
			      wget https://downloads.cisofy.com/lynis/lynis-2.7.5.tar.gz
			      tar xfvz lynis-2.7.5.tar.gz -C ~/
			      rm lynis-2.7.5.tar.gz
			      """
			}
		
		}
		  dir("/var/jenkins_home/lynis"){  
			sh './lynis audit dockerfile $WORKSPACE/owasp-top10-2017-apps/a7/gossip-world/deployments/Dockerfile'
		  }	
          }
      }	    
      stage('Setup stage env') {
          steps {
              sh """
	      #refresh inventory
	      echo "[local]" > ~/ansible_hosts
	      echo "localhost ansible_connection=local" >> ~/ansible_hosts
	      echo "[tstlaunched]" >> ~/ansible_hosts
	      
	      tar cvfz /var/jenkins_home/pythonapp.tar.gz -C $WORKSPACE/owasp-top10-2017-apps/a7/ .

              ssh-keygen -t rsa -N "" -f ~/.ssh/ansible_key || true
              ansible-playbook -i ~/ansible_hosts ~/createAwsEc2.yml
              """		  
	      script{
		 testenv = sh(script: "sed -n '/tstlaunched/{n;p;}' /var/jenkins_home/ansible_hosts", returnStdout: true)
	      }
	      sh  'ansible-playbook -i ~/ansible_hosts ~/configureTestEnv.yml'
          }
      }
      stage('DAST') {
          steps {
		script{				
			//Test the web application from its frontend
			def exists = fileExists '~/nikto-master/program/nikto.pl'
			if(exists){
				echo 'nikto already exists'
			}else{
			      sh """
				wget https://github.com/sullo/nikto/archive/master.zip
				unzip master.zip -d ~/
				rm master.zip
			      """
			}
		}
		sh 'perl nikto-master/program/nikto.pl -h http://${testenv}:10007/login'
	   }
      }
/*	    
      stage('Host audit') {
          steps {
              echo 'Use ansible for this'
          }
      }
      
*/      
    }
}
