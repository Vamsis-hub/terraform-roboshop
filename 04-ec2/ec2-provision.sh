#!/bin/bash

yum install ansible -y
cd /tmp
git clone https://github.com/Vamsis-hub/ansible-roboshop-roles.git
cd ansible-roboshop-roles
ansible-playbook -e variable=mongodb main.yaml
ansible-playbook -e variable=redis main.yaml
ansible-playbook -e variable=mysql main.yaml
ansible-playbook -e variable=rabbitmq main.yaml
ansible-playbook -e variable=catalogue main.yaml
ansible-playbook -e variable=cart main.yaml
ansible-playbook -e variable=user main.yaml
ansible-playbook -e variable=shipping main.yaml
ansible-playbook -e variable=payment main.yaml
ansible-playbook -e variable=web main.yaml