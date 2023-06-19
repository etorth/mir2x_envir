#!/bin/bash

for f in `find . -name "*.txt"`
do
    lnk=`realpath $f`
    enc=`python guess_enc.py $f`

    # echo ${lnk} : ${enc}

    iconv -f ${enc} -t utf-8 ${lnk} > ${lnk}.utf8
    if [ $? -ne 0 ]
    then
        echo "Failed: iconv -f ${enc} -t utf-8 ${lnk}"
        if [ ${enc} == "GB2312" ]
        then
            echo "Try GB18030: iconv -f GB18030 -t utf-8 ${lnk}"
            iconv -f GB18030 -t utf-8 ${lnk} > ${lnk}.utf8
            if [ $? -ne 0 ]
            then
                echo "Failed again and skip: iconv -f GB18030 -t utf-8 ${lnk}"
                continue
            fi
        fi
    fi

    mv ${lnk}.utf8 ${lnk}
    dos2unix -q ${lnk}
done
