#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for the account name and password.

# 유저명 입력
read -p '유저 명을 입력하세요.' USER_NAME

# 이름 입력
read -p '유저의 이름을 입력하세요.' COMMENT

# 비밀번호 입력
read -p '비밀번호를 입력하세요.' PASSWORD

# 유저 생성
# 스페이스를 포함할 때는 ""로 감싼다
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user.
# NOTE: You can also use the following command:
 #    echo "${USER_NAME}:${PASSWORD}" | chpasswd
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# 패스워드 강제 만료
passwd -e ${USER_NAME}
