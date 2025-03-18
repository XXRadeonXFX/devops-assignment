# DevOps Environment Setup Documentation

This document provides detailed instructions for setting up a development environment for two developers, Sarah and Mike, including system monitoring, user management, and backup configuration.

## Table of Contents
1. [Task 1: System Monitoring Setup](#task-1-system-monitoring-setup)
2. [Task 2: User Management and Access Control](#task-2-user-management-and-access-control)
3. [Task 3: Backup Configuration for Web Servers](#task-3-backup-configuration-for-web-servers)
4. [Final Report](#final-report)
5. [Submission Instructions](#submission-instructions)

---

## Task 1: System Monitoring Setup

### Objective
Configure a monitoring system to ensure the development environment's health, performance, and capacity planning.

### Step 1: Install Monitoring Tools
1. Log into the server as a user with sudo privileges
2. Update the package lists:
   ```bash
   sudo apt-get update
   ```
3. Install htop for interactive process monitoring:
   ```bash
   sudo apt-get install -y htop
   ```
4. Install nmon for performance monitoring (optional):
   ```bash
   sudo apt-get install -y nmon
   ```
5. Verify installations:
   ```bash
   which htop
   which nmon
   ```

### Step 2: Create a Directory for Monitoring Logs
```bash
sudo mkdir -p /var/log/system_monitoring
sudo chmod 755 /var/log/system_monitoring
```

### Step 3: Create a Metrics Collection Script
1. Create the script file:
   ```bash
   sudo nano /usr/local/bin/collect_metrics.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   # Script to collect system metrics periodically

   METRICS_LOG="/var/log/system_monitoring/system_metrics.log"
   DATE=$(date '+%Y-%m-%d %H:%M:%S')

   # Create log directory if it doesn't exist
   mkdir -p $(dirname "$METRICS_LOG")

   echo "===== System Metrics Collection: $DATE =====" >> "$METRICS_LOG"

   # Collect CPU and memory information
   echo "CPU Usage:" >> "$METRICS_LOG"
   top -bn1 | head -20 >> "$METRICS_LOG"

   echo -e "\nMemory Usage:" >> "$METRICS_LOG"
   free -h >> "$METRICS_LOG"

   echo -e "\nDisk Usage:" >> "$METRICS_LOG"
   df -h >> "$METRICS_LOG"

   # Find largest directories
   echo -e "\nLargest Directories:" >> "$METRICS_LOG"
   du -h --max-depth=2 /home | sort -hr | head -10 >> "$METRICS_LOG"

   # Identify resource-intensive processes
   echo -e "\nMost Resource-Intensive Processes:" >> "$METRICS_LOG"
   ps aux --sort=-%cpu | head -10 >> "$METRICS_LOG"

   echo -e "\n------------------------------------------------------\n" >> "$METRICS_LOG"
   ```

3. Make the script executable:
   ```bash
   sudo chmod +x /usr/local/bin/collect_metrics.sh
   ```

### Step 4: Set Up a Cron Job for Regular Metric Collection
1. Edit the crontab:
   ```bash
   sudo crontab -e
   ```
2. Add the following line to run the script every hour:
   ```
   0 * * * * /usr/local/bin/collect_metrics.sh
   ```
3. Save and exit the editor

### Step 5: Create a System Report Generator
1. Create the script file:
   ```bash
   sudo nano /usr/local/bin/generate_report.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   # Script to generate a system report

   REPORT_FILE="/var/log/system_monitoring/system_report.txt"
   DATE=$(date '+%Y-%m-%d %H:%M:%S')

   # Create report directory if it doesn't exist
   mkdir -p $(dirname "$REPORT_FILE")

   # Generate report header
   echo "==============================================" > "$REPORT_FILE"
   echo "  SYSTEM MONITORING REPORT" >> "$REPORT_FILE"
   echo "  Generated: $DATE" >> "$REPORT_FILE"
   echo "==============================================" >> "$REPORT_FILE"

   # Add CPU information
   echo -e "\n\n--- CPU USAGE ---" >> "$REPORT_FILE"
   echo -e "\nCPU Load Average (1, 5, 15 min):" >> "$REPORT_FILE"
   uptime | awk -F'load average:' '{print $2}' >> "$REPORT_FILE"

   echo -e "\nTop CPU Processes:" >> "$REPORT_FILE"
   ps aux --sort=-%cpu | head -6 >> "$REPORT_FILE"

   # Add memory information
   echo -e "\n\n--- MEMORY USAGE ---" >> "$REPORT_FILE"
   free -h >> "$REPORT_FILE"

   # Add disk usage information
   echo -e "\n\n--- DISK USAGE ---" >> "$REPORT_FILE"
   df -h >> "$REPORT_FILE"

   echo -e "\nLargest Directories:" >> "$REPORT_FILE"
   du -h --max-depth=1 /home | sort -hr | head -5 >> "$REPORT_FILE"

   # Notification of report generation
   echo "System report generated at $REPORT_FILE"
   ```

3. Make the script executable:
   ```bash
   sudo chmod +x /usr/local/bin/generate_report.sh
   ```

4. Run the script to generate a sample report:
   ```bash
   sudo /usr/local/bin/generate_report.sh
   ```

5. View the generated report:
   ```bash
   cat /var/log/system_monitoring/system_report.txt
   ```

### Step 6: Document the Monitoring Setup
Create a monitoring_setup.md file with the following information:

```markdown
# System Monitoring Setup Documentation

## Tools Installed
- htop: Interactive process viewer
- nmon: Performance monitoring tool

## Monitoring Configuration
- System metrics are collected hourly and saved to /var/log/system_monitoring/system_metrics.log
- Metrics collected include:
  - CPU usage
  - Memory usage
  - Disk usage
  - Largest directories
  - Resource-intensive processes

## How to Use the Monitoring Tools

### Interactive Monitoring
1. For real-time system monitoring, run:
   ```
   htop
   ```
   Navigation:
   - F1-F10: Menu functions
   - Up/Down arrows: Navigate process list
   - Space: Tag a process
   - k: Kill the selected process
   - q: Quit

2. Alternative performance monitor, run:
   ```
   nmon
   ```
   Navigation:
   - c: CPU statistics
   - m: Memory statistics
   - d: Disk statistics
   - q: Quit

### Command-line Monitoring
- Check disk usage: `df -h`
- Check directory sizes: `du -h --max-depth=1 /path/to/directory`
- List resource-intensive processes: `ps aux --sort=-%cpu | head -10`

### Automated Monitoring
- View collected metrics: `cat /var/log/system_monitoring/system_metrics.log`
- Generate a report on demand: `/usr/local/bin/generate_report.sh`
- View the latest report: `cat /var/log/system_monitoring/system_report.txt`
```

---

## Task 2: User Management and Access Control

### Objective
Set up user accounts and configure secure access controls for the new developers.

### Step 1: Create User Accounts
1. Create user account for Sarah:
   ```bash
   sudo useradd -m -s /bin/bash sarah
   ```
2. Set a secure password for Sarah:
   ```bash
   sudo passwd sarah
   ```
   (Enter a complex password when prompted)

3. Create user account for Mike:
   ```bash
   sudo useradd -m -s /bin/bash mike
   ```
4. Set a secure password for Mike:
   ```bash
   sudo passwd mike
   ```
   (Enter a complex password when prompted)

### Step 2: Create Workspace Directories
1. Create workspace directory for Sarah:
   ```bash
   sudo mkdir -p /home/sarah/workspace
   ```
2. Set ownership and permissions for Sarah's workspace:
   ```bash
   sudo chown sarah:sarah /home/sarah/workspace
   sudo chmod 700 /home/sarah/workspace
   ```
3. Create workspace directory for Mike:
   ```bash
   sudo mkdir -p /home/mike/workspace
   ```
4. Set ownership and permissions for Mike's workspace:
   ```bash
   sudo chown mike:mike /home/mike/workspace
   sudo chmod 700 /home/mike/workspace
   ```

### Step 3: Implement Password Expiration (30 days)
1. Set password expiration for Sarah:
   ```bash
   sudo chage -M 30 sarah
   ```
2. Set password expiration for Mike:
   ```bash
   sudo chage -M 30 mike
   ```
3. Verify password policy settings:
   ```bash
   sudo chage -l sarah
   sudo chage -l mike
   ```

### Step 4: Implement Password Complexity Requirements
1. Install necessary package for password quality enforcement:
   ```bash
   sudo apt-get install -y libpam-pwquality
   ```
2. Configure PAM for password complexity:
   ```bash
   sudo cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
   ```
3. Edit the password configuration file:
   ```bash
   sudo nano /etc/pam.d/common-password
   ```
4. Find the line containing "pam_unix.so" and add the following line before it:
   ```
   password requisite pam_pwquality.so retry=3 minlen=8 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 reject_username enforce_for_root
   ```
   (This ensures passwords must be at least 8 characters long, have at least 1 uppercase, 1 lowercase, 1 digit, and 1 special character)
5. Save and exit the editor

### Step 5: Verify Access Controls
1. Test access as Sarah:
   ```bash
   sudo su - sarah
   ls -la ~/workspace
   ```
2. Attempt to access Mike's workspace as Sarah:
   ```bash
   ls -la /home/mike/workspace
   ```
   (This should fail with "Permission denied")
3. Exit Sarah's shell:
   ```bash
   exit
   ```
4. Repeat steps 1-3 for Mike's account

### Step 6: Document User Management Setup
Create a user_management.md file with the following information:

```markdown
# User Management and Access Control Documentation

## User Accounts
- Created user accounts for Sarah and Mike
- Both accounts have been set up with secure passwords
- Each user has their own isolated workspace

## Workspace Directories
- Sarah: /home/sarah/workspace (permissions: 700)
- Mike: /home/mike/workspace (permissions: 700)
- Each directory is accessible only by its respective owner

## Password Policy
- Passwords expire every 30 days
- Password complexity requirements:
  - Minimum length: 8 characters
  - Must contain at least 1 uppercase letter
  - Must contain at least 1 lowercase letter
  - Must contain at least 1 digit
  - Must contain at least 1 special character
  - Cannot contain the username

## Access Verification
- Confirmed each user can access only their own workspace
- Verified that password expiration policy is in place
- Tested that password complexity requirements are enforced
```

---

## Task 3: Backup Configuration for Web Servers

### Objective
Configure automated backups for Sarah's Apache server and Mike's Nginx server to ensure data integrity and recovery.

### Step 1: Create the Backup Directory
```bash
sudo mkdir -p /backups
sudo chmod 755 /backups
```

### Step 2: Create Apache Backup Script for Sarah
1. Create the script file:
   ```bash
   sudo nano /home/sarah/apache_backup.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   # Apache backup script for Sarah

   # Set variables
   BACKUP_DIR="/backups"
   DATE=$(date +%Y-%m-%d)
   BACKUP_FILE="$BACKUP_DIR/apache_backup_$DATE.tar.gz"
   LOG_FILE="$BACKUP_DIR/apache_backup_$DATE.log"

   # Create log file
   echo "Apache Backup Log - $DATE" > "$LOG_FILE"
   echo "=======================================" >> "$LOG_FILE"

   # Check if Apache directories exist
   if [ ! -d "/etc/httpd" ]; then
       echo "Error: Apache config directory /etc/httpd not found!" >> "$LOG_FILE"
       # On some systems, Apache may be installed as apache2
       if [ -d "/etc/apache2" ]; then
           echo "Found alternative config at /etc/apache2, using it instead." >> "$LOG_FILE"
           APACHE_CONFIG="/etc/apache2"
       else
           echo "Apache configuration directory not found. Backup aborted." >> "$LOG_FILE"
           exit 1
       fi
   else
       APACHE_CONFIG="/etc/httpd"
   fi

   # Check document root
   if [ ! -d "/var/www/html" ]; then
       echo "Warning: Document root /var/www/html not found!" >> "$LOG_FILE"
       echo "Proceeding with configuration backup only." >> "$LOG_FILE"
       # Create backup of configuration only
       tar -czf "$BACKUP_FILE" "$APACHE_CONFIG" 2>> "$LOG_FILE"
   else
       # Create backup of both configuration and document root
       echo "Creating backup of Apache configuration and document root..." >> "$LOG_FILE"
       tar -czf "$BACKUP_FILE" "$APACHE_CONFIG" "/var/www/html" 2>> "$LOG_FILE"
   fi

   # Check if backup was successful
   if [ $? -eq 0 ]; then
       echo "Backup successfully created at $BACKUP_FILE" >> "$LOG_FILE"
       echo "Backup size: $(du -h "$BACKUP_FILE" | awk '{print $1}')" >> "$LOG_FILE"
       
       # Verify backup integrity
       echo "Verifying backup integrity..." >> "$LOG_FILE"
       echo "Backup contents:" >> "$LOG_FILE"
       tar -tvf "$BACKUP_FILE" >> "$LOG_FILE" 2>&1
       
       echo "Backup verification completed." >> "$LOG_FILE"
   else
       echo "Error: Backup creation failed!" >> "$LOG_FILE"
   fi

   echo "Backup process completed at $(date)" >> "$LOG_FILE"
   ```

3. Make the script executable:
   ```bash
   sudo chmod +x /home/sarah/apache_backup.sh
   ```

4. Change ownership of the script:
   ```bash
   sudo chown sarah:sarah /home/sarah/apache_backup.sh
   ```

### Step 3: Create Nginx Backup Script for Mike
1. Create the script file:
   ```bash
   sudo nano /home/mike/nginx_backup.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   # Nginx backup script for Mike

   # Set variables
   BACKUP_DIR="/backups"
   DATE=$(date +%Y-%m-%d)
   BACKUP_FILE="$BACKUP_DIR/nginx_backup_$DATE.tar.gz"
   LOG_FILE="$BACKUP_DIR/nginx_backup_$DATE.log"

   # Create log file
   echo "Nginx Backup Log - $DATE" > "$LOG_FILE"
   echo "=======================================" >> "$LOG_FILE"

   # Check if Nginx directories exist
   if [ ! -d "/etc/nginx" ]; then
       echo "Error: Nginx config directory /etc/nginx not found!" >> "$LOG_FILE"
       echo "Backup aborted." >> "$LOG_FILE"
       exit 1
   fi

   # Check document root
   if [ ! -d "/usr/share/nginx/html" ]; then
       echo "Warning: Document root /usr/share/nginx/html not found!" >> "$LOG_FILE"
       echo "Proceeding with configuration backup only." >> "$LOG_FILE"
       # Create backup of configuration only
       tar -czf "$BACKUP_FILE" "/etc/nginx" 2>> "$LOG_FILE"
   else
       # Create backup of both configuration and document root
       echo "Creating backup of Nginx configuration and document root..." >> "$LOG_FILE"
       tar -czf "$BACKUP_FILE" "/etc/nginx" "/usr/share/nginx/html" 2>> "$LOG_FILE"
   fi

   # Check if backup was successful
   if [ $? -eq 0 ]; then
       echo "Backup successfully created at $BACKUP_FILE" >> "$LOG_FILE"
       echo "Backup size: $(du -h "$BACKUP_FILE" | awk '{print $1}')" >> "$LOG_FILE"
       
       # Verify backup integrity
       echo "Verifying backup integrity..." >> "$LOG_FILE"
       echo "Backup contents:" >> "$LOG_FILE"
       tar -tvf "$BACKUP_FILE" >> "$LOG_FILE" 2>&1
       
       echo "Backup verification completed." >> "$LOG_FILE"
   else
       echo "Error: Backup creation failed!" >> "$LOG_FILE"
   fi

   echo "Backup process completed at $(date)" >> "$LOG_FILE"
   ```

3. Make the script executable:
   ```bash
   sudo chmod +x /home/mike/nginx_backup.sh
   ```

4. Change ownership of the script:
   ```bash
   sudo chown mike:mike /home/mike/nginx_backup.sh
   ```

### Step 4: Schedule Cron Jobs for Automated Backups
1. Set up cron job for Sarah (Apache backup):
   ```bash
   sudo -u sarah crontab -e
   ```
2. Add the following line to run the backup every Tuesday at 12:00 AM:
   ```
   0 0 * * 2 /home/sarah/apache_backup.sh
   ```
3. Save and exit the editor
4. Set up cron job for Mike (Nginx backup):
   ```bash
   sudo -u mike crontab -e
   ```
5. Add the following line to run the backup every Tuesday at 12:00 AM:
   ```
   0 0 * * 2 /home/mike/nginx_backup.sh
   ```
6. Save and exit the editor

### Step 5: Test the Backup Scripts
1. Run Sarah's Apache backup script:
   ```bash
   sudo -u sarah /home/sarah/apache_backup.sh
   ```
2. Run Mike's Nginx backup script:
   ```bash
   sudo -u mike /home/mike/nginx_backup.sh
   ```
3. Verify that the backup files and logs were created:
   ```bash
   ls -la /backups/
   ```
4. Check the content of one of the log files:
   ```bash
   cat /backups/apache_backup_$(date +%Y-%m-%d).log
   ```

### Step 6: Document the Backup Configuration
Create a backup_configuration.md file with the following information:

```markdown
# Web Server Backup Configuration Documentation

## Backup Setup Overview
- Created backup scripts for Apache (Sarah) and Nginx (Mike)
- Scheduled weekly backups for both servers (every Tuesday at 12:00 AM)
- Backup files are stored in /backups/ directory
- Backup verification is performed automatically

## Apache Backup (Sarah)
- Script location: /home/sarah/apache_backup.sh
- Backs up:
  - Apache configuration directory (/etc/httpd/ or /etc/apache2/)
  - Document root (/var/www/html/)
- Naming convention: apache_backup_YYYY-MM-DD.tar.gz
- Verification log: apache_backup_YYYY-MM-DD.log

## Nginx Backup (Mike)
- Script location: /home/mike/nginx_backup.sh
- Backs up:
  - Nginx configuration directory (/etc/nginx/)
  - Document root (/usr/share/nginx/html/)
- Naming convention: nginx_backup_YYYY-MM-DD.tar.gz
- Verification log: nginx_backup_YYYY-MM-DD.log

## Cron Jobs Configuration
- Sarah's cron job: 0 0 * * 2 /home/sarah/apache_backup.sh
- Mike's cron job: 0 0 * * 2 /home/mike/nginx_backup.sh

## Backup Verification Process
- Each backup script includes automatic verification
- The verification checks the integrity of the backup file
- A detailed log of the backup contents is generated
- Any errors during the backup process are logged
```

---

## Final Report

Create a final_report.md file that summarizes all the implementation steps:

```markdown
# DevOps Implementation Report

## Overview
This report documents the implementation of a complete DevOps environment for two developers, Sarah and Mike, including system monitoring, user management, and automated backup configurations.

## Task 1: System Monitoring Setup
### Implementation Steps
1. Installed htop and nmon for real-time monitoring
2. Set up disk usage monitoring with df and du
3. Created a metrics collection script that runs hourly
4. Implemented a system reporting tool
5. Set up proper logging for all system metrics

### Challenges and Solutions
- Challenge: Ensuring consistent logging across reboots
  Solution: Used cron jobs with appropriate system paths

- Challenge: Balancing frequency of metrics collection
  Solution: Set hourly collection to avoid excessive log growth while maintaining useful data

### Screenshots
[Include terminal screenshots showing htop running, metrics log content, and report output]

## Task 2: User Management and Access Control
### Implementation Steps
1. Created user accounts for Sarah and Mike
2. Set up isolated workspace directories with proper permissions
3. Implemented password expiration policy (30 days)
4. Configured password complexity requirements
5. Verified access controls are working correctly

### Challenges and Solutions
- Challenge: Setting up PAM for password complexity
  Solution: Used libpam-pwquality with specific configuration parameters

- Challenge: Ensuring workspace isolation
  Solution: Applied strict permissions (700) to workspace directories

### Screenshots
[Include terminal screenshots showing user creation, directory permissions, and password policy]

## Task 3: Backup Configuration for Web Servers
### Implementation Steps
1. Created backup scripts for Apache (Sarah) and Nginx (Mike)
2. Set up automatic backup scheduling via cron jobs
3. Implemented backup verification procedures
4. Configured proper logging for all backup operations
5. Tested the backup and verification process

### Challenges and Solutions
- Challenge: Handling potential missing directories
  Solution: Added checks in scripts to handle alternative paths

- Challenge: Ensuring backup integrity verification
  Solution: Implemented tar verification with detailed logging

### Screenshots
[Include terminal screenshots showing backup script execution, cron job configuration, and backup verification logs]

## Conclusion
All requirements have been successfully implemented, creating a secure, monitored, and well-maintained development environment for Sarah and Mike. The system now provides:
- Comprehensive system monitoring and reporting
- Secure user access with proper isolation
- Automated backup procedures with integrity verification

This implementation ensures that the development environment meets the organization's operational and security standards while providing the new developers with the tools they need to work effectively.
```

---

## Submission Instructions

1. Create a GitHub repository:
   ```bash
   mkdir -p ~/devops-assignment
   cd ~/devops-assignment
   
   # Copy all your scripts and documentation files here
   
   git init
   git add .
   git commit -m "Initial commit: DevOps assignment implementation"
   
   # Create a repository on GitHub.com and add it as remote
   git remote add origin https://github.com/YOUR_USERNAME/devops-assignment.git
   git push -u origin master
   ```

2. Create a submission file with your GitHub repository link:
   ```
   DevOps Assignment Submission
   
   GitHub Repository: https://github.com/YOUR_USERNAME/devops-assignment
   
   The repository contains all the scripts, documentation, and implementation details for the DevOps assignment as required.
   ```

3. Submit the file to Vlearn as instructed in the assignment.
