# DevOps-O6
## Introduction
### Brief

Use Ansible to automate the deployment of Bursary Management application onto an AWS EC2 instance. Must be able to install each of the application components onto the new instance and confgure correctly with any dependencies, and containerisation. Set up Jenkins job to execute an Ansible playbook upon each successful build and deploy updates. Terraform could also be used to automate the creation of the EC2 instance on AWS and initialise it with a pre-set-up boot disk or simply run ansible code to install any required dependencies.


### Tasks

* Learn how to use [Anisble](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW).
* Get deployable version of application.
* Determine all steps required to install application onto a fresh VM.
* Implement application installation using an Ansible playbook.
* Get containerisation details from other team memeber and implement.
* Investigate use of Terraform.

<br/> 

## Planning

### Application source and installation
A deployable version of the Bursary Management application can be found [here](https://github.com/ebusico/bursaryproject/tree/aws/bursary-app-v1). The application is based on the MERN stack (MongoDB, Express, React, Nodejs) and currently consists of three major parts. These are a MongoDB database, an Express/Node application (which is found in the NodeExpress folder), and a React application (found in the React folder). The steps required to install each of these components is included within the readme.md file found in the repository branch 'aws/bursary-app-v1' and have also been summarised below. 

 
#### Mongo 
* Install MongoDB onto virtual machine
* Start MongoDB as a service
* Configure for remote access and restart service

#### Express/Node
* Navigate to 'NodeExpress' folder in repository, edit .env file with ip addresses of deployment server.
* Create admin account (if localhost).
* Run setup commands ('npm install', 'node server.js') in 'NodeExpress' folder.

#### React
* Navigate to 'React' folder in repository, edit .env file with ip addresses of deployment server.
* run commands (npm install, npm start) in React folder.
* navigate to localhost:3000 to test deployment.

### Using Ansible

To install the application onto a fresh virtual machine an Ansible playbook will be created. Each of the three application components will have a corrosponding role written to install them, with each role consisting of a number of tasks for each of the above bullet points. Initially the playbook will be executed locally, and each task performed using Ansible modules and shell commands. Once this playbook has been successfully written, it will then be refactored to instead run remotely, and use containerisation with Docker. We will then explore possible extensions to this part of the pipeline, including Terraform.

<br/>

### ~/ansible

**ansible.cfg**: Configuration file for Ansible. When an ansible playbook is executed, Ansible will first search for an ansible.cfg file in the same directory before then looking in the Ansible install location/user home directory. By placing a config file here it allows the default Ansible conifuration options to be overwritten when this playbook is executed. This is used to set the Ansible inventory location to be the 'hosts' file which is found in the same directory.

**hosts**: Contains the ip addresses for all servers the playbook is to be ran on. These hosts can be sorted by groups using either yaml or ini formatting as described [here](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html). This is an example of a 'static inventory' as all of the hosts are defined prior to runtime. For information on 'dynamic inventory' usage, including an example with EC2 instances on AWS here is [another reference](https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#inventory-script-example-aws-ec2).

**main.yml**: The main playbook file for this project. When executed, this playbook will attempt to run on the 'gcpservers' host group as defined in the chosen inventory file (\~/ansible/hosts). The 'become', and 'become_method' arguments are used to specify that the playbook should be executed as the root user. This is done as a majority of the tasks performed in this project require root access to complete successfully. The playbook is split into three sections: 'pre_tasks', 'roles', and 'post_tasks'. The 'pre-tasks' are defined in the setup.yml file, and are executed first. These tasks are used to ensure that the required packages are installed prior to main runtime. During this step a variables file '~/ansible/vars/main.yml' is also attached to the process to import project-wide variables required for the playbook. The 'roles' section, which is processed next, consists of 3 task-sets named: mongodb, react, and nodeExpress. These task-sets make up the bulk of the playbook. Here each 'role' corrosponds to the set of tasks required to install each of the three application components. By default, Ansible will search for details about these roles in a directory named 'roles'. For example, details about the 'react' role should be located in the 'roles/react' directory relative to the playbook. Ansible will execute these roles in the order in which they are supplied, unless otherwise declared. More information about roles can be found in the [Ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html). 
The 'post_tasks' are completed at the end of the playbook, and currently consist of a simple 1-line shell command. This acts as a way to confirm that the playbook has reached its' endstate.


### ~/ansible/vars

