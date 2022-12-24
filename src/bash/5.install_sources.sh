#!/bin/sh

umask 022

install_sources () {
    for folder in $(ls -d $1/*/); do
        pushd $folder > /dev/null
            [ -f configure ] && ./configure || [ -f Makefile ] || pass
            make -j $(nproc) && make -j $(nproc) DESTDIR=$2 install || pass && echo "error: could'nt install $folder"
        popd > /dev/null
    done
}

main () {

    for arg in $@; do
        case $arg in
        -s=*|--source-directory=*) DIR="${arg#*=}"
        ;;
        -o=*|--dest-dir=*) DEST="${arg#*=}"
        ;;
        *) echo "error: invalid option '${arg}'"; return 1
        esac
    done

    if [ -n DIR ] && [ -n DEST ]; then
        install_sources $DIR $DEST
    else
        echo " -o | --out-directory     : Target directory"
        echo " -i | --input-file        : File containing links"
    fi
}

[ "$(whoami)" != "root" ] && main $@ || echo "Root usage is discouraged."
