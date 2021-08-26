#!/usr/bin/env bash

declare GITHUB="https://github.com"
declare GITLAB="https://gitlab.com"
declare SUCKLESS="https://git.suckless.org"
declare GOOGLE="https://dl.google.com/linux/direct"
declare GOOGLE="${GOOGLE}/google-chrome-stable_current_amd64.deb"
declare TELEGRAM="https://telegram.org/dl/desktop/linux"

# declare visidata

clone() {
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
    git clone --depth 1 --branch="${tag}" -- "${url}"
    # --recurse-submodules
}

apt_install() {
    sudo apt update
    sudo apt upgrade -y
    xargs --arg-file=src/requirements.txt sudo apt install -y
    sudo apt remove vim vim-common vim-runtime
    sudo apt autoremove
}

docker_install() {
    echo "docker"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    # sudo dpkg -i *.deb
    # sudo usermod -aG docker $USER
    # newgrp docker
}

chrome_install() {
    echo "chrome"
    if [[ ! -d chrome ]];then
        mkdir chrome
    fi
    cd chrome
    wget --quiet "$GOOGLE"
    cd ..
    # sudo apt install ./*.deb -y
    # sudo apt --fix-broken install -y
}

telegram_install() {
    echo "telegram"
    if [[ -d telegram ]];then
        mkdir telegram
    fi
    cd telegram
    wget --quiet "$TELEGRAM"
    cd ..
}

programs_install() {
    local file="../src/programs.txt"
    if [[ ! -d programs ]];then
        mkdir programs
    fi
    cd programs
    while read -r origin project author tag;do
        echo "$origin"
        clone "${origin}" "${project}" "${author}" "${tag}"
    done < "$file"
}


main() {
    apt_install
    chrome_install
    telegram_install
    programs_install
    
}

main

