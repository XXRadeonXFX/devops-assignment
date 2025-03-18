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
