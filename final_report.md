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
