#!/bin/bash

function loop_dirs() {
  local func=$1
  local path=$2
  local passDir=("work" "tmp" "outdir" "$TMP" "test")
  for file in "$path"/*;do
    if [ -d "$file" ];then
      local pass=0
      for dir in "${passDir[@]}";do
	if [ "$(basename $file)" == "$dir" ];then
	  pass=1
	  break
	fi
      done
      if [[ $pass -eq 0 ]];then loop_dirs $func "$file";fi
    else
      $func "$file"
    fi
  done
}
function loop_dir() {
  loop_dirs "$@"
}
function get_extension() {
  local file="$1"
  echo "${file##*.}"
}
function check_extension() {
  local file="$1"
  local actual="$(get_extension $1)"
  local expected="$2"

  # empty string
  if [ -z "$file" ];then
    return 1
  # empty extension
  elif [ -z "$expected" ];then
    return 2
  # not exist
  elif [ ! -f "$file" ];then
    return 3
  # matched
  elif [ "$actual" == "$expected" ];then
    return 4
  # Like
  elif [[ "$actual" == *"$expected"* ]];then
    return 5
  else
    return 0
  fi
}

if [ "${#BASH_SOURCE[@]}" -eq 1 ];then
  function test() {
    echo $1
  }
  function extension_test() {
    local result=$(check_extension "$1" "out")
    echo $result
  }

  #loop_dirs test "$PWD"
  loop_dirs extension_test "$PWD"
fi
