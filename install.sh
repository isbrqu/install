#!/usr/bin/env bash

declare GITHUB="https://github.com"
declare GITLAB="https://gitlab.com"
declare SUCKLESS="https://git.suckless.org"
declare FOLDER="tmp"
declare SRC="src"

clone() {
    local output="${FOLDER}/${project}"
    local origin="$1"
    local project="$2"
    local author="$3"
    local tag="$4"
    local url
    case "$origin" in
        github)
            url="${GITHUB}/${author}/${project}"
        ;;
        gitlab)
            url="${GITLAB}/${author}/${project}"
        ;;
        suckless)
            url="${SUCKLESS}/${project}"
        ;;
        *)
            echo "origin (${origin}) not found for ${project}" >&2
            return 1
        ;;
    esac
    git clone --quiet --depth 1 --branch="${tag}" -- "${url}" "$folder"
    echo "${project} (${?})"
    # --recurse-submodules
}

download() {
    local filename="$1"
    local url="$2"
    local output="${FOLDER}/${filename}"
    local -a OPTS_WGET=(--show-progress --continue --output-document)
    wget "${OPTS_WGET[@]}" "${output}" "${url}"
}

apt_install() {
    local file="${SRC}/requirements.txt" 
    sudo apt update
    sudo apt upgrade -y
    xargs --arg-file="${file}" sudo apt install -y
    sudo apt remove vim vim-common vim-runtime
    sudo apt autoremove
}

dowload_programs() {
    local file="${SRC}/programs.txt"
    while read -r filename url;do
        download "${filename}" "${url}"
    done < "$file"
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

clone_repositories() {
    local file="${SRC}/repositories.txt"
    while read -r origin project author tag;do
        echo "$origin"
        clone "${origin}" "${project}" "${author}" "${tag}"
    done < "$file"
}


main() {
    if [[ ! -d tmp ]];then
        mkdir tmp
    fi
    # apt_install
    dowload_programs
}

main

