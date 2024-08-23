#!/bin/bash
path="$(dirname ${BASH_SOURCE[0]})"
source "${path}/source.sh" "Util"

function search_files() {
  function help_msg() {
    echo "Usage: .find [OPTION]... WORD"
    echo "find files that containing WORD"
    echo ""
    echo "Options:"
    echo "	-r | -R | --recursive) find recursively"
    echo "	-i) ignore (upper/lower)case"
    echo "	-n) find when NOT containing WORD"
  }
  # parse argument
  OPTIND=1
  local init=$1
  local dir="$2"
  local recur=0
  local not=0
  local ignore=0
  local search_char=""
  shift 2
  # parse options
  local optcnt
  local option
  OPTIONS=$(getopt -o rRinh -l recursive,help -- "$@")
  eval set -- "$OPTIONS"
  while true;do
    case "$1" in
      -r | -R | --recursive) 
	  option1+="-r";optcnt+=1;recur=1;shift 1;;
      -i) option2+="i"; optcnt+=1;ignore=1;shift 1;;
      -n) option2+="L"; optcnt+=1;not=1;shift 1;;
      -h|--help) help_msg;return;;
      --) shift 1;break;;
      *) search_char+=" $1";shift 1;return;;
    esac
  done
  shift $(( OPTIND-1 ))
  search_char="$*"
  # warning
  if [ "${search_char}" == "" ];then 
    if [[ $optcnt -eq 0 ]];then help_msg
    else echo -e "${KRED}Warning: string not given${KNRM}";fi
    return
  fi
  # initial comment
  if [[ $init -eq 1 ]];then
    echo -n "Find files that "
    if [[ $not == 1 ]];then echo -ne "${KRED}NOT ${KNRM}";fi
    echo -ne "containing literal word \"${KRED}${search_char}${KNRM}\" "
    if [[ $recur == 1 ]];then echo -n Recurivley;fi
    if [[ $ignore == 1 ]];then echo -e "\n\twith ignore case distinct";fi
    echo -e "\n"
  fi

  function file_contains() {
    local file="$1"
    if [[ $not == 1 ]];then
      grep "-l${option2}" -- "$search_char" "$file"
    else
      while read target;do
	echo -e "${CLCL}${target} (count: $(grep -c -- "$search_char" "$target"))"
      done < <(grep "-l${option2}" -- "$search_char" "$file")
    fi
  }
  function dir_print() {
    local dir="$1"
    echo -ne "${CLCL}${KCYN}search in \"${KYEL}${dir}${KCYN}\"${KNRM}"
  }
  # check file contains search string
  loop_dirs "$dir" "file_contains" "dir_print" "${option1}"
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
