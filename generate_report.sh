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
