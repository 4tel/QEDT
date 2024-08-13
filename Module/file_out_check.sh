#!/bin/bash

path="$(dirname $BASH_SOURCE[0])"
source "$path/../Util/source.sh"

idx=1
files=()

function print_out() {
  local file="$1"
  check_extension "$file" "out"
  local result=$?

  if [ $result -eq 0 ];then
    check1=$(grep "JOB DONE" $file -c)
    check2=$(grep "Error in routine" $file -c)
    check3=$(grep "BAD TERMINATION" $file -c)
    printf "%-50s" "${idx}. ${file} "
    if [ $check1 -ne 0 ];then
      echo "(Completed)"
    elif [ $check2 -ne 0 ];then
      echo "(Error occurred)"
    elif [ $check3 -ne 0 ];then
      echo "(JOB Killed)"
    else
      echo "(Running)"
    fi
    files+=($file)
    ((idx++))
  fi
}

if true; then
  echo "Check .out file is valid."
  loop_dir print_out .

  case $idx in
    1) 
      echo "There is no invalid .out file"
      ;;
    2)
      printf "\n\nauto $text ${files[0]}\n\n"
      $run -f "${files[0]}"
      ;;
    *)
      printf "\n\nselect what you want to ${text}\n\n"
      read -p "Choice file index: " input
      while [ "$input" -ge "$idx" ];do
	printf "Input is larger than files: ${input} > ${idx}"
	read -p "Choice file index: " input
      done
      cur=$((input - 1))
      echo "auto $text ${files[$cur]}"
      $run -f "${files[$cur]}"
      ;;
  esac
fi

