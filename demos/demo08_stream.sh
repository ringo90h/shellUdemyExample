#!/bin/bash

# This script demonstrates I/O redirection.

# stdout 스트림을 파일로 리다이렉트
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# 파일의 내용을 LINE 변수로 입력
read LINE < ${FILE}
echo "LINE 변수 : ${LINE}"

# stdout을 변수로 할당
head -n3 /etc/passwd > ${USERS}
echo
echo "Contents of ${USERS}:"
cat ${USERS}

# 문자열 추가하기
echo "add new user" >> ${USERS}
echo "Contents of ${USERS}:"
cat ${USERS}

# 표준 에러를 표준 출력으로 변경할 경우 2>1
# 실제로는 1을 파일명으로 인식하기 때문에 2>&1로 수정 필요
# ex) head -n1 /etc/passwd /fakefile 2>&1 | cat -n
# ex) head -n1 /etc/passwd /fakefile |& cat -n

# &> 표준, 에러 모두 리다이렉트


# Redirect STDIN to a program, using FD 0.
read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"

# stdout 리다이렉트
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# stderr 리다이렉트
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}
echo
echo "Contents of ${ERR_FILE}:"
cat ${ERR_FILE}

# stdout, stderr 동시 리다이렉트
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# stdout, stderr 동시 파이프
echo
head -n3 /etc/passwd /fakefile |& cat -n

# stdout을 stderr로 리다이렉트
echo "This is STDERR!" >&2

# stdout 제거
echo
echo "Discarding STDOUT:"
head -n3 /etc/passwd /fakefile > /dev/null

# stderr 제거
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

# 모두 제거
echo
echo "Discarding STDOUT and STDERR:"
head -n3 /etc/passwd /fakefile &> /dev/null

# Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null
