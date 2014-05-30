#!/bin/bash - 

OUTDIR=${OUTDIR:-90doc/javadoc/}
TMPDIR=${TMPDIR:-/tmp/aosp-javadoc/}

declare -a base_dirs
base_dirs=( frameworks/base libcore out/target/common/obj/JAVA_LIBRARIES/framework-base_intermediates/src )

[[ -d ${OUTDIR} ]] && rm -rf ${OUTDIR}
mkdir -p ${OUTDIR}
[[ -d ${TMPDIR} ]] && rm -rf ${TMPDIR}
mkdir -p ${TMPDIR}

for dir in "${base_dirs[@]}"; do
    for d in $(find ${dir} -type d -name java -a ! -regex '.*test.*' -a ! -regex '.*java/java.*'); do
        cp -r ${d}/* ${TMPDIR}
    done
done

api_subpackages=$(find ${TMPDIR} -maxdepth 1 -mindepth 1 -type d | perl -wnl -e 'our @a; push @a, $1 if $_=~qr|/([^/]+)$|; END { our @a; print join ":", @a; } ')

javadoc -d ${OUTDIR} -protected -sourcepath ${TMPDIR} -subpackages ${api_subpackages}
