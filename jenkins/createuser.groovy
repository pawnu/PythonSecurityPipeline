import jenkins.model.*
import hudson.security.*

def env = System.getenv()

jlc = JenkinsLocationConfiguration.get()
jlc.setUrl("http://"+env.JenkinsPublicIp +":8080/")
jlc.save()    

def jenkins = Jenkins.getInstance()
if(!(jenkins.getSecurityRealm() instanceof HudsonPrivateSecurityRealm))
    jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))

if(!(jenkins.getAuthorizationStrategy() instanceof GlobalMatrixAuthorizationStrategy))
    jenkins.setAuthorizationStrategy(new GlobalMatrixAuthorizationStrategy())

def user = jenkins.getSecurityRealm().createAccount("myjenkins", env.Jenkins_PW)
user.save()
jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, "myjenkins")

jenkins.save()
