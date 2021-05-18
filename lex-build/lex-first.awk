#! /usr/bin/awk -f

# Author: Vladimir Dinev
# vld.dinev@gmail.com
# 2021-05-19

# This is the first step of the lex building process. It makes sure no first
# fields of the input repeat, expands character ranges, and generates character
# classes for any symbols so the user doesn't have to type all classes by hand.

# <script>
function SCRIPT_NAME() {return "lex-first.awk"}
function SCRIPT_VERSION() {return "1.0"}
# </script>

# <misc>
function check_field_num() {
	# Makes sure input has exactly two fields.
	
	if (!is_range_word($0) && (NF != 2))
		err_quit(sprintf("2 fields expected, got %d", NF))
}

# First field of the char table can only be <char>|<char>-<char>|\<char>
function CHAR_TBL_F1() {return "^(.|.-.|\\\\.)$"}

# Regex for the <char>-<char> case.
function RANGE() {return ".-."}

function check_char_tbl_syntax() {
	# Makes sure char tbl input is one of the valid options.

	if (!is_range_word($0) && (!match($1, CHAR_TBL_F1())))
			err_quit(sprintf("first field must match '%s'", CHAR_TBL_F1()))
}
function save_char_tbl(    _i, _lo, _hi) {
	# Here char ranges are expanded; anything else is saved as is.
	
	check_char_tbl_syntax()
	if (match($1, RANGE())) {
		_lo = ch_to_n(substr($1, 1, 1))
		_hi = ch_to_n(substr($1, 3, 1))
		
		if (_lo < _hi) {
			while (_lo <= _hi) {
				$1 = n_to_ch(_lo)

				save_to(G_char_tbl_arr)
				++_lo
			}
		} else {
			err_quit(sprintf("the first character of range '%s'"\
				"must come before the second", $1))
		}
	} else {
		save_to(G_char_tbl_arr)
	}
}

function err_quit(msg) {
	error_quit(sprintf("%s, line %d: %s", FILENAME, FNR, msg), SCRIPT_NAME())
}

function out_arr(arr,    _i, _end, _unj) {
	# Output the fields of an arr structure separated by a tab.
	# See inc_lex_lib.awk on why arr structures are special.
	
	_end = arr_len(arr)
	for (_i = 1; _i <= _end; ++_i) {
		unjoin(_unj, arr[_i])
		out_line(sprintf("%s\t%s", _unj[1], _unj[2]))
	}
}

function out_table(label, arr) {
	# Called to print all tables after they are processed and ready for the next
	# stage.
	
	out_line(label)
	tab_inc()
	out_arr(arr)
	tab_dec()
	out_line(END_())
}

function symbols_to_ch_cls(    _set, _arr, _i, _end, _str, _ch_map, _ch, _n) {
	# Generate char classes for the first characters of the symbols if any
	# symbols exist. This is done only if said first characters is not already
	# in the char table.

	map_from_arr(_ch_map, G_char_tbl_arr)
	arr_make_set(_set, G_symbols_arr)
	_end = arr_len(_set)

	arr_init(_arr)
	for (_i = 1; _i <= _end; ++_i) {
		_str = _set[_i]
		if (!is_constant(_str))
			arr_push(_arr, str_ch_at(_str, 1))
	}
	
	arr_make_set(_set, _arr)
	_end = arr_len(_set)
	for (_i = 1; _i <= _end; ++_i) {
		_ch = _set[_i]
		if (!(_ch in _ch_map)) {
			arr_push(G_char_tbl_arr,
				join(_set[_i], sprintf(CH_CLS_AUTO_GEN(), ++_n)))
		}
	}
}

function generate() {
	symbols_to_ch_cls()
	out_table(CHAR_TBL(), G_char_tbl_arr)
	out_table(SYMBOLS(),  G_symbols_arr)
	out_table(KEYWORDS(), G_keywords_arr)
	out_table(PATTERNS(), G_patterns_arr)
	out_table(ACTIONS(),  G_actions_arr)
}

function init() {
	# User input is saved in these.
	arr_init(G_char_tbl_arr)
	arr_init(G_symbols_arr)
	arr_init(G_keywords_arr)
	arr_init(G_patterns_arr)
	arr_init(G_actions_arr)

	# Use as array, so awk knows they are not scalar. Used to determine if any
	# characters/tokens/keywords etc. repeat.
	G_char_tbl_set[""]
	G_symbols_set[""]
	G_keywords_set[""]
	G_patterns_set[""]
	G_actions_set[""]
}

function err_repeat() {err_quit(sprintf("multiple instances of '%s'", $1))}
function set_save_char_tbl() {
	if (!($1 in G_char_tbl_set)) {			
		G_char_tbl_set[$1] = 1
		save_char_tbl()
	} else {
		err_repeat()
	}
}

function set_save_to(set, arr) {
	if (!($1 in set)) {
		set[$1] = 1
		save_to(arr)
	} else {
		err_repeat()
	}
}

function on_help() {
print sprintf("%s -- lex-build front end", SCRIPT_NAME())
print ""
print "Reads lex-build input, expands character ranges, generates automatic"
print "character classes for symbols if needed, makes sure no tokens repeat."
print ""
print "Options:"
# Only common
}

function on_version() {
print sprintf("%s %s", SCRIPT_NAME(), SCRIPT_VERSION())
}

# Callbacks called from the main awk loop. See inc_lex_lib.awk
function on_begin()    {init()}
function on_char_tbl() {set_save_char_tbl()}
function on_symbols()  {set_save_to(G_symbols_set, G_symbols_arr)}
function on_keywords() {set_save_to(G_keywords_set, G_keywords_arr)}
function on_patterns() {set_save_to(G_patterns_set, G_patterns_arr)}
function on_actions()  {set_save_to(G_actions_set, G_actions_arr)}
function on_else()     {err_quit(sprintf("'%s' unknown", $0))}
function on_end()      {generate()}
# </misc>
