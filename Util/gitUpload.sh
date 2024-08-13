#!/bin/bash

git add -A
# get current version in commit summary
current_version=$(git log -1 --pretty=format:%s)

# /v/ : remove string 'v'
version=${current_version/v/}

# set seperator as '.'
IFS='.'

# read ${current_version/v/}, seperate by IFS and Save to major, minor, patch
read -r major minor patch <<< "${version}"

patch=$((patch+1))
new_version="v${major}.${minor}.${patch}"
echo -e "${KGRN}new version:${new_version}${KNRM}"

git commit -m "${new_version}"
git push origin tddft7.3.1v
