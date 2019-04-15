#!/bin/sh
if [ "$1" == "--typ" ]; then
	if [ -e "$2" ]; then
		str="$(ls -ld "$2")"
		str="${str:0:1}"
		if [ "$str" == "-" ]; then
			echo "subor"
		elif [ "$str" == "d" ]; then
                        echo "adresar"
		elif [ "$str" == "l" ]; then
                        echo "symbolicky link"
		elif [ "$str" == "c" ]; then
                        echo "znakove zariadenie"
		elif [ "$str" == "b" ]; then
                        echo "blokove zariadenie"
		elif [ "$str" == "s" ]; then
                        echo "soket"
		elif [ "$str" == "p" ]; then
                        echo "fifo"
		else true
		fi
	else
		echo "Subor sa nenasiel"
		exit 1
	fi
elif [ "$1" == "--help" ]; then
	echo "Pouzitie: uloha01.sh [--typ|--help] [cesta_k_suboru]"
	echo "  --typ Vypise typ zadaneho suboru"
	echo "  --help Vypise tento help"
	echo
	echo "Exit status:"
	echo "  0 program prebehol spravne"
	echo "  1 subor sa nenasiel"
else true 
fi
