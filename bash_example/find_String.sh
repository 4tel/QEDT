#!/bin/bash

# ${var#pattern} - Removes smallest string from the left side that matches the pattern.
# ${var##pattern} - Removes the largest string from the left side that matches the pattern.
# ${var%pattern} - Removes the smallest string from the right side that matches the pattern.
# ${var%%pattern} - Removes the largest string from the right side that matches the pattern.
foo="foo-bar-foobar"
echo ${foo#*-}   # echoes 'bar-foobar'  (Removes 'foo-' because that matches '*-')
echo ${foo##*-}  # echoes 'foobar' (Removes 'foo-bar-')
echo ${foo%-*}   # echoes 'foo-bar'
echo ${foo%%-*}  # echoes 'foo'

STR="123,456,567 5,343"
STR_ARRAY=(`echo $STR | tr "," "\n"`)
echo ${STR_ARRAY[@]}

