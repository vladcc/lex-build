#!/bin/bash

function main
{
	pushd $(dirname $(realpath $0))
	
	if [ "$1" = "awk" ]; then
		generate_awk
    else
		generate_c "$1"
	fi
	
	popd
}

function generate_awk
{
	awk -f ../lex-first.awk -f ../lex_lib.awk lex.txt |
	awk -f ../lex-awk.awk -f ../lex_lib.awk > ./awk/inc_lex.awk
}

function generate_c
{
	awk -f ../lex-first.awk -f ../lex_lib.awk lex.txt |
	awk -f ../lex-c.awk -vKeywords="$1" -f ../lex_lib.awk |
	awk -vType="$1" '/<lex_header>/, /<\/lex_header>/ {print $0 > "./lex.h"}
	/<lex_source>/, /<\/lex_source>/ {print $0 > sprintf("./lex_%s.c", Type)}'
}

main "$@"
