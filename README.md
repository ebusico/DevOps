# DevOps-O6
## Introduction
### Brief

Use Ansible to automate the deployment of Bursary Management application onto an AWS EC2 instance. Must be able to install each of the application components onto the new instance and confgure correctly with any dependencies, and containerisation. Set up Jenkins job to execute the Ansible code upon each successful build. Terraform could also be used to automate the creation of the EC2 instance on AWS and initialise it with a pre-set-up book disk or simply run ansible code to install any required dependencies.


### Tasks

* Learn how to use [Anisble](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW).
* Get deployable version of application.
* Determine all steps required to install application onto a fresh VM.
* Set-up Ansible code to deploy application to a cloud-hosted VM instance via SSH.
* Get containerisation code from other team memeber and implement.
* Investigate use of Terraform.

<br/>

## Planning

A deployable version of the Bursary Management application can be found [here](https://github.com/ebusico/bursaryproject/tree/aws/bursary-app-v1). The application is based on the MERN stack (MongoDB, Express, React, Nodejs) and currently consists of three major parts. These are a MongoDB database, an Express/Node application (which is found in the NodeExpress folder), and a React application (found in the React folder). The steps required to install each of these components is included within the readme.md file found in the repository branch 'aws/bursary-app-v1' and have also been summarised below. 

#### Mongo 
* Install software from [link](https://www.mongodb.com/download-center/community).
* Add install directory to enviroment variables.
* Run commands ('mongod', 'mongo', 'use trainees').

#### Express/Node
* Navigate to 'NodeExpress' folder in repository, edit .env file with ip addresses of deployment server.
* Create admin account (if localhost).
* Run commands ('npm install', 'node server.js') in 'NodeExpress' folder.

#### React
* Navigate to 'React' folder in repository, edit .env file with ip addresses of deployment server.
* run commands (npm install, npm start) in React folder.
* navigate to localhost:3000 to test deployment.
