clone() {
    local url="$1"
    local name="$2"
    local version="$3"
    # local output="${FOLDER}/${name}"
    if [[ "$version" == "last" ]];then
        echo "with last version"
        git clone --depth 1 -- "${url}" "$output"
    else
        git clone --depth 1 --branch="${version}" -- "${url}" "$output"
    fi
}

download() {
    local url="$1"
    local name="$2"
    # local output="${FOLDER}/${name}"
    local -a OPTS_WGET=(--show-progress --continue --output-document)
    wget "${OPTS_WGET[@]}" "${output}" "${url}"
    # local -a OPTS_CURL=(--fail --silent --show-error --location)
    # curl "${OPTS_CURL[@]}" "${url}" --output "${output}"
}

pkg() {
    sudo apt update
    sudo apt upgrade -y
    # xargs --arg-file="${REQUIREMENTS}" sudo apt install -y
    sudo apt remove vim vim-common vim-runtime
    sudo apt autoremove
}

download_programs() {
    local list="$1"
    local folder="$2"
    local output
    {
    read _
    while read -r method name version url dest aux;do
        echo "method:   ${method}"
        echo "name:     ${name}"
        echo "version:  ${version}"
        echo "url:      ${url}"
        echo "dest:     ${dest}"
        echo "aux:      ${aux}"
        output="${folder}/${name}"
        case "${method}" in
            download)
                download "${url}" "${output}"
            ;;
            clone)
                clone "${url}" "${name}" "${version}" "${output}"
            ;;
            apt)
                echo "apt :D"
            ;;
        esac
        echo "${name} (${?})"
    done 
    } < "${list}"
    # install docker
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
