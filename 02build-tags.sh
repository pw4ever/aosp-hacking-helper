#!/bin/bash - 

TAGFILE=${TAGFILE:-cscope.files}
DIRS=${DIRS:-frameworks/base/ frameworks/native/ system/core/ bionic/ libcore/ dalvik/ art/ abi/ libnativehelper/}


rm -rf ${TAGFILE}
rm -rf finish-*.touch

touch ${TAGFILE}

for dir in ${DIRS}; do
    find ${dir} -type f -name '*.[ch]' -o -name '*.cpp' -o -name '*.java' >> ${TAGFILE}
done

( cscope -k -b -f cscope.out -i ${TAGFILE} && touch finish-cscope.touch ) &
( ctags ${TAGFILE} && touch finish-ctags.touch ) &
( etags ${TAGFILE} && touch finish-etags.touch ) &
