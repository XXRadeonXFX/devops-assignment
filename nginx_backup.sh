#!/bin/bash
# Nginx backup script for Mike

# Set variables
BACKUP_DIR="/backups"
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="$BACKUP_DIR/nginx_backup_$DATE.tar.gz"
# BACKUP_FILE="/backups/nginx/nginx_backup_$DATE.tar.gz"
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
