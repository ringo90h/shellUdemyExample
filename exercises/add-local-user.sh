#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
  echo "root 유저가 아닙니다."
  exit 1
fi

read -p "ID를 입력하세요" USER_NAME 

read -p "이름을 입력하세요" COMMENT

read -p "초기 비밀번호를 입력하세요." PASSWORD

useradd -c "${COMMENT}" -m ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo "유저 생성 실패, 관리자에게 문의하세요."
  exit 1
fi

echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo '패스워드 입력 오류'
  exit 1
fi

#패스워드 초기화
passwd -e ${USER_NAME}

echo "유저 생성 성공"
echo "유저 ID: ${USER_NAME}"
echo "유저명: ${COMMENT}"
echo "초기 패스워드: ${PASSWORD}"
echo "호스트명: ${HOSTNAME}"
exit 0
