#!/bin/bash

# Create or clear the GPU.log file
> GPU.log

while true; do
    # Get current timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Get GPU information using nvidia-smi
    gpu_info=$(nvidia-smi)
    
    # Write to log file with timestamp
    echo "=== GPU Status at $timestamp ===" >> GPU.log
    echo "$gpu_info" >> GPU.log
    echo -e "\n" >> GPU.log
    
    # Sleep for 5 seconds before next iteration
    sleep 5
done