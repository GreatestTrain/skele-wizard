#!/bin/sh

check_md5_sums() {
    ( [ -d $2 ] && cp $1 $2/md5sums ) || (echo "error: $2 is not a directory." ; return 127)
    pushd $2 > /dev/null
        md5sum -c md5sums
    popd > /dev/null
    return 0
}

main() {
    for arg in $@; do
        case $arg in
        -t=*|--target-directory=*) TARGET="${arg#*=}"
        ;;
        -m=*|--md5sums=*) MD5SUMS="${arg#*=}"
        ;;
        *) echo "error: invalid option '${arg}'"; return 1
        esac
    done

    if [ -n TARGET ] && [ -n MD5SUM ]; then
        check_md5_sums $MD5SUMS $TARGET
    else
        echo " -t= | --target-directory=     : Target directory"
        echo " -m= | --md5sums=        : File containing md5sums"
    fi
}

main $@
