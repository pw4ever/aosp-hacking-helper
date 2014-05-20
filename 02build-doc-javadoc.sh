#!/bin/bash - 

OUTDIR=${OUTDIR:-90doc/javadoc/}

declare -a api_dirs api_subpackages

# "api_dirs" and "api_subpackages" elements must match by position
api_dirs=( frameworks/base/core/java/ frameworks/base/services/java/ )
api_subpackages=( android:com com )

element_count=${#api_dirs[@]}
index=0

while [[ "$index" -lt "$element_count" ]]; do
    touch_file="build-javadoc-${api_dirs[$index]//\//_}.touch"
    ( rm -f ${touch_file}; javadoc -d ${OUTDIR} -public -sourcepath ${api_dirs[$index]} -subpackages ${api_subpackages[$index]}; touch ${touch_file} ) &
    ((index++))
done
