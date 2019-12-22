/* Which python project is it in git */
pythonproject = "https://github.com/globocom/secDevLabs.git"
ansibleinventory = "pysecpipeline"

/*
This pipeline will run following scans on the project:

1. Git secret checker
2. Software Composition Analysis
3. Static Application Security Testing
4. Dynamic Application Security Testing
5. Vulnerability assessment 
6. Compliance checks

Additionally, endpoint protection will be added to deployed server
*/

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
              echo 'Testing insecure dependency'
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
*/      
    }
}
