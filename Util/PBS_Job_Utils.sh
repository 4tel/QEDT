#!/bin/bash

function job_drop() {
  job_id=$1

  # delete job
  echo -e "Job deletion requested. Job ID is \"${KMAG}${job_id}${KNRM}\""
  deletion=$(qdel $job_id 2>&1)
  ierr=$?
  case $ierr in
      # succesfully job deleted. (atleast succesfully qdel ended)
      0)
	echo -e "Trail Job state of \"${KMAG}${job_id}${KNRM}\""
	while true; do
	    output=$(qstat $job_id 2>&1)
	    oerr=$?
	    if [[ $oerr -ne 0 ]]; then
	        echo -e "Job \"${KMAG}${job_id}${KNRM}\" has been deleted."
	        break
	    fi
	    sleep 1
	done
	;;
      # illegal Job ID format given
      1)
	echo $deletion
	;;
      # Job ID not given. 
      2)
	echo $deletion
	;;
      # unknown Job ID
    153)
	echo $deletion
	;;
      *)
	echo unknown error
	echo $deletion
	;;
  esac
  exit $ierr
}

target_func=${1}
shift 1
$target_func "${@}"
