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

# htop
Navigation:
- F1-F10: Menu functions
- Up/Down arrows: Navigate process list
- Space: Tag a process
- k: Kill the selected process
- q: Quit

2. Alternative performance monitor, run:

# nmon
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
