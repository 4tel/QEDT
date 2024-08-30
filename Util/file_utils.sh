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
    echo "	-c) print with count of containing WORD"
    echo "	-p) print with line of containing WORD"
  }
  # parse argument
  OPTIND=1
  local init=$1
  local dir="$2"
  local recur=0
  local not=0
  local ignore=0
  local count=0
  local printout=0
  local search_char=""
  shift 2
  # parse options
  local optcnt
  local option
  OPTIONS=$(getopt -o rRinhcp -l recursive,help -- "$@")
  eval set -- "$OPTIONS"
  while true;do
    case "$1" in
      -r | -R | --recursive) 
	  optcnt+=1;option1+=("-r");recur=1;shift 1;;
      -i) optcnt+=1;option2+="i";ignore=1;shift 1;;
      -n) optcnt+=1;option2+="L";not=1;shift 1;;
      -c) optcnt+=1;count=1;shift 1;;
      -p) optcnt+=1;printout=1;shift 1;;
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
  # command for each searched files
  file_info=()
  if [[ $not == 0 ]];then
    if [[ $count == 1 ]];then
      file_info+=("echo -ne \" \${KMAG}(count: \"")
      file_info+=("echo -ne \$(grep -c${option2} -- \"\$search_char\" \"\$file\")")
      file_info+=("echo -e \)\${KNRM}")
    fi
    if [[ $printout == 1 ]];then
      if [[ "$option2" == "" ]];then
        file_info+=("grep \"\$search_char\" \"\$file\"")
      else
        file_info+=("grep -${option2} \"\$search_char\" \"\$file\"")
      fi
      file_info+=("echo")
    fi
  fi
  # apply command for searched files
  function file_contains() {
    local file="$1"
    if grep -ql${option2} -- "$search_char" "$file";then
      echo -ne "${CLCL}${KBLU}${file}${KNRM}"
      for x in "${file_info[@]}";do
        eval "$x"
      done
   fi
  }
  # print for note current search directory
  function dir_print() {
    local dir="$1"
    echo -ne "${CLCL}${KCYN}search in \"${KYEL}${dir}${KCYN}\"${KNRM}"
  }
  # check file contains search string
  loop_dirs "$dir" "file_contains" "dir_print" "${option1[@]}"
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
