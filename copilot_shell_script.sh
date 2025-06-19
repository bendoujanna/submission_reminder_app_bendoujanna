#!/bin/bash

# Stop the script immediately if any command exits with a non-zero status
set -e

# Prompt the user to enter a name
read -rp "Enter your name: " username

if [[ -z "$username" ]]; then
	echo "Name cannot be empty"
	exit 1
fi

#Navigate to the user's directory
if [ ! -d "submission_reminder_${username}" ]; then
        echo "Directory submission_reminder_${username} not found. Please run create_environment.sh first"
        exit 1
fi

# Prompt the user to enter the assignment name
echo "Enter the assignment name: "
read assignment_name

cd submission_reminder_${username}

# Replace line 2 in config.env with the assignment name
sed -i "2s/.*/ASSIGNMENT=\"$assignment_name\"/" config/config.env

echo "Updated assignment to $assignment_name"
echo "Running reminder app..."

# Run the app again
bash startup.sh
