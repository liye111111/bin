for i in ~/work/*
do
if [ -d $i ]; then
#echo ">>>>>>> check $i <<<<<<<<<"
svnst=`svn st $i`
while read msg; do
lastword=${msg##*/}
match="n"

for skip in "\.classpath$" "\.settings$" "\.project$" "target" "\.log$" "\.cache$" "\.lock$"  "deploy/bin" "deploy/jbossdomain" "deploy/conf" "deploy/jboss-conf" ;do
if [[ $msg =~ $skip ]];then
	match="y"
fi
done

#echo $lastword
#echo $match

if [[ $match != "y" ]];then
	echo $msg
	#echo $lastword
fi

done <<EOF
$svnst
EOF
#read
fi
done
