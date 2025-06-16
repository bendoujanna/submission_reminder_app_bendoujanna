#!/bin/bash

# Prompt for the username
echo "Enter your name: "
read username

if [[ -z "$username" ]]; then
        echo "Name cannot be empty."
        exit 1
fi

# Define variables
mainDir="submission_reminder_${username}"

if [[ -d "$mainDir" ]]; then
        echo "The directory $mainDir already exists. Please enter another name"
        exit 1
fi

# Create the main directory and the subdirectories
mkdir -p "$mainDir"/app \
         "$mainDir"/modules \
         "$mainDir"/assets \
         "$mainDir"/config

cd submission_reminder_${username}

# Create the required files and put each file in its proper folder

# Create the first file (reminder.sh)
cat > app/reminder.sh << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Creating the second file (functions.sh)
cat > modules/functions.sh << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Create the third file (submissions.txt)
cat > assets/submissions.txt << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Janna, Git, not submitted
Isabella, Shell Basics, not submitted
Grace, shell Navigation, submitted
Jeremiah, Git, submitted
Chavez, Shell Basics, not submitted
Erica, Shell Navigation, submitted
Abigael, Git, not submitted
Sharon, Shell Basics, submitted
Oumar, Shell Navigation, not submitted
Joel, Git, submitted
Diana, Shell Basics, not submitted
EOF

# Create the last file (config.env)
cat > config/config.env << 'EOF'
# This is the config file
ASSIGNMENT="Git"
DAYS_REMAINING=2
EOF

# Create the startup.sh file
cat > startup.sh << 'EOF'
#!/bin/bash
./app/reminder.sh
EOF

# Make the files executable
find . -name "*.sh" -exec chmod +x {} \;
