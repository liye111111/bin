#!/bin/bash

ok(){
	if [ $? -ne 0 ]; then
		echo -e "\033[31mbad commend: \"$1\" dir: \"$2\" \033[0m"
		exit
	fi
}

alert(){
	echo -e "\033[31m$1 \033[0m"
}

info(){
	echo -e "\033[32m$1 \033[0m"
}

rsvn(){
	echo "$1"
	$1
	ok
}


P1="http://svn.alibaba-inc.com/repos/ali_sourcing/system/business/"
B="/branches*"
WS=`pwd`

file="$WS/svn"
sfile="$WS/sort"
pfile="$WS/p_name"

if [ $# -eq 2 ]; then
	file=$1
	sfile=$2
fi

update(){
	echo "begin update"
	while read line
	do
		name=${line% *}
		url=${line#* }
		#echo $name
		#echo $url
		dir="$WS/$name"
		#echo "check $dir"
		cmd=""
		if [ -d $dir ]
		then
			cmd="svn sw $url $dir"
		else
			cmd="svn co $url $dir"
		fi
		rsvn "$cmd"
	done < $pfile

}
isHave(){
	result="false"
	while read line
	do
		name=${line%% *}
		if [[ $name == $2 ]];then
			result="true"
		fi
	done < $1
	echo $result
}


build(){
	if [ -e $sfile ]
	then
		echo "complie with $sfile"
		for line in `cat $sfile`;
		do
			if [ ${line:0:1} = "#" ]
			then
				alert "ignore $line"
			else
				isHaveName=`isHave $pfile $line`
				if [[ $isHaveName  == "true" ]];then
					echo "build $line"
					dir="$WS/$line"
					if [ -d $dir ]
					then
						cd $dir
						info "begin build: $dir"
						mvn clean install -Dmaven.test.skip
						ok "mvn clean install -Dmaven.test.skip" $dir
						mvn eclipse:eclipse
						ok "mvn eclipse:eclipse" $dir
					else
						alert "Not found $line"
					fi
					#else
					#	echo "ignore $line"
				fi
			fi
		done
	else
		echo "complie sort file not exist"
	fi
}


echo "1. all"
echo "2. svn update"
echo "3. build"
read input

svn_print_project_name.sh $file > $pfile

if [ -z $pfile ];then
	echo "svn branch file not exist"
	exit 1
fi

if [ $input -eq "2" ]
then
	update
elif [ $input -eq "3" ]
then
	build
else
	update
	build
fi
