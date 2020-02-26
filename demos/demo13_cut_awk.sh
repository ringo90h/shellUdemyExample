#!/bin/bash

# This script shows the open network ports on a system.
# Use -4 as an argument to limit to tcpv4 ports.

# cut -c 4-7 /etc/passwd
# 4~7번째 글자만 출력한다.

# cut -c 1,3,5 /etc/passwd
# 1,3,5번째 글자만 출력한다.

# echo -e 'one\ttwo\tthree' | cut -f 3
# echo -e 'one,two,three' | cut -d ',' -f 3

# cut -d ':' -f 1,3 /etc/passwd

# cut -d ':' -f 1,3 --output-delimiter=',' /etc/passwd

# ''내에 싱글문자밖에 허용이 안됨 -> awk를 사용한다.

# awk -F 'DATA:' '{print $2}' people.dat
# awk -F ':' '{print $1, $3}' /etc/passwd
# awk -F ':' '{print "COL1: "$1 ", COL3:" $3}' /etc/passwd
# awk -F ':' '{print $NF}' /etc/passwd <- 마지막행 출력
# awk -F ':' '{print $(NF - 1)}' /etc/passwd


# cut -d ':' -f 3 /etc/passwd | sort -n(숫자정렬)ru(중복제거)

# sudo du -h /var | sort -h(파일크키정렬)

netstat -nutl ${1} | grep : | awk '{print $4}' | awk -F':' '{print $NF}' | sort -n | uniq -c

sudo cat /var/log/messages | awk '{print $5}' | sort | uniq -c | sort -n

cat /etc/passwd | sort -t ':' -k 3 -n -r 

