# DevOps-O6
## Project breakdown
### ~/ansible - Main file directory

* **ansible.cfg**: Configuration file for Ansible. When an ansible playbook is executed, Ansible will first search for an ansible.cfg file in the same directory before then looking in the Ansible install location/user home directory. By placing a config file here it allows the default Ansible conifuration options to be overwritten when this playbook is executed. This is used to set the Ansible inventory location to be the 'hosts' file which is found in the same directory.

* **hosts**: Contains the ip addresses for all servers the playbook is to be ran on. These hosts can be sorted by groups using either yaml or ini formatting as described [here](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html). This is an example of a 'static inventory' as all of the hosts are defined prior to runtime. For information on 'dynamic inventory' usage, including an example with EC2 instances on AWS here is [another reference](https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#inventory-script-example-aws-ec2).

* **main.yml**: The main playbook file for this project. When executed, this playbook will attempt to run on the 'gcpservers' host group as defined in the chosen inventory file (\~/ansible/hosts). The 'become', and 'become_method' arguments are used to specify that the playbook should be executed as the root user. This is done as a majority of the tasks performed in this project require root access to complete successfully. The playbook is split into three sections: 'pre_tasks', 'roles', and 'post_tasks'. The 'pre-tasks' are defined in the setup.yml file, and are executed first. These tasks are used to ensure that the required packages are installed prior to main runtime. During this step a variables file '~/ansible/vars/main.yml' is also attached to the process to import project-wide variables required for the playbook. The 'roles' section, which is processed next, consists of 3 task-sets named: mongodb, react, and nodeExpress. These task-sets make up the bulk of the playbook. Here each 'role' corrosponds to the set of tasks required to install each of the three application components. By default, Ansible will search for details about these roles in a directory named 'roles'. For example, details about the 'react' role should be located in the 'roles/react' directory relative to the playbook. Ansible will execute these roles in the order in which they are supplied, unless otherwise declared. More information about roles can be found in the [Ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html). 
The 'post_tasks' are completed at the end of the playbook, and currently consist of a simple 1-line shell command. This acts as a way to confirm that the playbook has reached its' endstate.


* **setup.yml**: This file describes all of the tasks completed during the pre_tasks phase. The first two tasks utilise the Ansible ['apt' module] (https://docs.ansible.com/ansible/latest/modules/apt_module.html) to update and upgrade all packages on the target machine to their latest versions. The next task uses a list variable named 'packages' to install all of the initial dependecies required for this playbook. These are defined in the vars/main.yml file. More information on the usage of variables with Ansible can be found [here](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html). Using the ['file' module](https://docs.ansible.com/ansible/latest/modules/file_module.html), Ansible then checks to see if the machine has an existing version of the react, and node/express application files, and deletes them if they are present. Finally, [the systemd](https://docs.ansible.com/ansible/latest/modules/systemd_module.html) daemon is reloaded to ensure the system state is up-to-date. 

<br/> 

### ~/ansible/vars - System variable directory

* **main.yml**: Any system-wide Ansible variables are defined here. As of now, this includes only the external ip address of the target machine, and a list of the packages which are required for the playbook to run. These are included ([see difference between include and import](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_includes.html)) during the pre-task phase and may be used in the playbook from that point [onwards](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html).

### ~/ansible/files - Main file directory


### ~/ansible/roles - Ansible role directory

