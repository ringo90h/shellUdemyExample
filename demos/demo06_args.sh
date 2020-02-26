#!/bin/bash

# This script generates a random password for each user specified on the comand line.

# 사용된 PATH 출력
# which 명령어로 조회 가능함
echo "실행된 명령어: ${0}"

# 디렉토리와 파일명 분리
echo "디렉토리: $(dirname ${0}) 
실행된 파일 명: $(basename ${0})"

# 변수의 갯수 출력
# (Inside the script they are parameters, outside they are arguments.)
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

# 최소 인자 1개 이상으로 설정하기
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi

# ${*} 전체 변수를 문자열로 변환
# ${@} 전체 변수를 배열로 변환
for USER_NAME in "${@}"
do
  PASSWORD=$(date +%s%N | sha256sum | head -c48)
  echo "${USER_NAME}: ${PASSWORD}"
done
