rev=$2
if [[ ${rev:0:1} == "r" ]];then
rev=${rev:1}
fi


svn merge -r $2:HEAD $1 
