#!/bin/sh
P1="http://svn.alibaba-inc.com/repos/ali_sourcing/system/business/"
B="/branches*"
WS=`pwd`
file=$1
if [ -e $file ]
then
        for line in `cat $file`;
        do
                name=${line##$P1}
                #echo $name
                if [[ $name != $line ]];then
                        name=${name%%$B}
                        name=${name//\//-}
                        echo "$name $line"
                fi
        done
fi
