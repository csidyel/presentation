#!/bin/bash
# sysinfo.sh - A simple bash script to output some basic information about a server

# linuxinfo(){
  echo "################ System information #######################"
  echo "# Current date: $(date)"

  # Print the hostname and kernel version
  echo "# Hostname    : $(hostname)"
  echo "# OS version  : $(lsb_release -d | awk -F':\t' '{print $2}')"
  echo "# Kernel      : $(uname -r)"
  echo "# Arch        : $(uname -p)"

  # Print the CPU model and cores
  echo "# CPU         :$(cat /proc/cpuinfo | grep 'model name' | head -n 1 | cut -d ':' -f 2)"
  echo "# CPU cores   : $(cat /proc/cpuinfo | grep -c 'model name')"

  # Print the total and free memory
  echo "# RAM         : $(free -h | grep 'Mem' | awk '{print $2}')"
  echo "# RAM FREE    : $(free -h | grep 'Mem' | awk '{print $4}')"

  # Print the total and free disk space
  echo "# DISK        : $(df -h | grep '/$' | awk '{print $2}')"
  echo "# DISK FREE   : $(df -h | grep '/$' | awk '{print $4}')"
  echo "################## System information end ####################"
# }
