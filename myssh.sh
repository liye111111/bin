
IP=$1
PWD=$2
set timeout 30 

#!/usr/bin/expect 
spawn ssh $IP 
expect "password:" 
send "$PWD\r" 
interact 
