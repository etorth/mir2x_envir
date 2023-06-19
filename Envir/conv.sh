#!/bin/bash

for f in `find . -name "*.txt"`
do
    lnk=`realpath $f`
    enc=`python guess_enc.py $f`

    echo ${lnk} : ${enc}
    iconv -f ${enc} -t utf-8 ${lnk} > ${lnk}.utf8

    mv ${lnk}.utf8 ${lnk}
done
