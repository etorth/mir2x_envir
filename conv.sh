#!/bin/bash

if [ -d Envir.utf8 ]
then
    rm -rf Envir.utf8
fi

cp -rf Envir Envir.utf8

for f in `find Envir.utf8 -name "*.txt"`
do
    srcpath=`realpath ${f}`
    iconv -f GB18030 -t utf-8 ${srcpath} > ${srcpath}.utf8 2>/dev/null

    if [ $? -ne 0 ]
    then
        echo "Failed: iconv -f GB18030 -t utf-8 ${srcpath}"
        continue
    fi

    mv ${srcpath}.utf8 ${srcpath}

    dos2unix -q ${srcpath}
    sed -i 's/[[:space:]]\+$//' ${srcpath}
done
