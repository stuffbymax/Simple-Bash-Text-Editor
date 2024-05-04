#!/bin/bash

# Function to display system information
display_system_info() {
    echo "System Information:"
    echo "Hostname: $(hostname)"
    echo "Kernel version: $(uname -r)"
    echo "CPU: $(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | xargs)"
    echo "Memory: $(free -h | awk '/^Mem/ {print $2}')"
    echo "Disk usage: $(df -h | awk '$NF=="/"{printf "%s/%s (%s)\n", $3,$2,$5}')"
    echo "Uptime: $(uptime -p)"
}

# Call the function to display system information
display_system_info
