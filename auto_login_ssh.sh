expect "set timeout -1;
                spawn -noecho ssh -o StrictHostKeyChecking=no $2 ${@:3};
                expect *assword:*;
                send -- $1\r;
                ";
