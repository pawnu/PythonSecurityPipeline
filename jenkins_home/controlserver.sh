#!/bin/bash

# Install ansible in AWS ubuntu with the following 
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

# Generate a keypair ansible_key (priv key), ansible_key.pub (public key)
# If the files already exist then it will give error, ignore it by using OR clause
ssh-keygen -t rsa -N "" -f ~/.ssh/ansible_key || true

#create host file to store launched test server
cat<<EOT>> ~/ansible_hosts
[local]
localhost ansible_connection=local
[tstlaunched]
EOT

#setup the ssh priv key for ansible to log into launched vms
#we're not concerned about host key checks as these test servers will be deleted
cat<<EOT>> /etc/ansible/ansible.cfg
host_key_checking = False
private_key_file = /home/ubuntu/.ssh/ansible_key
EOT 

# If manually setting up ansible control server and target hosts to manage,
# copy the content of ansible_key.pub to your target host machines's authorised_key file
# authorised_key file is in the same ~/.ssh/ directory of target host
# 
# Now your control server will be authorised to ssh to the target host machines without key or password
# Ansible is ready for action!
