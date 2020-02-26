#!/bin/bash

# Display the top three most visited URLs for a given web server log file.

LOG_FILE="${1}"

#-e 파일이 있으면 참
if [[ ! -e "${LOG_FILE}" ]]
then
  echo "Cannot open ${LOG_FILE}" >&2
  exit 1
fi

cut -d '"' -f 2 ${LOG_FILE} | cut -d ' ' -f 2 | sort | uniq -c | sort -n | tail -3

#sed(Stream editor)

sed 's/before/after/' sample.txt
#s옵션은 전 문장을 돌며 가장 첫번째 문자에만 적용된다.

sed 's/before/after/g' sample.txt
#g옵션을 통해 전체 문장에 적용

sed 's/love/like/gw like.txt' sample.txt
#w옵션을 통해 저장

echo '/home/jason' | sed 's/\/home\/jason/\/export\/users\/jasonc/'
# 문자열 /를 작성할 때는 \를 앞에 붙여서 작성 

echo '/home/jason' | sed 's#/home/jason#/export/users/jasonc#'
#구분자 / 를 #또는 :로 바꾸면 / 그대로 사용 가능하다.

sed '/This/d' sample.txt
#This가 들어간 문자를 지운다.

sed '/^#/d ; /^$/d' sample.txt
#'#'으로 시작하는 라인을 지운 후 빈 라인을 지운다.

sed '2 s/apache/httpd/' sample.txt
#2번째 라인에만 적용

sed '1,3 s/apache/httpd/' sample.txt
#1~3번째 라인에만 적용

sed '/Group/ s/apache/httpd/' sample.txt
#조건이 맞는 라인에만 적용

sed '/#User/,/#Group/ s/apache/httpd/' sample.txt
#조건이 맞는 두 라인 사이에만 적용