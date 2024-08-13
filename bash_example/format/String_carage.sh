#!/bin/bash

# 진행 상태를 표시하는 함수
show_progress() {
    for i in {1..3}; do
        # 현재 줄을 덮어쓰는 진행 상태 표시
        echo -ne "\r진행 상태: $i/3"
        sleep 1
    done
    # 진행 완료 메시지
    echo -ne "\r진행 완료!       \n"
}

# 함수 호출
show_progress

