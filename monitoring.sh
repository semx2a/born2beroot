#!bin/bash
wall\
	$'\t#Architecture: '`uname -a`\
	$'\n\t#CPU physical: '`nproc`\
	$'\n\t#vCPU: '`grep "^processor" /proc/cpuinfo | wc -l`\
	$'\n\t#Memory Usage: '`free -m | grep Mem | awk '{printf "%s/%sMB (%.2f%%)", $3, $2, $3*100/$2}'`\
	$'\n\t#Disk Usage: '`df -H --total | tail -1 | awk '{printf "%d/%dGB (%s)", $3,$2,$5}'`\
	$'\n\t#CPU load: '`echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%"`\
	$'\n\t#Last boot: '`who -b | cut -c23-`\
	$'\n\t#LVM use: '`cat /proc/mounts | grep 'dev/mapper' | wc -l | awk '{if ($1 > 0) print "yes"; else print "no"}'`\
	$'\n\t#Connexions TCP: '`netstat -an | grep ESTABLISHED | wc -l && echo ESTABLISHED`\
	$'\n\t#User log: '`who | wc -l`\
	$'\n\t#Network: IP '`hostname -I` `ip addr | grep link/ether | awk '{print "(" $2 ")"}'`\
	$'\n\t#Sudo: '`cat /var/log/auth.log | grep -a sudo | grep -a COMMAND | wc -l && echo cmd`
