#!/bin/bash
path="$(dirname ${BASH_SOURCE[0]})"
source "${path}/source.sh" "Util"

function search_files() {
  # parse argument
  OPTIND=1
  local init=$1
  local dir="$2"
  local recur=0
  local not=0
  local search_char=""
  shift 2
  # parse options
  OPTIONS=$(getopt -o rRnh -l recursive,help -- "$@")
  eval set -- "$OPTIONS"
  while true;do
    case "$1" in
      -r|-R|--recursive) recur=1;shift 1;;
      -n) not=1;shift 1;;
      -h|--help) echo "Usage: .find [OPTION]... WORD"
		echo -e "find file that containing WORD\n"
		echo "Options:"
		echo "	-r | -R | --recursive) find files recursively";
		echo "	-n) find file tath not containing WORD";
		return;;
      --) shift 1;break;;
      *) search_char+=" $1";shift 1;return;;
    esac
  done
  shift $(( OPTIND-1 ))
  search_char="$*"
  # warning
  if [ "${search_char}" == "" ];then echo -e "${KRED}Warning: string not given${KNRM}";return; fi
  # initial comment
  if [[ $init -eq 1 ]];then
    echo -ne "Find files that containing literal word \"${KRED}${search_char}${KNRM}\" "
    if [[ $recur == 1 ]];then echo -n Recurivley;fi
    echo -e "\n"
  fi

  function file_contains() {
    local file="$1"
    if grep -q -- "$search_char" "$file";then
      if [[ $not == 0 ]];then echo "$file";fi
    else
      if [[ $not == 1 ]];then echo "$file";fi
    fi
  }
  # check file contains search string
  if [[ $recur == 1 ]];then
    loop_dirs "$dir" "file_contains" -r
  else
    for file in "$dir"/*;do
      if [ -f "$file" ];then file_contains "$file";fi
    done
  fi
}
function count_content() {
  path="$1"
  word="$2"

  echo -ne "${KGRN}File${KNRM}  : $path"
  echo -ne "${KGRN}Search${KNRM}: $word\n"

  grep -o -E "\b\w*${word}\w*" "$path" | sort | uniq -c
}

function get_size() {
  # variables
  local bSort=0
  local target='.' 
  # parse option
  OPTIONS=$(getopt -o hrR -l help,recursive -- "$@")
  eval set -- "$OPTIONS"
  set -- $(getopt -o sh -l help "$@")
  while [ -n "$1" ];do
    case "$1" in
      -s) bSort=1;;
      -h|--help) echo "Usage: .count [OPTION]... [filename] [word]"
                echo -e "count [word] in [file]\n"
                echo "Options:"
                echo "-s) [word] sort by counting";return;;
      --) shift;break;;
       *) echo -e "${KRED}${1} ${KNRM} is not an option";;
    esac
    shift
  done
  if [ "$#" -ne 0 ];then target="$1";fi
  # get size of..
  echo -e "${KCYN}Size of Files${KNRM}"
  if [ "$bSort" -ne 0 ]; then
    du -sh "$target"/* | sort -h
  else
    du -sh "$target"/*
    echo -e "\n${KCYN}Size of Directory ($target)${KNRM}"
    du -sh "$target"
  fi
}
target_func=$1
shift 1
$target_func "$@"
