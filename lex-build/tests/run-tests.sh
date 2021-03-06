#!/bin/bash

readonly G_TEST_CASES="base_case shuffled error"

# <misc>
function make_input_name { echo "./test-data/${1}.txt"; }
function make_accept_name { echo "./test-accept/${1}_accept.txt"; }

function run_tests_on_single_file
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

function run_tests_on_multiple_files
{
	local L_EXEC="$@"
	local L_INPUT=""
	local L_ACCEPT=""
	
	for test in $G_TEST_CASES; do
		L_INPUT="$(make_input_name $test)"
		L_ACCEPT="$(make_accept_name $test)"	
		eval_success "diff <($L_EXEC $L_INPUT $L_INPUT) "\
		"<(cat $L_ACCEPT $L_ACCEPT)"
	done
}

function run_test_version_info
{
	local L_LEX="../$1"
	local L_VER="$2"
	eval_success "diff <(awk -f ../lex_lib.awk -f $L_LEX -vVersion=1) "\
	"<(echo \"$L_VER\")"
}
function run_test_lex_lib_inc
{
	local L_LEX="../$1"
	eval_success "awk -f $L_LEX 2>&1 | grep lex_lib_is_included > /dev/null"
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
function awk_test_ver
{
	run_test_version_info "lex-awk.awk" "lex-awk.awk 1.3"
}
function awk_test_lex_lib_inc
{
	run_test_lex_lib_inc "lex-awk.awk"
}
function awk_run_test
{
	local L_LEX="awk -f ./awk/lex.awk -f ./awk/inc_lex.awk"
	local L_LEX_PREF="awk -f ./awk/foo-lex.awk -f ./awk/foo_inc_lex.awk"
	for lexer in $G_C_LEXERS; do
		bt_eval run_tests_on_single_file "$L_LEX"
		bt_eval run_tests_on_multiple_files "$L_LEX"
		bt_eval run_tests_on_single_file "$L_LEX_PREF"
		bt_eval run_tests_on_multiple_files "$L_LEX_PREF"
	done
}
function test_awk
{
	bt_eval awk_test_lex_lib_inc
	bt_eval awk_test_ver
	bt_eval awk_run_test
}
# </awk>

# <C>
function c_clean { bt_eval "rm *lex_*.bin"; }

readonly G_C_LEXERS="lex_bsearch lex_ifs foo_lex_bsearch foo_lex_ifs"
function c_compile_lex
{
	local L_LEX_NO_FOO="lex_bsearch lex_ifs"
	local L_LEX_FOO="foo_lex_bsearch foo_lex_ifs"
	
	for lexer in $L_LEX_NO_FOO; do
		eval_success "gcc ./c/${lexer}.c ./c/lex_main.c -o ${lexer}0.bin -Wall"
		eval_success \
			"gcc ./c/${lexer}.c ./c/lex_main.c -o ${lexer}3.bin -Wall -O3"
		eval_success \
			"gcc ./c/${lexer}.c ./c/unit_test.c -o ${lexer}_unit_test.bin -Wall"
	done

	for lexer in $L_LEX_FOO; do
		eval_success \
			"gcc ./c/${lexer}.c ./c/foo_lex_main.c -o ${lexer}0.bin -Wall"
		eval_success \
			"gcc ./c/${lexer}.c ./c/foo_lex_main.c -o ${lexer}3.bin -Wall -O3"
		eval_success \
		"gcc ./c/${lexer}.c ./c/foo_unit_test.c -o ${lexer}_unit_test.bin -Wall"
	done
}
function c_run_tests
{
	for lexer in $G_C_LEXERS; do
		bt_eval run_tests_on_single_file "./${lexer}0.bin"
		bt_eval run_tests_on_multiple_files "./${lexer}0.bin"
		bt_eval run_tests_on_single_file "./${lexer}3.bin"
		bt_eval run_tests_on_multiple_files "./${lexer}3.bin"
		eval_success "./${lexer}_unit_test.bin"
	done
}
function c_test_lex_lib_inc
{
	run_test_lex_lib_inc "lex-c.awk"
}
function c_test_ver
{
	run_test_version_info "lex-c.awk" "lex-c.awk 1.3"
}
function c_test_kw_len
{
	local L_MSG=""
	local L_EXPECT="lex-c.awk: error: keyword 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa': length cannot be greater than 31"
	
	L_MSG="$(awk -f ../lex_lib.awk -f ../lex-first.awk input-err-lex-c-kw-len.txt | awk -f ../lex_lib.awk -f ../lex-c.awk 2>&1)"
	bt_assert_failure

	bt_diff "<(echo \"$L_MSG\")" "<(echo \"$L_EXPECT\")"
	bt_assert_success
}
function test_c
{
	bt_eval c_test_lex_lib_inc
	bt_eval c_test_ver
	bt_eval c_test_kw_len
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
