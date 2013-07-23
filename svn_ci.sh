tmp=`mktemp -t svnci.XXXX`
source /Users/liye/bin/svn_st.sh | grep -v '?' | while read line
do
if [ ${#line} -ne 0 ] ;then
cmd="svn ci -m \"\" ${line:2}"
echo $cmd >> $tmp
fi
done

more $tmp
echo "tmp cmd file: $tmp"
chmod a+x $tmp

read -p "type \"ci\" for commit: " op 
if [[ $op == "ci" ]] ; then
echo "being commit..."
exec $tmp
echo "end commit!"
fi
