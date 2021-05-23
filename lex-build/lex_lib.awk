# Common lex-build functionality
# v1.01

# Author: Vladimir Dinev
# vld.dinev@gmail.com
# 2021-05-23

# <ascii>
# Generates a map of the ascii table. Used to turn characters into number and
# the other way around.

function num_to_ch(n) {return sprintf("%c", n)}
function init_ch_map(    _i, _ch) {
	for (_i = 0; _i <= 127; ++_i) {
		_ch = num_to_ch(_i)

		if (0x00 == _i) {_ch = "\\0"}
		else if (0x07 == _i) { _ch = "\\a"}
		else if (0x08 == _i) { _ch = "\\b"}
		else if (0x09 == _i) { _ch = "\\t"}
		else if (0x0A == _i) { _ch = "\\n"}
		else if (0x0B == _i) { _ch = "\\v"}
		else if (0x0C == _i) { _ch = "\\f"}
		else if (0x0D == _i) { _ch = "\\r"}
		else if (0x1B == _i) { _ch = "\\e"}
		
		_B_ch_to_n[_ch] = _i
		_B_n_to_ch[_i] = _ch
	}
}
function ch_to_n(ch) {return _B_ch_to_n[ch]}
function n_to_ch(n) {return _B_n_to_ch[n]}
# </ascii>

# <arr>
# An array structure which knows its own length. Way more convenient than always
# having to track it manually. How it is generally used throughout lex-builder
# is the two input fields are joined like so (f1 SUBSEP f2) and that string is
# pushed into the arr. This makes sure the order of the input is preserved. The
# fields have to be unjoined when you want to read them later.

function LEN() {return "len"}
function arr_init(arr) {arr[""] = ""; delete arr; arr[LEN()] = 0}
function arr_len(arr) {return arr[LEN()]}
function arr_push(arr, str) {arr[++arr[LEN()]] = str}
function arr_get(arr, i) {return arr[i]}
function arr_has(arr, what,    _i, _end) {
	_end = arr_len(arr)
	for (_i = 1; _i <= _end; ++_i) {
		if (arr[_i] == what)
			return 1
	}
	return 0
}
function arr_copy(arr_dest, arr_src,    _i, _end) {
	arr_init(arr_dest)
	_end = arr_len(arr_src)
	for (_i = 1; _i <= _end; ++_i)
		arr_push(arr_dest, arr_src[_i])
}
function arr_append(arr_dest, arr_src,    _i, _end) {
	_end = arr_len(arr_src)
	for (_i = 1; _i <= _end; ++_i)
		arr_push(arr_dest, arr_src[_i])
}
function arr_make_set(set_out, arr_in, fld,    _i, _end, _split) {
	if (!fld)
		fld = 1
	
	arr_init(set_out)
	_end = arr_len(arr_in)
	for (_i = 1; _i <= _end; ++_i) {
		unjoin(_split, arr_in[_i])
		if (!arr_has(set_out, _split[fld]))
			arr_push(set_out, _split[fld])
	}
}
function join(a, b) {return (a SUBSEP b)}
function unjoin(arr_out, str) {return split(str, arr_out, SUBSEP)}
function save_to(arr) {
	# Usually called from user handlers. Makes sure you don't save delimiters.
	if (!is_range_word($0))
		arr_push(arr, join($1, $2))
}
function map_from_arr(map_out, arr_in, field_ind, field_val,
    _i, _end, _arr) {
	# Turn arr[1] = ("foo" SUBSEP "bar") into arr["foo"] = "bar", or
	# arr["bar"] = "foo". Repeat for all items of arr.

	delete map_out
	if (!field_ind) {
		field_ind = 1
		field_val = 2
	}
	
	_end = arr_len(arr_in)
	for (_i = 1; _i <= _end; ++_i) {
		unjoin(_arr, arr_in[_i])
		map_out[_arr[field_ind]] = _arr[field_val] 
	}
}
# </arr>

# <output>
# Prints indentation in front of output. Great for printing source code.

function tab_inc() {++_B_tabs}
function tab_dec() {--_B_tabs}
function out_tabs(    _i) {for (_i = 1; _i <= _B_tabs; ++_i) printf("\t")}
function out_str(str) {out_tabs(); printf("%s", str)}
function out_line(str) {if (str) out_str(str); print ""}
# </output>

# <string>
function str_up_to(str, pos) {return substr(str, 1, pos)}
function str_ch_at(str, pos) {return substr(str, pos, 1)}
function str_has_ch(str, ch,    _arr, _i, _end) {
	_end = split(str, _arr, "")
	for (_i = 1; _i <= _end; ++_i) {
		if (_arr[_i] == ch)
			return 1
	}
	return 0
}
# </string>

# <skip_end>
function skip_end_set() {_B_no_exec_end = 1}
function should_skip_end() {return _B_no_exec_end}
# </skip_end>

# <error>
# Absolutely quit when an error happens and let END know not to execute.
function error_quit(msg, prog_name) {
	if (!prog_name)
		prog_name = ARGV[0]
	
	print sprintf("%s: error: %s", prog_name, msg) > "/dev/stderr"
	skip_end_set()
	exit(1)
}
# </error>

# <ch_pref_tree>
# This is a prefix tree. Turns e.g. "this", "that" into
# tree["t"] = "h"
# tree["th"] = "ia"
# tree["thi"] = "s"
# tree["tha"] = "t"
# Used to generate the if trees for multi character tokens and for keyword
# recognition.

function ch_ptree_init(tree) {
	tree[""] = ""
	delete tree
}
function _PTREE_MARK() {return SUBSEP}
function _ch_ptree_make_word(str) {
	# Append SUBSEP to a string, so it wouldn't clash with the printable
	# character only string.
	return (str _PTREE_MARK())
}
function _ch_ptree_mark_word(tree, str) {
	# This is how you'd know "an" is a complete word, even though it could point
	# to other characters, e.g. tree["an"] = "d" to make "and"
	tree[_ch_ptree_make_word(str)] = 1
}
function _ch_ptree_insert(tree, str,    _pos, _len, _so_far, _next_ch, _tmp) {
	if (!_pos) {
		_pos = 1
		_len = length(str)
	}

	if (_pos < _len) {
		_so_far = str_up_to(str, _pos)

		++_pos
		_next_ch = str_ch_at(str, _pos)

		_tmp = tree[_so_far]
		if (!str_has_ch(_tmp, _next_ch)) {
			_tmp = (_tmp _next_ch)
			tree[_so_far] = _tmp
		}

		_ch_ptree_insert(tree, str, _pos, _len)
	}
}

function ch_ptree_has(tree, str) {
	return (str in tree)
}
function ch_ptree_is_word(tree, str) {
	return ch_ptree_has(tree, _ch_ptree_make_word(str))
}
function ch_ptree_insert(tree, str) {
	if (!ch_ptree_is_word(tree, str)) {
		_ch_ptree_mark_word(tree, str)
		_ch_ptree_insert(tree, str)
	}
}
function ch_ptree_get(tree, ind) {
	return tree[ind]
}
function ch_ptree_dump(tree,    _tmp) {
	# For debugging.
	for (_tmp in tree) {
		print sprintf("tree[\"%s\"] = %s",
			gensub(SUBSEP, "@", "g", _tmp), tree[_tmp])
	}
}
# </ch_pref_tree>

# <lex_constants>
# The constants used to generate and recognize automatically generated character
# classes.
function CH_CLS_AUTO_GEN() {return "CH_CLS_AUTO_%d_"}
function CH_CLS_AUTO_RE() {return "CH_CLS_AUTO_[0-9]+_"}

# Special actions. They can be values in the 'actions' table and their meaning
# is determined by the writer of the lex-*.awk in accordance with its target
# language.
function NEXT_CH() {return "next_ch"}
function NEXT_LINE() {return "next_line"}

# Since a space character cannot exist literally in the input, it has to be
# represented by an escape sequence.
function CH_ESC_SPACE() {return "\\s"}

# Use to check if an actions looks like a function call.
function FCALL() {return "\\(\\)$"}
# </lex_constants>

# <base>
# This is where the actual awk loop comes from for all lex-*.awk

function is_constant(str) {
	# Checks for the usual C I_AM_C0NST4NT syntax. Constants are intended to be
	# ignored by the general generation process, e.g. they do not get inserted
	# into prefix trees, and are left for the lex-*.awk writer to handle. E.g.
	# you may want to have a token symbol for EOI (end of input), which would
	# probably be the empty string and not the character sequence E O I. So you
	# can have EOI as a symbol and pick it out form the rest with this function.
	return match(str, "^[[:upper:]_[:digit:]]+$")
}

function is_range_word(str) {
	# Used to separate the input delimiters from the actual input.	
	return (END_() == str || CHAR_TBL() == str || SYMBOLS() == str ||
	KEYWORDS() == str || PATTERNS() == str || ACTIONS() == str) 
}

# The input delimiters.
function END_()     {return "end"}
function CHAR_TBL() {return "char_tbl"}
function SYMBOLS()  {return "symbols"}
function KEYWORDS() {return "keywords"}
function PATTERNS() {return "patterns"}
function ACTIONS()  {return "actions"}

# Main awk loop. on_*() are defined by the user. From the users standpoint
# parsing is event driven.

function quit_ok() {
	skip_end_set()
	exit(0)
}

function lib_init() {
	init_ch_map()

	if (Help) {
		on_help()
		print_help_common()
		quit_ok()
	}
	if (Version) {
		on_version()
		quit_ok()
	}
}

function print_help_common() {
print "-vVersion=1 - print version info"
print "-vHelp=1    - print this screen"
}

# Call this in on_begin(); produces an error if lex_lib.awk is not included.
function lex_lib_is_included() {}

BEGIN {lib_init(); on_begin()}
$0 == CHAR_TBL(), $0 == END_() {on_char_tbl(); next}
$0 == SYMBOLS(), $0 == END_()  {on_symbols(); next}
$0 == KEYWORDS(), $0 == END_() {on_keywords(); next}
$0 == PATTERNS(), $0 == END_() {on_patterns(); next}
$0 == ACTIONS(), $0 == END_()  {on_actions(); next}
$0 ~ /^[[:space:]]*$/ {next} # ignore empty lines
$0 ~ /^[[:space:]]*#/ {next} # ignore comments
{on_else()}

END {
	if (!should_skip_end())
		on_end()
}
# </base>
