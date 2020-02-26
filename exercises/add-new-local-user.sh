#!/bin/bash

# root 유저인지 확인
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.'
   exit 1
fi

# 최소 인자 갯수 1개 이상인지 확인
if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..."
  echo 'Create an account on the local system with the name of USER_NAME and a comments field of COMMENT.'
  exit 1
fi

# 첫 번째 인자를 유저명에 할당
USER_NAME="${1}"

# 첫 번째 인자를 제거하고 나머지는 모두 comment에 할당
shift
COMMENT="${@}"

# 비밀번호 생성
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# 유저 생성
useradd -c "${COMMENT}" -m ${USER_NAME}

# 유저 정상 생성 확인
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  exit 1
fi

# 비밀번호 설정
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# 비밀번호 정상 설정 확인
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.'
  exit 1
fi

# 비밀번호 강제 만료
passwd -e ${USER_NAME}

# 출력
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
