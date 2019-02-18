#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab API.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

ext.gitlab.get.curl() {
    curl="$( which curl )"

    echo "${curl}"
}

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab project create.
# -------------------------------------------------------------------------------------------------------------------- #

run.gitlab.project.create() {
    token="${1}"
    name="${2}"
    description="${3}"
    namespace="${4}"
    visibility="${5}"
    tags="${6}"
    curl="$( ext.gitlab.get.curl )"

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

    ${curl}                             \
    --header "Private-Token: ${token}"  \
    -X POST                             \
    "https://gitlab.com/api/v4/projects?name=${name}&description=${description}&namespace_id=${namespace}&visibility=${visibility}&tag_list=${tags}&initialize_with_readme=true"
}