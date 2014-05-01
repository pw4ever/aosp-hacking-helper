#! /bin/bash

source="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
target=$(pwd)

for f in ${source}/*; do
    f=$(basename "$f")
    if echo "$f" | perl -wnle 'exit 1 unless /^\d\d/'; then
        ln -sf ${source}/$f ${target}
    fi
done
