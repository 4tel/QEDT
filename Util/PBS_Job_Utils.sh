#!/bin/bash

function job_drop() {
  job_id=$1

  # delete job
  echo "Job $job_id deletion requested."
  deletion=$(qdel $job_id 2>&1)
  if [[ "$deletion" == *"Unknown Job Id"* ]];then
    echo "Job $job_id is already deleted.";fi

  echo "Trail Job $job_id state"
  while true; do
      output=$(qstat $job_id 2>&1)
      if [[ "$output" == *"Unknown Job Id"* ]]; then
          echo "Job $job_id has been deleted."
          break
      fi
      sleep 1
  done
}

target_func=${1}
shift 1
$target_func "${@}"
