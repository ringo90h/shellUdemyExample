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
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.' >&2
   exit 1
fi

# 옵션 설정
while getopts dra OPTION
do
  case ${OPTION} in
    d) DELETE_USER='true' ;;
    r) REMOVE_OPTION='-r' ;;
    a) ARCHIVE='true' ;;
    ?) usage ;;
  esac
done

# 옵션 모두 제거 후 인자만 남김
shift "$(( OPTIND - 1 ))"

# 인자가 없다면 도움말 출력
if [[ "${#}" -lt 1 ]]
then
  usage
fi

# 인자 루프
for USERNAME in "${@}"
do
  echo "Processing user: ${USERNAME}"

  # UID가 1000 초과일 경우만 삭제 허가
  USERID=$(id -u ${USERNAME})
  if [[ "${USERID}" -lt 1000 ]]
  then
    echo "Refusing to remove the ${USERNAME} account with UID ${USERID}." >&2
    exit 1
  fi

  # 아카이빙 여부(a 옵션) 선택
  if [[ "${ARCHIVE}" = 'true' ]]
  then
    # 아카이빙 폴더 존재 여부 확인
    if [[ ! -d "${ARCHIVE_DIR}" ]]
    then
      echo "Creating ${ARCHIVE_DIR} directory."
      mkdir -p ${ARCHIVE_DIR}
      if [[ "${?}" -ne 0 ]]
      then
        echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
        exit 1
      fi
    fi

    # 아카이빙 폴더에 user의 홈 디렉토리 아카이빙
    HOME_DIR="/home/${USERNAME}"
    ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
    if [[ -d "${HOME_DIR}" ]]
    then
      echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
      tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
      if [[ "${?}" -ne 0 ]]
      then
        echo "Could not create ${ARCHIVE_FILE}." >&2
        exit 1
      fi
    else
      echo "${HOME_DIR} does not exist or is not a directory." >&2
      exit 1
    fi
  fi # END of if "${ARCHIVE}" = 'true'

  #유저 delete 활성화일 경우
  if [[ "${DELETE_USER}" = 'true' ]]
  then
    userdel ${REMOVE_OPTION} ${USERNAME}

    #정상 삭제 되었는지 확인
    if [[ "${?}" -ne 0 ]]
    then
      echo "The account ${USERNAME} was NOT deleted." >&2
      exit 1
    fi
    #정상 삭제 문구 출력
    echo "The account ${USERNAME} was deleted."
  #활성화 아닐 경우 비밀번호 만료
  else
    chage -E 0 ${USERNAME}

    #정상 확인
    if [[ "${?}" -ne 0 ]]
    then
      echo "The account ${USERNAME} was NOT disabled." >&2
      exit 1
    fi
    echo "The account ${USERNAME} was disabled."
  fi # END of if "${DELETE_USER}" = 'true'
done

exit 0
