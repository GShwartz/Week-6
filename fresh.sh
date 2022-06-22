<<comment
 An Automated script for the ansible controller & playbook running.
 
 Stages:
	1. Update OS packages
	2. Installing Ansible's original package
	3. Upgrading Ansible
	4. Installing Andible Community General Collection
	5. Create ansible directory in ~
	6. Create hosts file under /etc/ansible/hosts
	7. Copy playbook file according to the environment chosen
	8. Add host key checking defaults in under /etc/ansible/ansible.cfg
	9. Run ansible playbook

comment

# Argument Validation:
# If the argument is empty then it means no environment passed- script ends with exit code 1.
if [[ "$1" == "help" ]]
then
	echo "Choose between staging and production environments"
	echo ""
	echo "Example: ./fresh.sh staging | ./fresh.sh production"
	echo ""

fi

if [[ -z "$1" ]]
then
	echo "No environment chosen"
	exit 1
fi

if [[ "$1" == "production" ]] || [[ "$1" == "staging" ]]
then
	ENVI="$1"
	read -s -p "Root password: " USER
	read -s -p "Root password: " PASS

else
	echo "wrong environment"
	exit 1

fi

PRODFILE=~/playbook-prod.yml
STAGEFILE=~/playbook-stage.yml

# Update & Upgrade the Machine
echo ""
echo ""
echo "========================================================================"
echo "Installing OS Updates"
echo "========================================================================"
echo $PASS | sudo -S apt update && sudo apt upgrade -y;

# Install Ansible
echo ""
echo ""
echo "========================================================================"
echo "Installing Ansible"
echo "========================================================================"
echo $PASS | sudo apt install ansible -y;

# Upgrade Ansible Version
echo ""
echo ""
echo "========================================================================"
echo "Upgrading Ansible"
echo "========================================================================"
echo $PASS | sudo apt-add-repository ppa:ansible/ansible
echo $PASS | sudo apt update
echo $PASS | sudo -S apt upgrade -y

# Install Ansible Community Modules
echo ""
echo ""
echo "========================================================================"
echo "Installing Andible Community General Collection"
echo "========================================================================"
ansible-galaxy collection install community.general

# Create Ansible Directory
echo ""
echo ""
echo "========================================================================"
echo "Creating Directory"
echo "========================================================================"
mkdir -p /home/gstudent/ansible;

# Create hosts
echo ""
echo ""
echo "========================================================================"
echo "Creating hosts file in /etc/ansible/hosts "
echo "========================================================================"
sudo rm /etc/ansible/hosts
touch ~/hosts
if [[ "$ENVI" -eq "production" ]] && [[ -f "$PRODFILE" ]]
then
	# Create hosts file
	sudo echo "[webservers]" >> ~/hosts
	for i in {4..6}
	do
		sudo echo "10.0.1.$i ansible_user=$USER ansible_password=$PASS" >> ~/hosts
	
	done
	
	sudo mv ~/hosts /etc/ansible/hosts
	
	# Copy playbook file to /ansible
	echo ""
	echo ""
	echo "========================================================================"
	echo "Copying playbook-prod.yml to /ansible"
	echo "========================================================================"
	mv ~/playbook-prod.yml ~/ansible/

elif [[ "$ENVI" -eq "staging" ]] && [[ -f "$STAGEFILE" ]]
then
	sudo echo "[webservers]" >> ~/hosts
	
	for i in 4 5
	do
		sudo echo "10.0.1.$i ansible_user=$USER ansible_password=$PASS" >> ~/hosts
	
	done
	
	sudo mv ~/hosts /etc/ansible/hosts
	
	# Copy playbook file to /ansible
	echo ""
	echo ""
	echo "========================================================================"
	echo "Copying playbook-stage.yml to /ansible"
	echo "========================================================================"
	mv ~/playbook-stage.yml ~/ansible/

fi


# Define Login with User&Password
echo ""
echo ""
echo "========================================================================"
echo "Adding host key checking to /etc/ansible/ansible.cfg"
echo "========================================================================"
sudo rm /etc/ansible/ansible.cfg
touch ~/ansible.cfg
sudo echo "[defaults]" >> ~/ansible.cfg
sudo echo "host_key_checking = false" >> ~/ansible.cfg
sudo mv ~/ansible.cfg /etc/ansible/ansible.cfg

# Show Andible Version
echo "================="
echo "Ansible Version:"
ansible --version



# Run Ansible Playbook
echo ""
echo ""
echo "========================================================================"
echo "Running playbook-stage..."
echo "========================================================================"
cd ~/ansible/ && ansible-playbook playbook-prod.yml
echo "Script Completed!"

exit 0

# Create SSH Key
#echo ""
#echo ""
#echo "========================================================================"
#echo "Creating SSH-Key"
#echo -en "\n\n\n" | ssh-keygen

# Copy SHH-ID to hosts
#echo ""
#echo ""
#echo "========================================================================"
#echo "Copying SSH-ID"
#echo -en "$PASS" | ssh-copy-id gstudent@10.0.1.4
#echo -en "$PASS" | ssh-copy-id gstudent@10.0.1.5



