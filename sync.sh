IP="10.20.142.155"
if [ $# = 1 ];then
IP=$1
fi
echo "sync script to $IP"

scp ~/bin/*.sh 4080@$IP:/home/4080/bin/
scp ~/work/svn 4080@$IP:/home/4080/work
scp ~/work/sort 4080@$IP:/home/4080/work


