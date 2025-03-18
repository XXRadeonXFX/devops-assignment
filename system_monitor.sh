[200~#!/bin/bash

# Create log directory if it doesn't exist
# LOG_DIR="/var/log/system_monitoring"
# mkdir -p $LOG_DIR
#
# # Define log files
# DATE=$(date +"%Y-%m-%d_%H-%M-%S")
# CPU_MEM_LOG="$LOG_DIR/cpu_memory_$DATE.log"
# DISK_LOG="$LOG_DIR/disk_usage_$DATE.log"
# PROCESS_LOG="$LOG_DIR/top_processes_$DATE.log"
#
# # Log system info header
# echo "System Monitoring Report - $(date)" | tee -a $CPU_MEM_LOG $DISK_LOG $PROCESS_LOG
# echo "=======================================" | tee -a $CPU_MEM_LOG $DISK_LOG $PROCESS_LOG
#
# # Log CPU and memory usage
# echo -e "\nCPU and Memory Usage:" >> $CPU_MEM_LOG
# echo "=======================================" >> $CPU_MEM_LOG
# echo "Memory Usage:" >> $CPU_MEM_LOG
# free -h >> $CPU_MEM_LOG
# echo -e "\nCPU Load Average:" >> $CPU_MEM_LOG
# uptime >> $CPU_MEM_LOG
# echo -e "\nCPU Usage per Core:" >> $CPU_MEM_LOG
# mpstat -P ALL >> $CPU_MEM_LOG
#
# # Log disk usage
# echo -e "\nDisk Usage Summary:" >> $DISK_LOG
# echo "=======================================" >> $DISK_LOG
# df -h >> $DISK_LOG
# echo -e "\nLargest Directories in /home:" >> $DISK_LOG
# du -h --max-depth=2 /home | sort -hr | head -10 >> $DISK_LOG
#
# # Log top processes by CPU and memory
# echo -e "\nTop 10 Processes by CPU Usage:" >> $PROCESS_LOG
# echo "=======================================" >> $PROCESS_LOG
# ps aux --sort=-%cpu | head -11 >> $PROCESS_LOG
# echo -e "\nTop 10 Processes by Memory Usage:" >> $PROCESS_LOG
# echo "=======================================" >> $PROCESS_LOG
# ps aux --sort=-%mem | head -11 >> $PROCESS_LOG
#
# echo "System monitoring completed and logged to $LOG_DIR"
