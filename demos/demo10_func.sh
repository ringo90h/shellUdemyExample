#!/bin/bash

# 함수

log() {
  local VERBOSE="${1}"
  shift
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

backup_file() {
  local FILE="${1}"

  # 파일이 존재하는지 확인.
  if [[ -f "${FILE}" ]]
  then
    #파일명 지정 및 로깅
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."
    # 복사
    # -p 옵션은 메타데이터 그대로 복사
    cp -p ${FILE} ${BACKUP_FILE}
  else
    # 파일이 존재하지 않으면 1 리턴
    return 1
  fi
}

#readonly는 재할당 불가
readonly VERBOSITY='true'
log "${VERBOSITY}" 'Hello!'
log "${VERBOSITY}" 'This is fun!'

backup_file /etc/passwd
if [[ "${?}" -eq '0' ]]
then
  log 'File backup succeeded!'
else
  log 'File backup failed!'
  exit 1
fi

