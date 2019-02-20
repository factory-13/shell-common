#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab API. Create project.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

token="${1}"
name="${2}"; IFS=';' read -a name <<< "${name}"
description="${3}"
visibility="${4}"
tags="${5}"
namespace="${6}"

curl="$( which curl )"
ver="4"
sleep="2"

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

    echo ""
    echo "--- Open: ${i}"

    ${curl}                             \
    --header "PRIVATE-TOKEN: ${token}"  \
    --request POST                      \
    "https://gitlab.com/api/v${ver}/projects?name=${i}&path=${url}&namespace_id=${namespace}&description=${description}&visibility=${visibility}&tag_list=${tags}&initialize_with_readme=true"

    echo ""
    echo "--- Done: ${i}"
    echo ""

    sleep ${sleep}
done
