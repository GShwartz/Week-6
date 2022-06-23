# Week 6 - Ansible
So i've been tasked to get the Weight Tracker application up and running. <br />

## Playbook tasks
  1. Download NodeJS 14.X Source
  2. Install NodeJS
  3. Clone the Webapp repo from github
  4. Copy ENV file to repo
  5. Create an entry in crontab
  6. Install WebApp JS Package
  7. Initalize App's Database
  8. Reboot remote servers

## Script Stages
  1. Update & Upgrade OS packages
  2. Install Ansible Package from apt repo
  3. Upgrade Ansible Version
  4. Install Ansible Community General Collection
  5. Create Ansible directory (~/) (result: ~/ansible)
  6. Create hosts file (~/hosts)
  7. Update hosts file according to the environment set by the CLI command
  8. Copy playbook file to ~/ansible
  9. Add host key checking defaults in /etc/ansible/ansible.cfg
  10. Run Ansible playbook according to the environment set by the CLI command
  
## Installation
  - Apply the IAAC using terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
  - Clone the bootcamp-app repo (https://github.com/GShwartz/bootcamp-app.git)
  - Copy env and playbook files to the ~ dir in the controller. (playbook-prod.yml or playbook-stage.yml)
  - Edit IP address in the env file and change its name to env-prod or env-stage (depending on the environment)
  - Copy the changed env file to ~ on the controller
  - Copy script to the controller
  - Change script permissions using chmod +x fresh.sh
  - Run Script according to your environment, for example: ./fresh.sh staging <br />
  - Type in the username and ROOT password.
  - Go get something to eat.

## Total files Copied to the Controller machine
<img src="https://i.postimg.cc/43LcYjSV/total-files-in-controller.jpg"> <br />

## Script Usage
  * The script accepts only 1 argument. (production | staging)
<img src="https://i.postimg.cc/dVwTCKcf/staging-script-usage.jpg"> <br />

### Example of Play Recap in a STAGING environment when using the script
<img src="https://i.postimg.cc/J4TXV2kH/stage-andible-recap.jpg"> <br />

### Example of Play Recap in a PRODUCTION environment when using the script <br />
<img src="https://i.postimg.cc/d1YPBvwb/prod-andible-recap.jpg"> <br />

### POC of the above
<img src="https://i.postimg.cc/qqwyM8k1/poc.jpg"> <br />
