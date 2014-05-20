#!/bin/bash - 

OUTDIR=${OUTDIR:-90doc/api/}

declare -a api_dirs api_subpackages

# "api_dirs" and "api_subpackages" elements must match by position
api_dirs=( frameworks/base/core/java )
api_subpackages=( android:com )

element_count=${#api_dirs[@]}
index=0

while [[ "$index" -lt "$element_count" ]]; do
    javadoc -d ${OUTDIR} -public -sourcepath ${api_dirs[$index]} -subpackages ${api_subpackages[$index]}
    ((index++))
done
