#!/bin/bash

read_cpu() {
    awk '/^cpu / { idle=$5+$6; total=0; for (i=2; i<=NF; i++) total+=$i; print total, idle; exit }' /proc/stat
}

read total1 idle1 < <(read_cpu)
sleep 1
read total2 idle2 < <(read_cpu)

delta_total=$((total2 - total1))
delta_idle=$((idle2 - idle1))
if ((delta_total > 0)); then
    cpu_usage=$(awk -v total="$delta_total" -v idle="$delta_idle" 'BEGIN { printf "%.1f%%", (total-idle)*100/total }')
else
    cpu_usage="Unknown"
fi

echo "CPU usage: $cpu_usage"
echo "Memory usage:"
free -h | awk 'NR == 1 || NR == 2'
echo "Disk usage:"
df -h / | awk 'NR == 1 || NR == 2'
echo "Uptime: $(uptime -p)"
echo "Logged-in users:"
who
echo "Running processes: $(ps -e --no-headers | wc -l)"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
