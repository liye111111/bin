#~/bin/sh
path=$1
name=${path##*/}
echo $name
svn cat $path > $name
