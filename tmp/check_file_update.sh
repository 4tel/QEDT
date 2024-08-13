#!/bin/bash

function check_update() {
  # 현재 폴더 내 파일 정보를 저장할 변수
  file_info=$(ls -l)

  while true; do
    # 현재 폴더 내 파일 정보를 새로 가져옴
    new_file_info=$(ls -l)

    # 파일 정보가 변경되었는지 확인
    if [ "$file_info" != "$new_file_info" ]; then
      echo "파일이 업데이트되었습니다:"
      # 변경된 파일 목록 출력
      diff <(echo "$file_info") <(echo "$new_file_info") | grep '^<' | awk '{print $9}'
      # 변경된 파일 정보 업데이트
      file_info="$new_file_info"
    fi
    # 1초 간격으로 검사
    sleep 1
  done
}

check_update
