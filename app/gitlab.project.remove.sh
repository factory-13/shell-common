#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab API. Remove project.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

token="${1}"
id="${2}"; IFS=';' read -a id <<< "${id}"
curl="$( which curl )"
sleep="2"

for i in "${id[@]}"; do

    echo ""
    echo "--- Remove: ${i}"

    ${curl}                         \
    -H "PRIVATE-TOKEN: ${token}"    \
    -X DELETE                       \
    "https://gitlab.com/api/v4/projects/${i}"

    echo ""
    echo "--- Done: ${i}"
    echo ""

    sleep ${sleep}
done
