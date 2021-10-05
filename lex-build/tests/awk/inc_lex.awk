# <lex_awk>
# generated by lex-awk.awk 1.3

# <lex_usr_defined>
# The user implements the following:
# lex_usr_get_line()
# lex_usr_on_unknown_ch()
# lex_usr_get_word()
# lex_usr_get_number()
# </lex_usr_defined>

# <lex_public>
# <lex_constants>

# the only way to have immutable values; use as constants
function TOK_EQ() {return "="}
function TOK_EQEQ() {return "=="}
function TOK_EQEQEQ() {return "==="}
function TOK_NEQEQEQ() {return "==!"}
function TOK_NEQ() {return "=!"}
function TOK_LESS() {return "<"}
function TOK_GT() {return ">"}
function TOK_LEQ() {return "<="}
function TOK_GEQ() {return ">="}
function TOK_AND() {return "&"}
function TOK_EOI() {return "EOI"}
function TOK_IF() {return "if"}
function TOK_ELSE() {return "else"}
function TOK_ELIF() {return "elif"}
function TOK_WHILE() {return "while"}
function TOK_ID() {return "id"}
function TOK_NUMBER() {return "number"}
function TOK_ERROR() {return "I am Error"}

function CH_CLS_SPACE() {return 1}
function CH_CLS_WORD() {return 2}
function CH_CLS_NUMBER() {return 3}
function CH_CLS_LESS_THAN() {return 4}
function CH_CLS_GRTR_THAN() {return 5}
function CH_CLS_NEW_LINE() {return 6}
function CH_CLS_EOI() {return 7}
function CH_CLS_AUTO_1_() {return 8}
function CH_CLS_AUTO_2_() {return 9}
# </lex_constants>

# read the next character; advance the input
function lex_read_ch() {
	# Note: the user defines lex_usr_get_line()

	_B_lex_curr_ch = _B_lex_input_line[_B_lex_line_pos++]
	_B_lex_peek_ch = _B_lex_input_line[_B_lex_line_pos]
	if (_B_lex_peek_ch != "")
		return _B_lex_curr_ch
	else
		split(lex_usr_get_line(), _B_lex_input_line, "")
	return _B_lex_curr_ch
}

# return the last read character
function lex_curr_ch()
{return _B_lex_curr_ch}

# return the next character, but do not advance the input
function lex_peek_ch()
{return _B_lex_peek_ch}

# return the position in the current line of input
function lex_get_pos()
{return (_B_lex_line_pos-1)}

# return the current line number
function lex_get_line_no()
{return _B_lex_line_no}

# return the last read token
function lex_curr_tok()
{return _B_lex_curr_tok}

# see if your token is the same as the one in the lexer
function lex_match_tok(str)
{return (str == _B_lex_curr_tok)}

# clear the lexer write space
function lex_save_init()
{_B_lex_saved = ""}

# save the last read character
function lex_save_curr_ch()
{_B_lex_saved = (_B_lex_saved _B_lex_curr_ch)}

# return the saved string
function lex_get_saved()
{return _B_lex_saved}

# character classes
function lex_is_ch_cls(ch, cls)
{return (cls == _B_lex_ch_tbl[ch])}

function lex_is_curr_ch_cls(cls)
{return (cls == _B_lex_ch_tbl[_B_lex_curr_ch])}

function lex_is_next_ch_cls(cls)
{return (cls == _B_lex_ch_tbl[_B_lex_peek_ch])}

function lex_get_ch_cls(ch)
{return _B_lex_ch_tbl[ch]}

# see if what's in the lexer's write space is a keyword
function lex_is_saved_a_keyword()
{return (_B_lex_saved in _B_lex_keywords_tbl)}

# call this first
function lex_init() {
	# '_B' variables are 'bound' to the lexer, i.e. 'private'
	if (!_B_lex_are_tables_init) {
		_lex_init_ch_tbl()
		_lex_init_keywords()
		_B_lex_are_tables_init = 1
	}
	_B_lex_curr_ch = ""
	_B_lex_curr_ch_cls_cache = ""
	_B_lex_curr_tok = "I am Error"
	_B_lex_line_no = 1
	_B_lex_line_pos = 1
	_B_lex_peek_ch = ""
	_B_lex_peeked_ch_cache = ""
	_B_lex_saved = ""
	split(lex_usr_get_line(), _B_lex_input_line, "")
}

# return the next token; constants are inlined for performance
function lex_next() {
	_B_lex_curr_tok = "I am Error"
	while (1) {
		_B_lex_curr_ch_cls_cache = _B_lex_ch_tbl[lex_read_ch()]
		if (1 == _B_lex_curr_ch_cls_cache) { # CH_CLS_SPACE()
			continue
		} else if (2 == _B_lex_curr_ch_cls_cache) { # CH_CLS_WORD()
			_B_lex_curr_tok = lex_usr_get_word()
		} else if (3 == _B_lex_curr_ch_cls_cache) { # CH_CLS_NUMBER()
			_B_lex_curr_tok = lex_usr_get_number()
		} else if (4 == _B_lex_curr_ch_cls_cache) { # CH_CLS_LESS_THAN()
			_B_lex_curr_tok = "<"
			if ("=" == lex_peek_ch()) {
				lex_read_ch()
				_B_lex_curr_tok = "<="
			} 
		} else if (5 == _B_lex_curr_ch_cls_cache) { # CH_CLS_GRTR_THAN()
			_B_lex_curr_tok = ">"
			if ("=" == lex_peek_ch()) {
				lex_read_ch()
				_B_lex_curr_tok = ">="
			} 
		} else if (6 == _B_lex_curr_ch_cls_cache) { # CH_CLS_NEW_LINE()
			++_B_lex_line_no
			_B_lex_line_pos = 1
			continue
		} else if (7 == _B_lex_curr_ch_cls_cache) { # CH_CLS_EOI()
			_B_lex_curr_tok = TOK_EOI()
		} else if (8 == _B_lex_curr_ch_cls_cache) { # CH_CLS_AUTO_1_()
			_B_lex_curr_tok = "="
			_B_lex_peeked_ch_cache = lex_peek_ch()
			if ("!" == _B_lex_peeked_ch_cache) {
				lex_read_ch()
				_B_lex_curr_tok = "=!"
			} else if ("=" == _B_lex_peeked_ch_cache) {
				lex_read_ch()
				_B_lex_curr_tok = "=="
				_B_lex_peeked_ch_cache = lex_peek_ch()
				if ("!" == _B_lex_peeked_ch_cache) {
					lex_read_ch()
					_B_lex_curr_tok = "==!"
				} else if ("=" == _B_lex_peeked_ch_cache) {
					lex_read_ch()
					_B_lex_curr_tok = "==="
				} 
			} 
		} else if (9 == _B_lex_curr_ch_cls_cache) { # CH_CLS_AUTO_2_()
			_B_lex_curr_tok = "&"
		} else {
			_B_lex_curr_tok = lex_usr_on_unknown_ch()
		}
		break
	}
	return _B_lex_curr_tok
}
# </lex_public>

# <lex_private>
# initialize the lexer tables
function _lex_init_keywords() {
	_B_lex_keywords_tbl["if"] = 1
	_B_lex_keywords_tbl["else"] = 1
	_B_lex_keywords_tbl["elif"] = 1
	_B_lex_keywords_tbl["while"] = 1
}
function _lex_init_ch_tbl() {
	_B_lex_ch_tbl[" "] = CH_CLS_SPACE()
	_B_lex_ch_tbl["\t"] = CH_CLS_SPACE()
	_B_lex_ch_tbl["_"] = CH_CLS_WORD()
	_B_lex_ch_tbl["a"] = CH_CLS_WORD()
	_B_lex_ch_tbl["b"] = CH_CLS_WORD()
	_B_lex_ch_tbl["c"] = CH_CLS_WORD()
	_B_lex_ch_tbl["d"] = CH_CLS_WORD()
	_B_lex_ch_tbl["e"] = CH_CLS_WORD()
	_B_lex_ch_tbl["f"] = CH_CLS_WORD()
	_B_lex_ch_tbl["g"] = CH_CLS_WORD()
	_B_lex_ch_tbl["h"] = CH_CLS_WORD()
	_B_lex_ch_tbl["i"] = CH_CLS_WORD()
	_B_lex_ch_tbl["j"] = CH_CLS_WORD()
	_B_lex_ch_tbl["k"] = CH_CLS_WORD()
	_B_lex_ch_tbl["l"] = CH_CLS_WORD()
	_B_lex_ch_tbl["m"] = CH_CLS_WORD()
	_B_lex_ch_tbl["n"] = CH_CLS_WORD()
	_B_lex_ch_tbl["o"] = CH_CLS_WORD()
	_B_lex_ch_tbl["p"] = CH_CLS_WORD()
	_B_lex_ch_tbl["q"] = CH_CLS_WORD()
	_B_lex_ch_tbl["r"] = CH_CLS_WORD()
	_B_lex_ch_tbl["s"] = CH_CLS_WORD()
	_B_lex_ch_tbl["t"] = CH_CLS_WORD()
	_B_lex_ch_tbl["u"] = CH_CLS_WORD()
	_B_lex_ch_tbl["v"] = CH_CLS_WORD()
	_B_lex_ch_tbl["w"] = CH_CLS_WORD()
	_B_lex_ch_tbl["x"] = CH_CLS_WORD()
	_B_lex_ch_tbl["y"] = CH_CLS_WORD()
	_B_lex_ch_tbl["z"] = CH_CLS_WORD()
	_B_lex_ch_tbl["A"] = CH_CLS_WORD()
	_B_lex_ch_tbl["B"] = CH_CLS_WORD()
	_B_lex_ch_tbl["C"] = CH_CLS_WORD()
	_B_lex_ch_tbl["D"] = CH_CLS_WORD()
	_B_lex_ch_tbl["E"] = CH_CLS_WORD()
	_B_lex_ch_tbl["F"] = CH_CLS_WORD()
	_B_lex_ch_tbl["G"] = CH_CLS_WORD()
	_B_lex_ch_tbl["H"] = CH_CLS_WORD()
	_B_lex_ch_tbl["I"] = CH_CLS_WORD()
	_B_lex_ch_tbl["J"] = CH_CLS_WORD()
	_B_lex_ch_tbl["K"] = CH_CLS_WORD()
	_B_lex_ch_tbl["L"] = CH_CLS_WORD()
	_B_lex_ch_tbl["M"] = CH_CLS_WORD()
	_B_lex_ch_tbl["N"] = CH_CLS_WORD()
	_B_lex_ch_tbl["O"] = CH_CLS_WORD()
	_B_lex_ch_tbl["P"] = CH_CLS_WORD()
	_B_lex_ch_tbl["Q"] = CH_CLS_WORD()
	_B_lex_ch_tbl["R"] = CH_CLS_WORD()
	_B_lex_ch_tbl["S"] = CH_CLS_WORD()
	_B_lex_ch_tbl["T"] = CH_CLS_WORD()
	_B_lex_ch_tbl["U"] = CH_CLS_WORD()
	_B_lex_ch_tbl["V"] = CH_CLS_WORD()
	_B_lex_ch_tbl["W"] = CH_CLS_WORD()
	_B_lex_ch_tbl["X"] = CH_CLS_WORD()
	_B_lex_ch_tbl["Y"] = CH_CLS_WORD()
	_B_lex_ch_tbl["Z"] = CH_CLS_WORD()
	_B_lex_ch_tbl["0"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["1"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["2"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["3"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["4"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["5"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["6"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["7"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["8"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["9"] = CH_CLS_NUMBER()
	_B_lex_ch_tbl["<"] = CH_CLS_LESS_THAN()
	_B_lex_ch_tbl[">"] = CH_CLS_GRTR_THAN()
	_B_lex_ch_tbl["\n"] = CH_CLS_NEW_LINE()
	_B_lex_ch_tbl[""] = CH_CLS_EOI()
	_B_lex_ch_tbl["="] = CH_CLS_AUTO_1_()
	_B_lex_ch_tbl["&"] = CH_CLS_AUTO_2_()
}
# </lex_private>
# </lex_awk>
