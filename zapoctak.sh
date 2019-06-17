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
		printf "\033[33m" "%-20s", " " "\033[33m"
		for(i=1;i<=100000;i=(i*10)){
			x=(sqrt(i/10)-1)/(sqrt(10)-1)
			for(j=0;j<x; j++)
                                printf " "
			printf "\033[33m" "%s", i "\033[33m"
	               } 
		printf "\n"
	}
	!/^lo:/{
		x=($4 - $2)
		printf "\033[33m" "%-20s", $1 x "\033[33m"
		
		system("touch temp/"$1)
		print x > "temp/"$1

		x=(sqrt(x)-1)/(sqrt(10)-1)
		for(i=0;i<x; i++)
			printf "\033[31m" "|" "\033[31m"
		printf "\n"
	}
	END{
		printf "\033[37m" "" "\033[37m"
	}'
	
	tail -n 100 "temp/eth0:" | awk -e '
	BEGIN{
		RS="~"
	}
	
	{
		for(i=0;i<100;i++)
			if((sqrt($i)-1)/(sqrt(10)-1))
				printf "H"
			else
				printf " "

		printf "\n"
	}

	END{
		RS="\n"
	}
	'
	sleep 1
done
