#!/bin/bash

# Install ansible in AWS ubuntu with the following 
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

# Generate a keypair id_rsa (priv key), id_rsa.pub (public key)
# If the files already exist then it will give error, ignore it by or clause
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa || true

# copy the content of id_rsa.pub to your target host machines's authorised_key file
# authorised_key file is in the same ~/.ssh/ directory of host
# 
# Now your control server will be authorised to ssh to the target host machines without key or password
# Ansible is ready for action!
