# Submission Reminder App
This is a shell-based application that helps identify students who haven't submitted a particular assignment. The app reads a list of students and their submission statuses from a file and reminds those who have not submitted yet.

## Project structure
submission_reminder_{yourName}/
├── app/
│ └── reminder.sh
├── modules/
│ └── functions.sh
├── config/
│ └── config.env
├── assets/
│ └── submissions.txt
└── startup.sh

### Decription 

#### create_environment.sh
-Prompts for your name 
-Creates the main directory with your name 
-Sets up the full app structure with folders and scripts 

##### copilot_shell_script.sh
-Prompts for the assignment name 
-Updates the ASSIGNMENT value to the new one
-Check who hasn't submitted the new ASSIGNMENT value in the config file 

###### How to use it 
-Run "bash create_environment" the setup to create the environment
-Run "bash copilot_shell_script.sh" to update the assignment and check submissions
