#!/bin/bash

# This script generates a list of random passwords.

# 랜덤넘버 할당
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# 초단위로 패스워드 사용
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# 나노세컨드 단위로 패스워드 사용
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# 암호 해시화
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# An even better password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

# Append a special character to the password.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"
