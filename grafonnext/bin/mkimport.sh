#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function gen() {
    echo "{"
    echo "// Generated with make schemas.libsonnet"
    for VERSION in $(find schemas/* -maxdepth 0 -type d); do
        V=$(basename $VERSION)
        echo "'$V': ["
        for FILE in $(find $VERSION/* -maxdepth 0 -type f); do
            echo "import '$FILE',"
        done
        echo "],"
    done
    echo "}"
}

gen | jsonnetfmt - > schemas.libsonnet
