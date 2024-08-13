#!/bin/bash

directory="Files"

mkdir "${directory}"

function recursive_search_and_copy() {
  local source_dir=$1
  for file in "${source_dir}"/*; do
    if [ -f "$file" ];then
      dest_file="${directory}/${file}"
      cp "${file}" "${dest_file}"
    elif [ -d "${file}" ] && 
	[ "$(basename "${file}")" != 'work' ] && 
	[ "$(basename "${file}")" != "${directory}" ]; then
      dest_dir="${directory}/${file}"
      echo "${file}"
      mkdir -p "${dest_dir}"
      recursive_search_and_copy "${file}"
    fi
  done
}

recursive_search_and_copy .


