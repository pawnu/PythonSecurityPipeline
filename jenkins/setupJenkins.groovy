import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule
import jenkins.model.Jenkins
import hudson.security.csrf.DefaultCrumbIssuer

//don't let slave instance kill the master
Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class)
.setMasterKillSwitch(false)

def env = System.getenv()

/*
Jenkins needs URL in order for reference links to point to other pages, resources, pipeline build etc
*/
jlc = JenkinsLocationConfiguration.get()
jlc.setUrl("http://"+env.JenkinsPublicHostname +":8080/")
jlc.save()    

//Set CSRF token for Jenkins server
def instance = Jenkins.instance
instance.setCrumbIssuer(new DefaultCrumbIssuer(true))
instance.save()

/*
Create admin user to login
*/
def jenkins = Jenkins.getInstance()
if(!(jenkins.getSecurityRealm() instanceof HudsonPrivateSecurityRealm))
    jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))

if(!(jenkins.getAuthorizationStrategy() instanceof GlobalMatrixAuthorizationStrategy))
    jenkins.setAuthorizationStrategy(new GlobalMatrixAuthorizationStrategy())

def user = jenkins.getSecurityRealm().createAccount("myjenkins", env.Jenkins_PW)
user.save()
jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, "myjenkins")

jenkins.save()
