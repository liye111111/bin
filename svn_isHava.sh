result="false"                
while read line
                do
                        name=${line%% *}
                        if [[ $name == $2 ]];then
                                result="true"
                        fi
                done < $1
echo $result
