#!/bin/bash - 

TAGFILE=${TAGFILE:-cscope.files}
DIRS=${DIRS:-frameworks/base/ frameworks/native/ system/core/ bionic/ libcore/ dalvik/ art/ abi/ libnativehelper/}


rm -rf ${TAGFILE}
rm -rf build-tags-*.touch

touch ${TAGFILE}

for dir in ${DIRS}; do
    find ${dir} -type f -name '*.[ch]' -o -name '*.cpp' -o -name '*.java' >> ${TAGFILE}
done

( cscope -k -b -f cscope.out -i ${TAGFILE} && touch build-tags-cscope.touch ) &
( ctags ${TAGFILE} && touch build-tags-ctags.touch ) &
( etags ${TAGFILE} && touch build-tags-etags.touch ) &
