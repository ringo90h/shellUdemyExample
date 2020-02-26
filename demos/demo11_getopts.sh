#!/bin/bash

# This script generates a random password.
# The user can set the password length with -l and add a special character with -s.
# Verbose mode can be enabled with -v.

usage() {
  echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.' >&2
  echo '  -l LENGTH  Specify the password length.' >&2
  echo '  -s         Append a special character to the password.' >&2
  echo '  -v         Increase verbosity.' >&2
  exit 1
}

log() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

# 기본 패스워드 길이 설정
LENGTH=48

# 셸의 인수처리 방법
while getopts vl:s OPTION
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      log 'Verbose mode on.'
      ;;
    l)
      LENGTH="${OPTARG}"
      ;;
    s)
      USE_SPECIAL_CHARACTER='true'
      ;;
    ?)
      usage
      ;;
  esac
done

echo "OPTIND: ${OPTIND}"
# 마지막 하나의 변수만 남기고 shift
shift "$(( OPTIND - 1 ))"

if [[ "${#}" -gt 0 ]]
then
  usage
fi

log 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so.
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  log 'Selecting a random special character.'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done.'
log 'Here is the password:'

# Display the password.
echo "${PASSWORD}"

exit 0
