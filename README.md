# Week 6 - Ansible
So i've been tasked to get the Weight Tracker application up and running. <br />
There are two ways to get this job done: <br />
1.
  - Apply the IAAC using terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
  - Clone the repo
  - Copy env and playbook files to the ~ dir in the controller. (playbook-prod.yml or playbook-stage.yml)
  - Edit IP address in the env file and change its name to env-prod or env-stage (depending on the environment)
  - Copy the changed env file to ~ on the controller
  - Copy script to the controller
  - Change script permissions using chmod +x fresh.sh
  - Run Script according to your environment, for example: ./fresh.sh staging <br />
  - Type in the username and ROOT password.
  - Go get something to eat.

## Script Usage
  * The script accepts only 1 argument. (production | staging)
<img src="https://i.postimg.cc/dVwTCKcf/staging-script-usage.jpg"> <br />

### Example of Play Recap in a STAGING environment when using the script
<img src="https://i.postimg.cc/J4TXV2kH/stage-andible-recap.jpg"> <br />

### Example of Play Recap in a PRODUCTION environment when using the script <br />
<img src="https://i.postimg.cc/d1YPBvwb/prod-andible-recap.jpg"> <br />


