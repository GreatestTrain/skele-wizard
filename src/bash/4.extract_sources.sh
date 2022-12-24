#!/bin/sh

extract_source_tarballs () {
    pushd $1 > /dev/null
        for item in $(ls *.tar*); do
            tar xf $item
        done
    popd > /dev/null
    return 0
}

main () {
    for arg in $@; do
        case $arg in
        -t=*|--target-directory=*) TARGET="${arg#*=}"
        ;;
        *) echo "error: invalid option '${arg}'"; return 1
        esac
    done

    if [ -n TARGET ] ; then
        extract_source_tarballs $TARGET
    else
        echo " -t= | --target-directory=     : Target directory"
    fi
}

main $@
