#!/bin/bash

# This script demonstrates the case statement.

# if else문
if [[ "${1}" = 'start' ]]
then
  echo 'Starting.'
elif [[ "${1}" = 'stop' ]]
then
  echo 'Stopping.'
elif [[ "${1}" = 'status' ]]
then
  echo 'Status:'
else
  echo 'Supply a valid option.' >&2
  exit 1
fi


# case문
case "${1}" in
  start) echo 'Starting.' ;;
  stop) echo 'Stopping.' ;;
  status|stat|--status) echo 'Status:' ;;
  *)
    echo 'Supply a valid option.' >&2
    exit 1
    ;;
esac