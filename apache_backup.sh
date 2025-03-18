#!/bin/bash
# Apache backup script for Sarah

# Set variables
BACKUP_DIR="/backups"
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="$BACKUP_DIR/apache_backup_$DATE.tar.gz"
# BACKUP_FILE="/backups/apache"
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
