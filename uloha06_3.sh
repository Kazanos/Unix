#!/bin/sh

cat /etc/group | awk -e '
BEGIN {
	FS = ","
	l=0
	i=0
	
}

{
	if (l < NF)
	{
		l=NF
		system("rm \"$TMP/a\"")
		system("touch \"$TMP/a\"")
		i=1
		a[i]=$0
	}
	else if (l == NF)
	{
		i++
		a[i]=$0
	}
}
END {
	for (j = 1; j <= i; j++)
		print a[j]
	FS = " "
}
'
