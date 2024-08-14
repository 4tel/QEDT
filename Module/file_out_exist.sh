#!/bin/bash

path="$(dirname $BASH_SOURCE[0])"
source "$path/../Util/source.sh"

function check_out() {
  local file="$1"
  check_extension "$file" "in"
  local result=$?

  if [ -f $file ] && [ $result -eq 0 ];then
    local base=$(basename $file .in)
    if [ "${base}" == "input_tmp" ];then
       printf "${KRED}${file}${KNRM}\n"
    fi
    if [ ! -f ${1}/${base}.out ];then
	echo $file
    fi
  fi
}

echo "check .out is not exist."
loop_dir . "check_out" -r
