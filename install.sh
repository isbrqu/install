#!/usr/bin/env bash

declare FOLDER="tmp"
declare SRC="src"
declare PROGRAMS="${SRC}/programs.txt"
declare REQUIREMENTS="${SRC}/requirements.txt" 

clone() {
    local url="$1"
    local name="$2"
    local version="$3"
    local output="${FOLDER}/${name}"
    git clone --depth 1 --branch="${version}" -- "${url}" "$output"
}

download() {
    local url="$1"
    local name="$2"
    local output="${FOLDER}/${name}"
    local -a OPTS_WGET=(--show-progress --continue --output-document)
    wget "${OPTS_WGET[@]}" "${output}" "${url}"
    # local -a OPTS_CURL=(--fail --silent --show-error --location)
    # curl "${OPTS_CURL[@]}" "${url}" --output "${output}"
}

apt_install() {
    sudo apt update
    sudo apt upgrade -y
    xargs --arg-file="${REQUIREMENTS}" sudo apt install -y
    sudo apt remove vim vim-common vim-runtime
    sudo apt autoremove
}

download_programs() {
    while read -r method name version url;do
        case "${method}" in
            download)
                download "${url}" "${name}"
            ;;
            clone)
                clone "${url}" "${name}" "${version}" 
            ;;
        esac
        echo "${name} (${?})"
    done < "${PROGRAMS}"
    # install .deb
    # sudo apt install ./*.deb -y
    # sudo apt --fix-broken install -y
    # install docker
    # sh get-docker.sh
    # or
    # sudo dpkg -i *.deb
    # sudo usermod -aG docker $USER
    # newgrp docker
}

main() {
    if [[ ! -d tmp ]];then
        mkdir tmp
    fi
    apt_install
    download_programs
}

main

