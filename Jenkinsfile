/*
This pipeline will carry out the following on the project:

1. Git secret checker
2. Software Composition Analysis
3. Static Application Security Testing
4. Dynamic Application Security Testing
5. Container security audit 
6. Host security audit

Additionally, endpoint protection will be added to deployed server
*/

/* Which python project is it in git */
pythonproject = "https://github.com/globocom/secDevLabs.git"
ansibleinventory = "pysecpipeline"
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

              virtualenv --no-site-packages .
              source bin/activate
              pip install bandit
              deactivate
           """
        }    
      }
      stage('Checkout code'){
        steps {
          echo 'downloading git directory..'
          git '$pythonproject'
        }
      }      
      stage('git secret check'){
        steps{
          echo 'running trufflehog to check project history for secrets'
          sh 'trufflehog --regex --entropy=False $pythonproject'
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
              source bin/activate
              bandit -r secDevLabs/owasp-top10-2017-apps/a7/gossip-world/app/ -lll
              deactivate
              """
          }
      }
/*      
      stage('Setup stage env') {
          steps {
              echo 'Set up new inventory for use for this pipeline'
              sh """
                  cat<<EOT> /etc/ansible/{$ansibleinventory}
                  [master]
                  localhost ansible_connection=local
                  [webserver]
                  EOT
              """
          }
      }
      stage('DAST') {
          steps {
              echo 'Test the web application from its frontend'
              sh """
                wget https://github.com/sullo/nikto/archive/master.zip
                unzip master.zip
                perl nikto-master/program/nikto.pl -h http://{$testenv}:10007/login
              """
          }
      }
      stage('Container audit') {
          steps {
              echo 'Test the web application from its frontend'
              sh """
                lynis audit dockerfile owasp-top10-2017-apps/a7/gossip-world/deployments/Dockerfile
              """
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
