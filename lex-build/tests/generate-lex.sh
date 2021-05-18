#!/bin/bash

function main
{
	pushd $(dirname $(realpath $0))

	generate_c bsearch
	generate_c ifs
	generate_awk
	
	popd
}

function generate_c
{
	awk -f ../lex-first.awk -f ../lex_lib.awk input.txt |
	awk -f ../lex-c.awk -vKeywords="$1" -f ../lex_lib.awk |
	awk -vType="$1" '/<lex_header>/, /<\/lex_header>/ {print $0 > "./c/lex.h"}
	/<lex_source>/, /<\/lex_source>/ {print $0 > sprintf("./c/lex_%s.c", Type)}'
}

function generate_awk
{
	awk -f ../lex-first.awk -f ../lex_lib.awk input.txt |
	awk -f ../lex-awk.awk -f ../lex_lib.awk > ./awk/inc_lex.awk
}

main "$@"
