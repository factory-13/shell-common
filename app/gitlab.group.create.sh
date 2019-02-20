#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab API. Create group.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

token="${1}"
name="${2}"; IFS=';' read -a name <<< "${name}"
description="${3}"
visibility="${4}"
parent="${5}"

curl="$( which curl )"
ver="4"
sleep="2"

if (( ! ${#name[@]} )) && [[ -z "${parent}" ]]; then exit 1; fi

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
    "https://gitlab.com/api/v${ver}/groups?name=${i}&path=${url}&description=${description}&visibility=${visibility}&parent_id=${parent}"

    echo ""
    echo "--- Done: ${i}"
    echo ""

    sleep ${sleep}
done

exit 0
