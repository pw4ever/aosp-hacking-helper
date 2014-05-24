#!/bin/bash - 

OUTDIR=${OUTDIR:-90doc/javadoc/}
TMPDIR=${TMPDIR:-/tmp/aosp-javadoc/}

api_dirs=( frameworks/base/core/java/ frameworks/base/services/java/ libcore/libdvm/src/main/java/ libcore/dalvik/src/main/java/ libcore/luni/src/main/java )
api_subpackages=android:com:dalvik:java:javax:org:sun

mkdir -p ${TMPDIR}
echo ${TMPDIR} created

for dir in "${api_dirs[@]}"; do
    cp -r ${dir}/* ${TMPDIR}
    echo ${dir} copied
done

javadoc -d ${OUTDIR} -protected -sourcepath ${TMPDIR} -subpackages ${api_subpackages}
