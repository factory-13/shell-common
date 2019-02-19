#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab API.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

token="${1}"
name="${2}"; IFS=';' read -a name <<< "${name}"
description="${3}"
namespace="${4}"
visibility="${5}"
tags="${6}"
curl="$( which curl )"
sleep="5"

case ${visibility} in
    private)
        visibility="private"
        ;;
    internal)
        visibility="internal"
        ;;
    public)
        visibility="public"
        ;;
    *)
        exit 1
        ;;
esac

for i in "${name[@]}"; do
    url="$( echo ${i} | tr '[:upper:]' '[:lower:]' )"

    ${curl}                         \
    -H "PRIVATE-TOKEN: ${token}"    \
    -X POST                         \
    "https://gitlab.com/api/v4/projects?name=${i}&path=${url}&namespace_id=${namespace}&description=${description}&visibility=${visibility}&tag_list=${tags}&initialize_with_readme=true"

    sleep ${sleep}
done
