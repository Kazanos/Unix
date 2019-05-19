#!/bin/sh
if [ "$1" == "--normal" ]; then
	while [ $# != 1 ]
	do
		echo "$2"
		shift 1
	done
elif [ "$1" == "--reverse" ]; then
	i=$#
	while [ $i != 1 ] 
	do
		echo ${!i}
		i=$((i-1))
	done
elif [ "$1" == "--subst" ]; then
	i=4
	while [ $i != $(($#+1)) ]
	do
		echo ${!i//$2/$3}
		i=$((i+1))
	done
elif [ "$1" == "--len" ]; then
	for i in $@
	do
		printf "${#i} "
	done
	printf "
"
elif [ "$1" == "--help" ]; then
	echo "Pouzitie: uloha02.sh [OPTION] [args]"
	echo "--normal		vypíše všetky argumenty (vrátane --normal), každý arugment na jeden riadok"
	echo "--reverse		vypíše argumenty v opačnom poradí, ako sú na vstupe, každý na jeden riadok"
	echo "--subst		druhý argument je nejaký reťazec A a tretí je reťazec B, skript v každom ďaľšom argumente vymení všetky výskyty A na B a vypíše ich, každý na jeden riadok"
	echo "--len		vypíše na jeden riadok dĺžky všetkých argumentov, oddelený medzerami"
	echo "--help		vypíše návod na použitie tohto programu"
fi
exit 0
