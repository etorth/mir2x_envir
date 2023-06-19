#!/bin/bash

# failed files
# Convert_Def/Market_Def/14Quest_SkeletonCave-DM002.txt
# Convert_Def/Market_Def/14Quest_ZombieCave-D404_002.txt
# Convert_Def/Market_Def/14Quest_ZombieCave-D404_002.txt
# Convert_Def/Market_Def/14Quest_ZombieCave-E402_001.txt
# Convert_Def/QuestDiary/Event/SnowBattle/Monquest/SnowMan.txt
# MonItems/毒蜘蛛61.txt
# QuestDiary/QT_TODAY/MonQuest/Dm_Numa.txt


for f in `find . -name "*.txt"`
do
    lnk=`realpath $f`
    enc=`python guess_enc.py $f`

    # echo ${lnk} : ${enc}

    iconv -f ${enc} -t utf-8 ${lnk} > ${lnk}.utf8 2>/dev/null
    if [ $? -ne 0 ]
    then
        if [ ${enc} == "GB2312" ]
        then
            iconv -f GB18030 -t utf-8 ${lnk} > ${lnk}.utf8 2>/dev/null
            if [ $? -ne 0 ]
            then
                echo "Failed: iconv -f GB18030 -t utf-8 ${lnk}"
                continue
            fi
        else
            echo "Failed: iconv -f ${enc} -t utf-8 ${lnk}"
        fi
    fi

    mv ${lnk}.utf8 ${lnk}
    dos2unix -q ${lnk}
    sed -i 's/[[:space:]]\+$//' ${lnk}
done
