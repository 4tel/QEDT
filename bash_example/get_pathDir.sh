#!/bin/bash

## cur absolute path
## use default value of PWD
echo Script executed from: ${PWD}
echo Script executed from: `pwd`

## file relative path
##./Test.sh {options}
##    $0     $1, $2,...
echo Script file located in: ${dirname $0}

## file absolute path
echo Script file located in: $(realpath $0)
