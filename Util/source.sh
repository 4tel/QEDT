#!/bin/bash

util_path="$(dirname ${BASH_SOURCE[0]})"
declare -A filepath=(
	["Util"]="${util_path}/Util.sh"
	["variable"]="${util_path}/variables.sh"
)

for x in "$@";do
  file="${filepath[$x]}"
  if [ -f "$file" ];then
    source "${file}"
  else
    echo -e "Error in source \"${KBLU}${x}${KNRM}\""
    exit 1
  fi
done
