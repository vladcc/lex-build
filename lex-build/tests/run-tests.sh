#!/bin/bash

readonly G_TEST_CASES="base_case shuffled error"

# <misc>
function make_input_name { echo "./test-data/${1}.txt"; }
function make_accept_name { echo "./test-accept/${1}_accept.txt"; }

function run_tests_on_data
{
	local L_EXEC="$@"
	local L_INPUT=""
	local L_ACCEPT=""
	
	for test in $G_TEST_CASES; do
		L_INPUT="$(make_input_name $test)"
		L_ACCEPT="$(make_accept_name $test)"
		
		eval_success "diff <($L_EXEC $L_INPUT) $L_ACCEPT"
	done
}

function gen_lex { bt_eval "bash ./generate-lex.sh > /dev/null"; }

function eval_success
{
	bt_eval "$@"
	bt_assert_success
}

function clean_up { bt_eval c_clean; }
# </misc>

# <awk>
function test_awk
{
	for lexer in $G_C_LEXERS; do
		bt_eval run_tests_on_data "awk -f ./awk/lex.awk -f ./awk/inc_lex.awk"
	done
}
# </awk>

# <C>
function c_clean { bt_eval "rm lex_*.bin"; }

readonly G_C_LEXERS="lex_bsearch lex_ifs"
function c_compile_lex
{
	for lexer in $G_C_LEXERS; do
		eval_success "gcc ./c/${lexer}.c ./c/lex_main.c -o ${lexer}0.bin -Wall"
		eval_success \
			"gcc ./c/${lexer}.c ./c/lex_main.c -o ${lexer}3.bin -Wall -O3"
		eval_success \
			"gcc ./c/${lexer}.c ./c/unit_test.c -o ${lexer}_unit_test.bin -Wall"
	done
}

function c_run_tests
{
	for lexer in $G_C_LEXERS; do
		bt_eval run_tests_on_data "./${lexer}0.bin"
		bt_eval run_tests_on_data "./${lexer}3.bin"
		eval_success "./${lexer}_unit_test.bin"
	done
}

function test_c
{
	bt_eval c_compile_lex
	bt_eval c_run_tests
	bt_eval clean_up
}
# </C>

function test_all
{
	bt_eval gen_lex
	bt_eval test_c
	bt_eval test_awk
}

function main
{
	source "$(dirname $(realpath $0))/bashtest.sh"
	
	if [ "$#" -gt 0 ]; then
		bt_set_verbose
	fi
	
	bt_enter
	bt_eval test_all
	bt_exit_success
}

main "$@"
