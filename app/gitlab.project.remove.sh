#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab API.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

token="${1}"
id="${2}"; IFS=';' read -a id <<< "${id}"
curl="$( which curl )"
sleep="5"

for i in "${id[@]}"; do
    ${curl}                         \
    -H "PRIVATE-TOKEN: ${token}"    \
    -X DELETE                       \
    "https://gitlab.com/api/v4/projects/${id}"

    sleep ${sleep}
done