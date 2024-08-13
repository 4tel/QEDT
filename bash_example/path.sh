#!/bin/bash

echo -e "${KMAG}relative${KNRM} script path: ${KMAG}$0${KNRM}"
echo -e "${KGRN}absolute${KNRM} script path: ${KGRN}$(readlink -f $0)${KNRM}"
echo -e "${KMAG}relative${KNRM} script location: ${KMAG}$(dirname $0)${KNRM}"
echo -e "${KGRN}absolute${KNRM} script location: ${KGRN}$(dirname $(readlink -f $0))${KNRM}"
