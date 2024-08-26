#!/bin/bash

passDir=()
# hidden
passDir+=(".*")
# temp directory
passDir+=("tmp" "\$TMP")
# test
passDir+=("test*")
# work or output
passDir+=("work" "outdir")


passPatterns=("${passDir[@]}")
passPatterns+=("*.swp")
