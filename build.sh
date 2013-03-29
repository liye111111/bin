#!/bin/bash

#�����һ�������Ƿ�ִ�гɹ�
ok(){
if [ $? -ne 0 ]; then
echo -e "\033[31mbad commend: \"$1\" dir: \"$2\" \033[0m"
exit
fi
}

#������Ϣ
alert(){
echo -e "\033[31m$1 \033[0m"
}

#��ʾ��Ϣ
info(){
echo -e "\033[32m$1 \033[0m"
}

#ִ��svn����
rsvn(){
echo "svn command: $1"
$1
ok 
}


#�����ж�
P1="http://svn.alibaba-inc.com/repos/ali_sourcing/system/business/"
B="/branches*"
WS=`pwd`

file="svn"
sfile="sort"

if [ $# -eq 2 ]; then
	file=$1
	sfile=$2
fi

update(){
#����֧�ļ��Ƿ����
if [ -e $file ]
then
	echo "build with $file"
#���д���
	for line in `cat $file`; 
	do  
		echo "process $line"
		name=${line##$P1}
		#echo $name
#������businessǰ׺ƥ�䣬����		
		if [ $name = $line ] 
		then
			alert "ignore $line"
#����		
		else
#ȥ����׺
			name=${name%%$B}
			name=${name//\//-}
			echo $name
			dir="$WS/$name"
			echo "check $dir"
			cmd=""
#�Ѵ��ڣ�����switch			
			if [ -d $dir ] 
			then
				cmd="svn sw $line $dir"
#�����ڣ�����checkout		
			else
				cmd="svn co $line $dir"
			fi
			rsvn "$cmd"
		
		fi
	echo ">>>>>>>>> complete <<<<<<<<<<<"
	done
else
	echo "svn branch file not exist"
fi
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
		fi
	done
else
	echo "complie sort file not exist"
fi
}


#��ʾ��Ϣ
echo "1. all"
echo "2. svn update"
echo "3. build"
read input
 
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
