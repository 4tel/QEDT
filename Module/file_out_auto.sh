#!/bin/bash
path="$(dirname $BASH_SOURCE[0])"
source "$path/../Util/source.sh" "Util"

idx=1
files=()

function echoCount() {
  local char="$1"
  local file="$2"
  local out="$3"
  local check=$(grep "$char" $file -c)
  if grep -q -- "$char" $file;then
    print -n "$out"
    return 1
  fi
  return 0
}

# char_in_file / Color / notice
# KNRM / KRED / KGRN / KYEL / KBLU / KMAG / KCYN / KWHT

declare -A checkList
checkList[0,0]="Error in routine"
checkList[0,1]="$KNRM"
checkList[0,2]="Error occurred"

checkList[1,0]="BAD TERMINATION"
checkList[1,1]="$KNRM"
checkList[1,2]="JOB Killed"

checkList[2,0]="maximum number of steps"
checkList[2,1]="$KRED"
checkList[2,2]="STEP OVER"

checkList[3,0]="bfgs failed"
checkList[3,1]="$KRED"
checkList[3,2]="bfgs failed"

checkList[4,0]="convergence NOT achieved"
checkList[4,1]="$KRED"
checkList[4,2]="convergence NOT achieved"

checkList[5,0]="NOT converge"
checkList[5,1]="$KYEL"
checkList[5,2]="NOT converged"


checkList[6,0]="NOT"
checkList[6,1]="$KRED"
checkList[6,2]="NOT Converge"

checkList[7,0]="user request"
checkList[7,1]="$KGRN"
checkList[7,2]="user request"

checkList[8,0]="No converge"
checkList[8,1]="$KRED"
checkList[8,2]="NOT converged"

maxRow=$((${#checkList[@]}/3))
checkList[$maxRow,0]="JOB DONE"
checkList[$maxRow,1]="$KBLU"
checkList[$maxRow,2]="Completed"
((maxRow++))
declare -A noticeList
noticeList[0,0]="not converged"
noticeList[0,1]="$KYEL"
noticeList[0,2]="not converged"

maxNotice=$((${#noticeList[@]}/3))

function print_out() {
  local file="$1"
  check_extension "$file" "out"
  local result=$?
  if [ $result -lt 4 ];then return;fi
  if [ $result -gt 5 ];then return;fi
  if [ ! -s "$file" ];then 
	printf "${KGRN}%-40s(empty)${KNRM}\n" "${idx}. ${file}";files+=($file);((idx++));return;fi

  local Running=1
  local txt=$(printf "%-40s" "${idx}. ${file} ")
  for ((jdx=0; jdx<$maxRow; jdx++));do
    local char="${checkList[$jdx,0]}"
    local color="${checkList[$jdx,1]}"
    local notice="${checkList[$jdx,2]}"

    local out="${color}${txt}(${notice})"
    echoCount "$char" "$file" "$out"
    if [ $? -ne 0 ];then Running=0;break;fi
  done
  if [ $Running -eq 1 ];then print -n "${KGRN}${txt}(Running)";fi
  
  for ((jdx=0; jdx<$maxNotice; jdx++));do
    local char="${noticeList[$jdx,0]}"
    local color="${noticeList[$jdx,1]}"
    local notice="${noticeList[$jdx,2]}"
    local out="${color} (${notice})"
    echoCount "$char" "$file" "$out"
  done
  print "${KNRM}"
  mTime=$(stat -c %y $file)
  fTime=$(date -d "$mTime" +"%y-%m-%d(%a) %T")
  print "    $fTime"
  files+=($file)
  ((idx++))
}

if true; then
  # run
  print "Check .out file is valid."
  loop_dir . "print_out" -r
  # check result
  case $idx in
    1) 
      print "There is no invalid .out file"
      exit 1;
      ;;
    2)
      cur=0
      ;;
    *)
      print "\n\nselect what you want to ${text}\n"
      read -p "Choice file index: " input
      while [ "$input" -ge "$idx" ];do
	print "Input is larger than files: ${input} > ${idx}"
	read -p "Choice file index: " input
      done
      cur=$((input - 1))
      ;;
  esac
  # run
  print "\n\n${KMAG}${text} ${files[$cur]}${KNRM}\n"
  $run -f "${files[$cur]}"
fi

