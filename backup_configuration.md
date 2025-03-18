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
