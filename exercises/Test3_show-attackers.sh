#!/bin/bash

# 실패한 로그인의 갯수를 출력하세요.

# Count the number of failed logins by IP address.
# If there are any IPs with over LIMIT failures, display the count, IP, and location.
yum -y install GeoIP GeoIP-data

LIMIT='10'
LOG_FILE="${1}"

# 파일 정상 여부 확인
if [[ ! -e "${LOG_FILE}" ]]
then 
  echo "Cannot open log file: ${LOG_FILE}" >&2
  exit 1
fi

# 헤더 출력
echo 'Count,IP'

# 접속 실패한 IP와 갯수를 받아서 카운트 이상이면 위치 출력
grep Failed ${LOG_FILE} | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr |  while read COUNT IP
do
  # If the number of failed attempts is greater than the limit, display count, IP, and location.
  if [[ "${COUNT}" -gt "${LIMIT}" ]]
  then
    echo "${COUNT},${IP}"
  fi
done
exit 0
