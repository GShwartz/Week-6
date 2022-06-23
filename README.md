# Week 6 - Ansible
So i've been tasked to get the Weight Tracker application up and running on multiple environments with multiple machines. <br />
In my opinion, like the [AIM-120 AMRAAM](https://en.wikipedia.org/wiki/AIM-120_AMRAAM), nothing beats a Fire-And-Forget approach.

## Playbook tasks
  1. Download NodeJS 14.X Source
  2. Install NodeJS
  3. Clone the Webapp repo from github
  4. Copy ENV file to WebApp's repo with a **hidden attribute** (.env)
  5. Create an entry in crontab
  6. Install WebApp JS Package
  7. Initalize App's Database
  8. Reboot remote servers

## Script Stages
  #### Validation Stage
    1. Argument Validation - Checks any argument was entered to the command.
    2. Environment Validation - Check if the correct environment passed from the CLI command.
    3. File Validation - Checks if the env file passed exists. 
       (maybe you forgot to copy it? if that's the case, re-check your env settings before copying)
  
  #### Runtime Stage
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
  - Edit IP address and other relevant details in the env file and change its name to env-prod or env-stage (depending on the environment)
  - Edit the DB & OKTA URLS in your env file
  - Copy env and playbook files to the ~ dir in the controller. (playbook-prod.yml or playbook-stage.yml)
  - Copy the changed env file to ~ on the controller
  - Copy script to ~ on the controller
  - Change script permissions using chmod +x fresh.sh
  - Run Script according to your environment, for example: ./fresh.sh staging <br />
  - Type in the Machines Username, Machines Password and ROOT Password for the controller.
  - **MAKE SURE THE ENV FILE DOESN'T HAVE THE . ATTRIBUTE** (Example: .env)
  - Go get something to eat.

## Troubleshooting
### Tested on Ubuntu 20.04
  * Sometimes the playbook can freeze while doing a task. usually a re-run of the script solves the issue.
  * If the playbook hangs on the database task it probably means you forgot to change the DB URL in your env file.
  * If you happen to copy the script, run it and get an interpreter error then just create a new script file and paste the contents.
    - make sure you give the new script file execution permissions. (chmod +x ./fresh.sh)

## Total files Copied to the Controller machine
<img src="https://i.postimg.cc/43LcYjSV/total-files-in-controller.jpg"> <br />

## Total files when the script ends
<img src="https://i.postimg.cc/MGSG7qQB/post-script.jpg"> <br />

## Script Usage
The script accepts only 1 argument. (production | staging)
<img src="https://i.postimg.cc/dVwTCKcf/staging-script-usage.jpg"> <br />

### Example of Play Recap in a STAGING environment when using the script
<img src="https://i.postimg.cc/J4TXV2kH/stage-andible-recap.jpg"> <br />

### Example of Play Recap in a PRODUCTION environment when using the script <br />
<img src="https://i.postimg.cc/d1YPBvwb/prod-andible-recap.jpg"> <br />

### Crontab Entry
<img src="https://i.postimg.cc/MGhSY2d1/crontab-entry.jpg"> <br />

### POC of the above
<img src="https://i.postimg.cc/qqwyM8k1/poc.jpg"> <br />
