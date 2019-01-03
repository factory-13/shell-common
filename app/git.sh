#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------- #
# Git scripts.
# -------------------------------------------------------------------------------------------------------------------- #
# @author Kitsune Solar <kitsune.solar@gmail.com>
# @version 1.0.0
# -------------------------------------------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------------------------------------------- #
# Timestamp generator.
# -------------------------------------------------------------------------------------------------------------------- #

function ext.timestamp() {
    timestamp="$( date -u '+%Y-%m-%d %T' )"

    echo ${timestamp}
}

# -------------------------------------------------------------------------------------------------------------------- #
# Version generator.
# -------------------------------------------------------------------------------------------------------------------- #

function ext.build.version() {
    version="$( date -u '+%Y%m%d%H%M%S' )"

    echo ${version}
}

# -------------------------------------------------------------------------------------------------------------------- #
# Push.
# -------------------------------------------------------------------------------------------------------------------- #

function ext.git.push() {
    name="$( basename ${PWD} )"
    timestamp="$( ext.timestamp )"
    commit="$*"

    echo ""
    echo "--- Pushing ${name}"

    git add . && git commit -a -m "${timestamp}" -m "${commit}" && git push

    echo "--- Finished ${name}"
    echo ""
}

# -------------------------------------------------------------------------------------------------------------------- #
# Push all.
# -------------------------------------------------------------------------------------------------------------------- #

function ext.git.push.all() {
    for i in `ls`; do
        if [[ -d ${i}/.git ]]; then
            cd ${i}
            ext.git.push
            cd ..
        fi
    done
}

# -------------------------------------------------------------------------------------------------------------------- #
# Push version.
# -------------------------------------------------------------------------------------------------------------------- #

function ext.git.push.version() {
    tags="$( git tag --list )"
    changes="$(git status --porcelain)"

    if [[ -z "${changes}" ]]; then
        count="0"
    else
        count="1"
    fi

    if [[ -z "${1}" ]]; then
        if [[ -z "${tags}" ]]; then
            version="1.0.0"
        else
            tag=( $( git describe --abbrev=0 --tags | tr '.' ' ' ) )
            major=${tag[1]}
            minor=${tag[2]}
            patch=${tag[3]}
            version="${major}.${minor}.$(( ${patch} + ${count} ))"
        fi
    else
        version="${1}"
    fi

    ext.git.push && git tag -a ${version} -m "Version ${version}" && git push origin ${version}
}

# -------------------------------------------------------------------------------------------------------------------- #
# Push page.
# -------------------------------------------------------------------------------------------------------------------- #

function ext.git.push.page() {
    if [[ -z "${1}" ]]; then
        branch="page-stable"
    else
        branch="${1}"
    fi

    ext.git.push && git checkout master && git merge ${branch} && git push && git checkout ${branch}
}

# -------------------------------------------------------------------------------------------------------------------- #
# Push CDN.
# -------------------------------------------------------------------------------------------------------------------- #

function ext.git.push.cdn() {
    if [[ -z "${1}" ]]; then
        branch="cdn-stable"
    else
        branch="${1}"
    fi

    ext.git.push && git checkout master && git merge ${branch} && git push && git checkout ${branch}
}
