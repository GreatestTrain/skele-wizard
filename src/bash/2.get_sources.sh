#!/bin/sh

get_sources() {
    while read url; do
        NAME=$(basename $url)
        wget --quiet --continue $url --directory-prefix $2 && echo "SUCCESS: '${NAME}' downloaded" || echo "FAILED: '${NAME}'"
    done <$1
}

main() {
    for arg in $@; do
        case $arg in
        -o=*|--out-directory=*) OUT="${arg#*=}"
        ;;
        -i=*|--input-file=*) LIST="${arg#*=}"
        ;;
        *) echo "error: invalid option '${arg}'"; return 1
        esac
    done

    if [ -n OUT ] && [ -n LIST ]; then
        get_sources $LIST $OUT
    else
        echo " -o | --out-directory     : Target directory"
        echo " -i | --input-file        : File containing links"
    fi
}

main $@
