#!/bin/bash

# Demonstrate the use of shift and while loops.

# 파라미터 출력
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo

# while문
while [[ true ]]
do
  echo $"{RANDOM}"
  sleep 1
done

#shift 파라미터의 맨 앞을 뺀다.
while [[ "${#}" -gt 0 ]]
do
  echo "Number of parameters: ${#}"
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  echo
  shift
done
