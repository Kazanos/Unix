#!/bin/sh

sort "$1" > "$TMP/a"
sort "$2" > "$TMP/b"
sort "$3" > "$TMP/c"
join "$TMP/a" "$TMP/b" > "$TMP/d"
join "$TMP/c" "$TMP/d" > "$TMP/e"
cat "$TMP/e" | awk '/^./ {print $1 " " $2}'
rm "$TMP/a"
rm "$TMP/b"
rm "$TMP/c"
rm "$TMP/d"
rm "$TMP/e"
