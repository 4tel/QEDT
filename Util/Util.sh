#!/bin/bash
path="$(dirname ${BASH_SOURCE[0]})"
source "${path}/source.sh" variable

# print to stdout where function
function print() { echo >&2 -e "$@"; }

# loop directories
function loop_dirs() {
  # get argument
  local path=$1
  local func_file=$2
  local loop=0
  if [ "$3" == "-r" ];then
    local loop=1
    local func_dir=$4
  else
    local func_dir=$3
    if [ "$4" == "-r" ];then local loop=1;fi
  fi
  if [ "$func_dir"=="" ];then print "(NOTE:func_dir is not exists in script)";fi

  local ignore_option="$(printf '! -name %s ' ${passPattern[*]})"

  # current directory's file
  print "${KCYN}search in \"${KGRN}$(dirname ${path})${KCYN}\"${KNRM}"
  while read file;do
    $func_file "$file"
  done < <(find "$path" -maxdepth 1 -type f ${ignore_option})

  # current directory's dir
  while read dir;do
    if [ "$func_dir" != "" ];then $func_dir "$dir";fi
    # child directories
    if [[ $loop -eq 1 ]];then
      print "${KCYN}search in \"${KGRN}${dir}${KCYN}\"${KNRM}"
      while read file;do
	if [ -d "$file" ];then
	  if [ "$func_dir" != "" ];then $func_dir "$file";fi
	else
	  $func_file "$file"
	fi
      done < <(find "$dir" ${ignore_option})
    fi
  done < <(find "$path" -mindepth 1 -maxdepth 1 -type d ${ignore_option} ! -name ".")
}
function loop_dir() { loop_dirs "$@"; }

# file extension
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
  # not a file
  elif [ ! -f "$file" ];then
    return 3
  # matched
  elif [ "$actual" == "$expected" ];then
    return 4
  # Like
  elif [[ "$actual" == *"$expected"* ]];then
    return 5
  # exist but not wanted
  else
    return 0
  fi
}

if [ "${#BASH_SOURCE[@]}" -eq 1 ];then
  function extension_test() {
    check_extension "$1" "out"
    print ${KBLU} $1
    print ${KYEL}result:${KNRM} $?
  }
  print "${KBLU}test of check_extension${KNRM}"
  loop_dirs "$PWD" extension_test -r
fi
