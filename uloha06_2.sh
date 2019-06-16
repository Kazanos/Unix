#!/bin/sh
IFS=':'

cat "kodyzemi_cz.csv" | awk '/"$/{FS = ";";gsub("\"", "", $4);print $4}' > "$TMP/c"
cat "countrycodes_en.csv" | awk '/^"/{FS = ";";gsub("\"", "", $1);print $1}' > "$TMP/d"

sort "$TMP/c" > "$TMP/e"
sort "$TMP/d" > "$TMP/f"

join -t: "$TMP/e" "$TMP/f"

rm "$TMP/c"
rm "$TMP/d"
rm "$TMP/e"
rm "$TMP/f"
IFS=' '
