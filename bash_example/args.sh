#!/bin/bash

printf $KGRN
echo "================="
echo "\$* : args as string"
echo "================="
printf $KNRM
# 인자들을 문자열로 취급
for x in "$*";do echo "$x";done

printf $KGRN
echo "================="
echo "\$@ : args as array"
echo "================="
printf $KNRM
# 인자들을 배열로   취급
for x in "$@";do echo "$x";done

printf $KGRN
echo "================="
echo "\$# : count of args"
echo "================="
printf $KNRM
echo $#
