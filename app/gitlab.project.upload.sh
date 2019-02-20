#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab API. Create project.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

token="${1}"
id="${2}"
file="${3}"

curl="$( which curl )"
ver="4"
sleep="2"

if [[ -z "${id}" ]] && [[ -z "${file}" ]]; then exit 1; fi

echo ""
echo "--- Upload: ${id} < ${file}"

${curl}                             \
--header "PRIVATE-TOKEN: ${token}"  \
--request POST                      \
--form "file=@${file}"              \
"https://gitlab.com/api/v${ver}/projects/${id}/uploads"

echo ""
echo "--- Done: ${id} < ${file}"
echo ""

sleep ${sleep}

exit 0
