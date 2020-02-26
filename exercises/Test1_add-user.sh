#!/bin/bash
#
# This script creates a new user on the local system.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.

# root 유저인지 확인
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.' >&2
   exit 1
fi

# 최소 1개 이상의 인자가 없으면 help 문구를 출력
if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
  echo 'Create an account on the local system with the name of USER_NAME and a comments field of COMMENT.' >&2
  exit 1
fi

# 첫 번째 인자를 USER_NAME 변수에 할당
USER_NAME="${1}"

# 나머지 인자는 COMMENT 변수에 할당하세요
shift
COMMENT="${@}"

# 패스워드 할당
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# 유저 생성
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

# 유저 정상 생성 확인
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.' >&2
  exit 1
fi

# 패스워드 설정
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

# 패스워드 정상 설정 확인
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.' >&2
  exit 1
fi

# 사용자 패스워드 유효기간 강제 만료
passwd -e ${USER_NAME} &> /dev/null

# username, password, hostname 출력
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
