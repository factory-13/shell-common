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
    path="${name,,}"
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

    ${curl}                         \
    -H "PRIVATE-TOKEN: ${token}"    \
    -X POST                         \
    "https://gitlab.com/api/v4/projects?name=${name}&path=${path}&namespace_id=${namespace}&description=${description}&visibility=${visibility}&tag_list=${tags}&initialize_with_readme=true"
}

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab project remove.
# -------------------------------------------------------------------------------------------------------------------- #

run.gitlab.project.remove() {
    token="${1}"
    id="${2}"
    curl="$( ext.gitlab.get.curl )"

    ${curl}                         \
    -H "PRIVATE-TOKEN: ${token}"    \
    -X DELETE                       \
    "https://gitlab.com/api/v4/projects/${id}"
}

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab group create.
# -------------------------------------------------------------------------------------------------------------------- #

run.gitlab.group.create() {
    token="${1}"
    name="${2}"
    description="${3}"
    visibility="${4}"
    parent="${5}"
    path="${name,,}"
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

    ${curl}                         \
    -H "PRIVATE-TOKEN: ${token}"    \
    -X POST                         \
    "https://gitlab.com/api/v4/groups?name=${name}&path=${path}&description=${description}&visibility=${visibility}&parent_id=${parent}"
}

# -------------------------------------------------------------------------------------------------------------------- #
# GitLab group remove.
# -------------------------------------------------------------------------------------------------------------------- #

run.gitlab.group.remove() {
    token="${1}"
    id="${2}"
    curl="$( ext.gitlab.get.curl )"

    ${curl}                         \
    -H "PRIVATE-TOKEN: ${token}"    \
    -X DELETE                       \
    "https://gitlab.com/api/v4/groups/${id}"
}
