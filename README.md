# Week 6 - Ansible
So i've been tasked to get the Weight Tracker application up and running. <br />
There are two ways to get this job done: <br />
1.
  - Install Terraform and all it's dependencies along with Azure CLI
  - Clone the Repo
  - Navigate to your desired environment directory
  - Run terraform apply
  - Change IP address details in OKTA and .env file according to the details you get from the IAAS
  - Login to the controller
  - Update & Upgrade OS
  - Install Ansible and all it's dependencies
  - Upgrade Ansible
  - Create hosts file
  - Edit ansible.cfg to allow using of username&password
  - Copy relevant playbook to the controller
  - Run playbook (each file is in it's relevant directory)
2.
  - Clone the repo
  - Copy env and playbook files to the ~ dir in the controller. (playbook-prod.yml or playbook-stage.yml)
  - Change env name to env-prod or env-stage (depending on the environment)
  - Copy script to ~
  - Change script permissions using chmod +x fresh.sh
  - Run Script according to your environment, for example: ./fresh.sh staging <br />
  - Type in the username and ROOT password.
  - Go get something to eat.

## Script Usage
  * The script accepts only 1 argument. (production | staging)
<img src="https://i.postimg.cc/dVwTCKcf/staging-script-usage.jpg"> <br />

### Example of Play Recap in a staging environment when using the script
<img src="https://i.postimg.cc/J4TXV2kH/stage-andible-recap.jpg"> <br />



