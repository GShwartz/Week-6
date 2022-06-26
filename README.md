# Week 6 - Ansible
So i've been tasked to get the Weight Tracker application up and running on multiple environments with multiple machines. <br />
In my opinion, like the [AIM-120 AMRAAM](https://en.wikipedia.org/wiki/AIM-120_AMRAAM), nothing beats the Fire-And-Forget approach.


███████╗██████╗░███████╗░██████╗██╗░░██╗<br />
██╔════╝██╔══██╗██╔════╝██╔════╝██║░░██║<br />
█████╗░░██████╔╝█████╗░░╚█████╗░███████║<br />
██╔══╝░░██╔══██╗██╔══╝░░░╚═══██╗██╔══██║<br />
██║░░░░░██║░░██║███████╗██████╔╝██║░░██║<br />
╚═╝░░░░░╚═╝░░╚═╝╚══════╝╚═════╝░╚═╝░░╚═╝<br />

## Required Information
	* Nodes = number of endpoints to manage
	* VM Username = the username for the nodes
	* VM Password = password for the nodes
	* Controller root password = password for the fresh controller so the script
	  can run updates and installs.
	* ENV filename = name of the env file you copied to this machine. (Example: 'env-prod')
	  ***Make sure the env file is NOT HIDDEN (no . in the filename).***
	* Playbook filename = name of the playbook file you copied to this machine ('Example: playbook.yml')
	* Starting IP Address = the IP address for the first node.- the script will then
	  create a nodes list that ends with the number of nodes passed earlier.
      Example: ./fresh.sh -n 2 -s 192.168.100.11 will create a hosts file that will look like:
	  [webservers]
	  192.168.100.11
	  192.168.100.12

	  [webservers:vars]
	  ansible_connection=ssh
	  ansible_ssh_user=$USER
	  ansible_ssh_pass=$PASS
	  ansible_sudo_pass=$PASS
<img src="https://i.postimg.cc/5t38VLh4/hosts.jpg"> <br />

=-=-=-=-=-=-=-=-=-=-=-=<br />
FLAGS & ARGUMENTS      <br />
=-=-=-=-=-=-=-=-=-=-=-=<br />
**-h, --help**      ....................... Show Script information and usage details<br />
**-n, --nodes**     ....................... Number of remote machines.<br />
**-e, --env**       ....................... Name of the env file (Example: 'env-production').<br />
**-p, --playbook**  ....................... Name of the playbook file (Example: 'playbook.yml').<br />
**-u, --user**      ....................... Username to be used on the remote machines.<br />
**-i, --ip-address**....................... Starting IP Address of the remote machines.<br />
**-s. --skip**      ....................... Skip initial updates and packages installs .<br />

**If no arguments passed then the script will prompt for the information when executing.**<br />

## Usage Examples:
./fresh -n [N of Nodes] -e [envfile] -p [playbookfile] -s [startingipaddress] -u [vmusername] --skip yes

## Script Stages
  #### Validation Stage
    1. Arguments - Checks if any argument was entered to the command, if not, prompt on execute.
	2. Nodes - Checks if input is higher than 1. (minimum 2 nodes)
    2. ENV file - Checks if the env file passed from the CLI exists. 
       (maybe you forgot to copy it? if that's the case, re-check your env settings before copying)
    3. Playbook file - Checks if the playbook file passed from the CLI exists.
    4. IP Validation - Checks if the IP is valid, if not then exits. - if IP argument is empty, 
       validation will be active on the prompt for IP stage.
  
  #### Runtime Stage
  1. Update & Upgrade OS packages
  2. Install Ansible Package from apt repo
  3. Upgrade Ansible Version
  4. Install Ansible Community General Collection
  5. Create hosts file under ./ (./hostss)
  6. Move hostss file to /etc/ansible/hosts
  7. Add host key checking defaults in /etc/ansible/ansible.cfg
  8. Run Ansible playbook according to the environment set by the CLI command

## Playbook tasks
  1. Install curl & Git packages
  2. Download NodeJS 14.X Source
  3. Install NodeJS
  4. Clone the Webapp repo from github
  5. Copy ENV file to WebApp's repo with a **hidden attribute** (.env)
  6. Create an entry in crontab
  7. Install WebApp JS Package
  8. Initalize App's Database
  9. Reboot remote servers
  
## Installation
  - Clone this Repo and Navigate to the environment
  - Make sure you're on the right **workspace**
  - Apply the IAC using terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
  - Edit IP address and other relevant details in the env file (depending on the environment)
  - Edit the DB & OKTA URLS in your env file
  - Add the Load Balancer IP Address to OKTA Application re-directs (https://developer.okta.com/)
  - Copy env and playbook files and script file to the controller.
  - Change script permissions using chmod +x ./fresh.sh
  *** Make sure all the files are in the same dir ***
  - Run Script according to the above information, for example: './fresh.sh -n 10 --env envfile -p playbook.yml 10.0.1.10' <br />
  - Fill the remaining promped required info missing from the arguments (if any).<br />
  - Type VM Password & Controller root password
  ***MAKE SURE THE ENV FILE DOESN'T HAVE THE . ATTRIBUTE** (Example: 'env' instead of '.env') ***<br />
  - Go get something to eat.<br />
  - When finished, open a web browser and navigate to http://<IPinENVFILE>:8080<br />

## Troubleshooting
#### Tested on Ubuntu 20.04
	* Sometimes the playbook can freeze while doing a task. usually a re-run of the script solves the issue.
	* If the playbook hangs on the database task it probably means you forgot to change the DB URL in your env file.
	* If you happen to copy the script, run it and get an interpreter error then just create a new script file and paste the contents.
	- make sure you give the new script file execution permissions. (chmod +x ./fresh.sh)

## Total files Pre-Script on Controller machine
<img src="https://i.postimg.cc/d12pvHq7/fs-pre-script.jpg"> <br />
	
## Total files Post-Script on Controller machine
<img src="https://i.postimg.cc/DyyHkPRZ/fs-post-script.jpg"> <br />

## Script Usage
<img src="https://i.postimg.cc/wBKwvX4D/usage.jpg"> <br />

### Example of Play Recap with 2 nodes <br />
<img src="https://i.postimg.cc/ncjKDsD2/recap.jpg"> <br />

### Crontab Entry
<img src="https://i.postimg.cc/MGhSY2d1/crontab-entry.jpg"> <br />

### POC of the above
<img src="https://i.postimg.cc/0NRd08sS/poc.jpg"> <br />
