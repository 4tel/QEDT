#!/bin/bash

# $PWD : current path (executed path)
echo -e "${KGRN}absolute${KNRM} current path: ${KGRN}${PWD}${KNRM}"
# $0 : script file path ($1~ : arguments)
echo -e "${KMAG}relative${KNRM} script path: ${KMAG}$0${KNRM}"
# readlink : symbolic link의 연결된 경로를 가져온다.
# readlink -f : 연결된 경로를 재귀적으로 가져온다.
# (symbolic link가 다른 symbolic link를 가리키는 경우에도 사용 가능.)
echo -e "${KGRN}absolute${KNRM} script path: ${KGRN}$(readlink -f $0)${KNRM}"
# dirname
echo -e "${KMAG}relative${KNRM} script loc: ${KMAG}$(dirname $0)${KNRM}"
# absolute path of relative path
echo -e "${KGRN}absolute${KNRM} script loc: ${KGRN}$(dirname $(realpath $0))${KNRM}"

# Warning : cd may occur unexpected return
cd ..
echo -e "${KYEL}unexpected${KNRM} path: ${KYEL}$(realpath $0)${KNRM}"
