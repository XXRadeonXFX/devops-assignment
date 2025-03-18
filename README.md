# DevOps Environment Setup Assignment

## Overview

This repository contains the implementation of a DevOps assignment to set up and manage development environments for two developers, Sarah and Mike. The implementation includes system monitoring, user management and access control, and automated backup procedures.

## Repository Structure

```
.
├── README.md                      # This file
├── scripts
│   ├── monitoring                 # System monitoring scripts
│   │   ├── collect_metrics.sh     # Script to collect and log system metrics
│   │   └── generate_report.sh     # Script to generate system reports
│   ├── user_management            # User management scripts
│   │   └── user_setup.sh          # Script for user account creation and configuration
│   └── backup                     # Backup scripts
│       ├── apache_backup.sh       # Apache backup script for Sarah
│       └── nginx_backup.sh        # Nginx backup script for Mike
└── docs
    ├── monitoring_setup.md        # Documentation for system monitoring
    ├── user_management.md         # Documentation for user management
    ├── backup_configuration.md    # Documentation for backup configuration
    └── final_report.md            # Comprehensive implementation report with screenshots
```

## Implementation Summary

### Task 1: System Monitoring Setup

- Installed htop and nmon for real-time monitoring of CPU, memory, and process usage
- Set up disk usage monitoring with df and du
- Created automated scripts for collecting and logging system metrics
- Implemented a reporting structure for periodic system status reports
- Configured proper logging for all system metrics

### Task 2: User Management and Access Control

- Created user accounts for Sarah and Mike with secure passwords
- Set up isolated workspace directories with appropriate permissions:
  - `/home/sarah/workspace` (permissions: 700)
  - `/home/mike/workspace` (permissions: 700)
- Implemented password policies:
  - Password expiration after 30 days
  - Password complexity requirements (length, character types)
- Configured access controls to ensure each user can only access their own workspace

### Task 3: Backup Configuration for Web Servers

- Created backup scripts for Apache (Sarah) and Nginx (Mike) web servers
- Configured automated backups via cron jobs to run every Tuesday at 12:00 AM
- Implemented backup file naming convention: `[server]_backup_YYYY-MM-DD.tar.gz`
- Set up backup verification to ensure backup integrity
- Created proper logging for all backup operations

## Challenges and Solutions

### System Monitoring Challenges
- **Challenge**: Setting appropriate metrics collection frequency
- **Solution**: Configured hourly collection to balance data granularity with log size

### User Management Challenges
- **Challenge**: Securing isolated directories properly
- **Solution**: Applied restricted permissions (700) and verified access control effectiveness

### Backup Configuration Challenges
- **Challenge**: Permission issues with backup directory
- **Solution**: Created backup group and assigned proper permissions to allow Sarah and Mike to write to backup directories
- **Alternative Solution**: Created separate subdirectories with appropriate ownership

## Usage

### System Monitoring
- Check real-time system status: `htop` or `nmon`
- View collected metrics: `cat /var/log/system_monitoring/system_metrics.log`
- Generate a system report: `/usr/local/bin/generate_report.sh`

### User Management
- Verify user information: `sudo chage -l sarah` or `sudo chage -l mike`
- Check directory permissions: `ls -la /home/sarah/workspace`

### Backup
- Run Apache backup manually: `sudo -u sarah /home/sarah/apache_backup.sh`
- Run Nginx backup manually: `sudo -u mike /home/mike/nginx_backup.sh`
- View backup logs: Check files in `/backups/apache/` and `/backups/nginx/`

## Installation and Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/devops-assignment.git
   cd devops-assignment
   ```

2. Make scripts executable:
   ```bash
   chmod +x scripts/monitoring/*.sh
   chmod +x scripts/user_management/*.sh
   chmod +x scripts/backup/*.sh
   ```

3. Run the setup scripts as root or with sudo privileges:
   ```bash
   sudo ./scripts/monitoring/setup_monitoring.sh
   sudo ./scripts/user_management/user_setup.sh
   sudo ./scripts/backup/setup_backups.sh
   ```

## Verification

After installation, verify that:
1. System monitoring tools are installed and configured
2. User accounts are created with proper workspace permissions
3. Backup scripts are set up and cron jobs are configured
4. All logs are being properly generated

## Documentation

See the `docs` directory for detailed documentation on each component.
