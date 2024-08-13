#!/bin/bash

# 패키지 관리자 목록
package_managers=("apt" "yum" "dnf" "zypper" "pacman")

# 유효한 패키지 관리자 찾기
for pm in "${package_managers[@]}"; do
    if command -v $pm &> /dev/null; then
        echo "유효한 패키지 관리자: $pm"
        exit 0
    fi
done

echo "유효한 패키지 관리자를 찾을 수 없습니다."
exit 1
