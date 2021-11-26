#!/usr/bin/env bash

source src/util.sh

main() {
    local SRC="src"
    local FOLDER="$(mktemp --directory)"
    local LIST="${SRC}/programs.tsv"
    download_programs "${LIST}" "${FOLDER}"
}

main "${@}"

