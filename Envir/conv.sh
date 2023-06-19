#!/bin/bash

for f in `find . -name "*.txt"`
do
    lnk=`realpath $f`
    enc=`python guess_enc.py $f`

    # echo ${lnk} : ${enc}

    iconv -f ${enc} -t utf-8 ${lnk} > ${lnk}.utf8 2>/dev/null
    if [ $? -ne 0 ]
    then
        echo "Failed: iconv -f ${enc} -t utf-8 ${lnk}"
        if [ ${enc} == "GB2312" ]
        then
            iconv -f GB18030 -t utf-8 ${lnk} > ${lnk}.utf8 2>/dev/null
            if [ $? -ne 0 ]
            then
                echo "Failed: iconv -f GB18030 -t utf-8 ${lnk}"
                continue
            fi
        fi
    fi

    mv ${lnk}.utf8 ${lnk}
    dos2unix -q ${lnk}
done
