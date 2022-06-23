#!/bin/bash

<<comment
 An Automated script for the ansible controller machine & Ansible playbook run.
 By Gil Shwartz @2022
 
 Stages:
	1. Update OS packages
	2. Installing Ansible's original package
	3. Upgrading Ansible
	4. Installing Ansible Community General Collection
	5. Create ansible directory in ~
	6. Create hosts file under ~/hosts
	7. Copy playbook file according to the environment in $1
	8. Add host key checking defaults in under /etc/ansible/ansible.cfg
	9. Run ansible playbook according to the environment in $1

comment

# Show Help Information
function get_help () {
	echo "Choose between staging and production environments."
	echo "Make sure the env file is NOT HIDDEN (no . in the filename)."
	echo ""
	echo "Example: ./fresh.sh staging | ./fresh.sh production"
	echo "env file path Example: ~/env-staging | ~/env"
	echo ""
	
	exit 0
}

function get_input () {
	# Cluster VMs Username
	echo "Username:"
	read USER
	
	# Controller Root Password
	read -s -p "Controller root password: " ROOT
	echo ""
	
	# Cluster VNs Password
	read -s -p "Machines Password: " PASS
	echo ""
	
	# ENV filename
	echo "env filename (Example: 'env-prod'): "
	read ENVFILENAME
		
	if ! [ -f "$ENVFILENAME" ]
	then
		echo "No such file '$ENVFILENAME'"
		echo "Type './fresh.sh help' for help"
		exit 1
	fi
	
	echo "$ENVFILEPATH: OK!"
	
	read -n "Number of nodes: " NODES
	echo "GAME ON!!"
}

# Validate Environment User Input
function input_validation () {	
	# Input validation for environment
	if [ "$1" == "production" ]
	then
		get_input	
	
	
	elif [ "$1" == "staging" ]
	then
		get_input
	
	else
		echo "wrong environment. use production or staging."
		echo "Type './fresh.sh help' for help"		
		exit 1

	fi
}

# Update & Upgrade
function update_upgrade () {
	echo ""
	echo ""
	echo "========================================================================"
	echo "Installing OS Updates & Upgrades"
	echo "========================================================================"
	echo $ROOT | sudo -S apt update && sudo apt upgrade -y;
}

# Install Ansible
function ans_install () {
	echo ""
	echo ""
	echo "========================================================================"
	echo "Installing Ansible"
	echo "========================================================================"
	echo $ROOT | sudo apt install ansible -y
}

# Upgrade Ansible version, Update & Upgrade packages
function upgrade_ansible () {
	echo ""
	echo ""
	echo "========================================================================"
	echo "Upgrading Ansible"
	echo "========================================================================"
	echo $ROOT | sudo apt-add-repository ppa:ansible/ansible
	echo $ROOT | sudo apt update
	echo $ROOT | sudo -S apt upgrade -y
}

# Install Ansible Community Modules
function install_ansible_collection () {
	echo ""
	echo ""
	echo "========================================================================"
	echo "Installing Andible Community General Collection"
	echo "========================================================================"
	ansible-galaxy collection install community.general
}

# Create Ansible Directory
function create_dir () {
	echo "========================================================================"
	echo "Creating Directory"
	echo "========================================================================"
	mkdir -p ~/ansible/
}

# Create hosts file under ~/
function create_hosts () {
	echo "========================================================================"
	echo "Creating hosts file in /etc/ansible/hosts "
	echo "========================================================================"
	touch ~/hosts
	echo "[webservers]" >> ~/hosts
	
	if [[ "$1" == "production" ]]
	then
		# Assign IP and prefrences to each host in Staging ENV
		for i in {4..6}
		do
			sudo echo "10.0.1.$i ansible_user=$USER ansible_password=$PASS" >> ~/hosts

		done
	
	else
		# Assign IP and prefrences to each host in Staging ENV
		for i in 4 5
		do
			sudo echo "10.0.1.$i ansible_user=$USER ansible_password=$PASS" >> ~/hosts

		done

	fi
}

# Move hosts file to /etc/ansible/hosts
function move_hosts () {
	echo "========================================================================"
	echo "Moving hosts to /etc/ansible/hosts"
	echo "========================================================================"
	
	sudo mv ~/hosts /etc/ansible/hosts
}

# Move Playbook to ~/ansible
function move_playbook () {
	echo "========================================================================"
	echo "Moving playbook.yml to /ansible"
	echo "========================================================================"
	
	mv ~/playbook.yml ~/ansible/
}

# Configure Ansible to connect with Username & Password
function define_login_method () {
	# Define Login with User&Password
	echo "========================================================================"
	echo "Adding host key checking to /etc/ansible/ansible.cfg"
	echo "========================================================================"
	
	sudo rm /etc/ansible/ansible.cfg
	touch ~/ansible.cfg
	sudo echo "[defaults]" >> ~/ansible.cfg
	sudo echo "host_key_checking = false" >> ~/ansible.cfg
	
	# Overwrite the original /etc/ansible/ansible.cfg
	sudo mv ~/ansible.cfg /etc/ansible/ansible.cfg
}

# Run ~/ansible/playbook.yml
function run_playbook () {
	if [[ "$1" == "staging" ]]
	then
		echo "========================================================================"
		echo "Running Staging playbook..."
		echo "========================================================================"
		
		# Run Ansible playbook on Staging enviroment
		cd ~/ansible/ && ansible-playbook playbook.yml --extra-vars "env=$ENVFILENAME"
	
	elif [ "$1" == "production" ]
	then
		echo "========================================================================"
		echo "Running Production playbook..."
		echo "========================================================================"
		
		# Run Ansible playbook on Production enviroment
		cd ~/ansible/ && ansible-playbook playbook.yml --extra-vars "env=$ENVFILENAME"
	
	fi
}

# If the argument is empty then it means no environment passed- script ends with exit code 1.
if [[ "$1" == "help" ]]
then
	# Show help information if asked to
	get_help

fi

# Validate Environment user input
input_validation "$1"

# Update & Upgrade the Controller OS
update_upgrade

# Installing Ansible
ans_install

# Upgrade Ansible
upgrade_ansible

# Install Ansible Community General Collection
install_ansible_collection

# Create Ansible Directory
create_dir

# Create hosts file
create_hosts "$1"

# Move hosts file to /etc/ansible/hosts
move_hosts

# Move playbook.yml to ~/ansible
move_playbook

# Define Login Method
define_login_method

# Run ansible playbook according to the environment.
run_playbook "$1"

# Removing the unsecured env file
echo "========================================================================"
echo "Removing unsecured files"
echo "========================================================================"
rm ~/"$ENVFILENAME"

echo "FIN!"