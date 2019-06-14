#!/usr/bin/awk -f
BEGIN {
	RS="<"
	FS=">"
}

/^[Aa] / {
	gsub("[^<]*[Hh][Rr][Ee][Ff][^<]*=[ \n]*", "href=<", $1)
	i = index($1,"<") + 1
	if (i > 0) {
		l = substr($1,i)
		gsub("\"", "", l)
		gsub("&quot;", "\"", l)
		gsub("&lt;", "<", l)
		gsub("&gt;", ">", l)
		print l
	}
}

