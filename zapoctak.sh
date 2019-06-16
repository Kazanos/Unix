#!/bin/sh

simplifyTo(){
	 cat /proc/net/dev | while read line
        do
                echo $line | sed -En 's|(.*: [0-9]*).*|\1|p' >> "$1"
        done
}

a="$TMP/a"
b="$TMP/b"
c="$TMP/c"
width=(tput cols)

> "$a"
simplifyTo "$a"
sleep 1



while [ 1 ]
do
	> $b
	simplifyTo $b

	paste -d ' ' $a $b > $c

	cat $b > $a
	
	clear
	cat $c | awk -e '
	BEGIN{
		x=1
		for(i=1;i<=width;i++)
	                if( ((sqrt(x)-1)/(sqrt(10)-1)-(i-20)) <= 1 ){
				printf x
				x=x*10
				}
                	else
				printf " "
		printf "\n"
	}
	$1 != "1o"{
		x=($4 - $2)
		printf "%-15s", $1 x
		x=(sqrt(x)-1)/(sqrt(10)-1)
		for(i=0;i<x; i++)
			printf "|"
		printf "\n"
	}'

	sleep 1
done
