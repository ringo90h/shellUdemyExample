#!/bin/bash

# 유저 삭제

# root 권한 확인
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.' >&2
   exit 1
fi

# 첫 번째 파라미터로 삭제할 유저명 받음
USER="${1}"

# 유저 삭제
userdel ${USER}

# 정상처리되었는지 확인
if [[ "${?}" -ne 0 ]]
then
  echo "The account ${USER} was NOT deleted." >&2
  exit 1
fi

# 결과 출력
echo "The account ${USER} was deleted."

exit 0
