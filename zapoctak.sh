#!/bin/sh

simplifyTo(){
	 cat /proc/net/dev | while read line
        do
                echo $line | awk -e '/.*[:]/{print $1" "$2" "$3" "$10" "$11}' >> "$1"
        done
}

a="$TMP/a"
b="$TMP/b"
c="$TMP/c"
input=""

> "$a"
simplifyTo "$a"
sleep 1

while [ "$input" != "q" ]
do
	> $b
	simplifyTo $b

	join  $a $b > $c

	cat $b > $a
	
	clear
	cat $c | awk -v path="$TMP/" -e '
	BEGIN{
		printf "\033[33m" "%-8s", "Name"
		printf "\033[33m" "%-18s", "Bytes In"
		printf "\033[33m" "%-18s", "Packets In"
		printf "\033[33m" "%-18s", "Bytes Out"
		printf "\033[33m" "%-18s", "Packets Out"
		printf "\n"
	}
	!/^lo:/{
		inbytes=($6 - $2)
		inpackets=($7 - $3)
		outbytes=($8 - $4)
		outpackets=($9 - $5)
		printf "\033[32m" "%-8s", $1

		printf "\033[37m" "%-8s", inbytes
		ib=log(inbytes)/log(10)
                for(i=1;i<=10; i++)
			if(i<ib)
                        	printf "\033[35m" "|"
			else
                                printf " "

		printf "\033[37m" "%-8s", inpackets
		ip=log(inpackets)
                for(i=1;i<=10; i++)
			if(i<ip)
                        	printf "\033[36m" "|"
			else
                                printf " "

		printf "\033[37m" "%-8s", outbytes
		ob=log(outbytes)/log(10)
                for(i=1;i<=10; i++)
			if(i<ob)
                        	printf "\033[31m" "|"
			else
                                printf " "

		printf "\033[37m" "%-8s", outpackets
		op=log(outpackets)
                for(i=1;i<=10; i++)
			if(i<op)
                        	printf "\033[34m" "|"
			else
				printf " "
		
		system("touch "path$1)
		print inbytes" "inpackets" "outbytes" "outpackets >> path$1

		printf "\n"
	}
	END{
		printf "\033[37m" "" "\033[37m"
	}'

	name="eth0"
	if [ $@ > 0 ] 
	then
		name="$1"
	fi
	
	count=$(wc -l < "$TMP/$name:")

	if [ "$count" -gt 36000 ]
	then
		tail -n 18000 "$TMP/$name:" > "$TMP/$name:"
	fi

	tail -n 35 "$TMP/$name:" | awk -v name=$name -e '
	BEGIN{
		RS="~"
		printf "Showing "name" graph\n"
	}
	
	{
		for(j=10;j>0;j--){
			printf "  "

			for(i=0;i<35;i++)
				if( (log($(4*i+1))/log(10)) > j)
					printf "\033[35m" "H"
				 else
                                        printf " "
			
			printf "    "

			for(i=0;i<35;i++)
                                if( (log($(4*i+3))/log(10)) > j)
                                        printf "\033[31m" "H"
                                 else
                                        printf " "

                        printf "\n"}

		for(j=10;j>0;j--){
			printf "  "

			for(i=0;i<35;i++)
                                if( (log($(4*i+2))) > j)
                                        printf "\033[36m" "H"
                                else
                                        printf " "
			
			printf "    "

                        for(i=0;i<35;i++)
                                if( (log($(4*i+4))) > j)
                                        printf "\033[34m" "H"
                                 else
                                        printf " "

                        printf "\n"}

	}

	END{
		RS="\n"
		printf "\033[37m" "" "\033[37m"
	}';
	read -r -s -n 1 -t 1 input
done
