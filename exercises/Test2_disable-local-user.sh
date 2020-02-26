#!/bin/bash
#
# This script disables, deletes, and/or archives users on the local system.
#

ARCHIVE_DIR='/archive'

usage() {
  # 도움말 출력
  echo "Usage: ${0} [-dra] USER [USERN]..." >&2
  echo 'Disable a local Linux account.' >&2
  echo '  -d  Deletes accounts instead of disabling them.' >&2
  echo '  -r  Removes the home directory associated with the account(s).' >&2
  echo '  -a  Creates an archive of the home directory associated with the account(s).' >&2
  exit 1
}

# root 유저인지 확인

# 옵션 설정

# 옵션 모두 제거 후 인자만 남김

# 인자가 없다면 도움말 출력

# 인자 루프

  # UID가 1000 초과일 경우만 삭제 허가

  # 아카이빙 여부(a 옵션) 선택

    # 아카이빙 폴더 존재 여부 확인

    # 아카이빙 폴더에 user의 홈 디렉토리 아카이빙

  #유저 delete 활성화일 경우

    #정상 삭제 되었는지 확인

    #정상 삭제 문구 출력

  #활성화 아닐 경우 비밀번호 만료
  
    #정상 확인
    