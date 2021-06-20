// <lex_source>
// generated by lex-c.awk 1.3
#include "foo_lex.h"

static const char * tokens[] = {
"=",                "==",               "===",              "==!",              
/* FOO_TOK_EQ */    /* FOO_TOK_EQEQ */  /* FOO_TOK_EQEQEQ *//* FOO_TOK_NEQEQEQ */
"=!",               "<",                ">",                "<=",               
/* FOO_TOK_NEQ */   /* FOO_TOK_LESS */  /* FOO_TOK_GT */    /* FOO_TOK_LEQ */   
">=",               "&",                "EOI",              "if",               
/* FOO_TOK_GEQ */   /* FOO_TOK_AND */   /* FOO_TOK_EOI */   /* FOO_TOK_IF */    
"else",             "elif",             "while",            "id",               
/* FOO_TOK_ELSE */  /* FOO_TOK_ELIF */  /* FOO_TOK_WHILE */ /* FOO_TOK_ID */    
"number",           
/* FOO_TOK_NUMBER */
"I am Error",
/* FOO_TOK_ERROR */
};

const char * foo_lex_tok_to_str(foo_tok_id tok)
{
	return tokens[tok];
}

enum foo_char_cls {
FOO_CH_CLS_SPACE = 1,FOO_CH_CLS_WORD,    FOO_CH_CLS_NUMBER,  FOO_CH_CLS_LESS_THAN,
FOO_CH_CLS_GRTR_THAN,FOO_CH_CLS_NEW_LINE,FOO_CH_CLS_EOI,     FOO_CH_CLS_AUTO_1_, 
FOO_CH_CLS_AUTO_2_, 
};

#define CHAR_TBL_SZ (0xFF+1)
typedef unsigned char byte;
static const byte char_cls_tbl[CHAR_TBL_SZ] = {
/* 000 0x00 '\0' */ FOO_CH_CLS_EOI, 
0, 0, 0, 0, 0, 0, 0, 0, 
/* 009 0x09 '\t' */ FOO_CH_CLS_SPACE, /* 010 0x0A '\n' */ FOO_CH_CLS_NEW_LINE, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 
/* 032 0x20 ' ' */ FOO_CH_CLS_SPACE, 
0, 0, 0, 0, 0, 
/* 038 0x26 '&' */ FOO_CH_CLS_AUTO_2_, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 
/* 048 0x30 '0' */ FOO_CH_CLS_NUMBER, /* 049 0x31 '1' */ FOO_CH_CLS_NUMBER, 
/* 050 0x32 '2' */ FOO_CH_CLS_NUMBER, /* 051 0x33 '3' */ FOO_CH_CLS_NUMBER, 
/* 052 0x34 '4' */ FOO_CH_CLS_NUMBER, /* 053 0x35 '5' */ FOO_CH_CLS_NUMBER, 
/* 054 0x36 '6' */ FOO_CH_CLS_NUMBER, /* 055 0x37 '7' */ FOO_CH_CLS_NUMBER, 
/* 056 0x38 '8' */ FOO_CH_CLS_NUMBER, /* 057 0x39 '9' */ FOO_CH_CLS_NUMBER, 
0, 0, 
/* 060 0x3C '<' */ FOO_CH_CLS_LESS_THAN, /* 061 0x3D '=' */ FOO_CH_CLS_AUTO_1_, 
/* 062 0x3E '>' */ FOO_CH_CLS_GRTR_THAN, 
0, 0, 
/* 065 0x41 'A' */ FOO_CH_CLS_WORD, /* 066 0x42 'B' */ FOO_CH_CLS_WORD, 
/* 067 0x43 'C' */ FOO_CH_CLS_WORD, /* 068 0x44 'D' */ FOO_CH_CLS_WORD, 
/* 069 0x45 'E' */ FOO_CH_CLS_WORD, /* 070 0x46 'F' */ FOO_CH_CLS_WORD, 
/* 071 0x47 'G' */ FOO_CH_CLS_WORD, /* 072 0x48 'H' */ FOO_CH_CLS_WORD, 
/* 073 0x49 'I' */ FOO_CH_CLS_WORD, /* 074 0x4A 'J' */ FOO_CH_CLS_WORD, 
/* 075 0x4B 'K' */ FOO_CH_CLS_WORD, /* 076 0x4C 'L' */ FOO_CH_CLS_WORD, 
/* 077 0x4D 'M' */ FOO_CH_CLS_WORD, /* 078 0x4E 'N' */ FOO_CH_CLS_WORD, 
/* 079 0x4F 'O' */ FOO_CH_CLS_WORD, /* 080 0x50 'P' */ FOO_CH_CLS_WORD, 
/* 081 0x51 'Q' */ FOO_CH_CLS_WORD, /* 082 0x52 'R' */ FOO_CH_CLS_WORD, 
/* 083 0x53 'S' */ FOO_CH_CLS_WORD, /* 084 0x54 'T' */ FOO_CH_CLS_WORD, 
/* 085 0x55 'U' */ FOO_CH_CLS_WORD, /* 086 0x56 'V' */ FOO_CH_CLS_WORD, 
/* 087 0x57 'W' */ FOO_CH_CLS_WORD, /* 088 0x58 'X' */ FOO_CH_CLS_WORD, 
/* 089 0x59 'Y' */ FOO_CH_CLS_WORD, /* 090 0x5A 'Z' */ FOO_CH_CLS_WORD, 
0, 0, 0, 0, 
/* 095 0x5F '_' */ FOO_CH_CLS_WORD, 
0, 
/* 097 0x61 'a' */ FOO_CH_CLS_WORD, /* 098 0x62 'b' */ FOO_CH_CLS_WORD, 
/* 099 0x63 'c' */ FOO_CH_CLS_WORD, /* 100 0x64 'd' */ FOO_CH_CLS_WORD, 
/* 101 0x65 'e' */ FOO_CH_CLS_WORD, /* 102 0x66 'f' */ FOO_CH_CLS_WORD, 
/* 103 0x67 'g' */ FOO_CH_CLS_WORD, /* 104 0x68 'h' */ FOO_CH_CLS_WORD, 
/* 105 0x69 'i' */ FOO_CH_CLS_WORD, /* 106 0x6A 'j' */ FOO_CH_CLS_WORD, 
/* 107 0x6B 'k' */ FOO_CH_CLS_WORD, /* 108 0x6C 'l' */ FOO_CH_CLS_WORD, 
/* 109 0x6D 'm' */ FOO_CH_CLS_WORD, /* 110 0x6E 'n' */ FOO_CH_CLS_WORD, 
/* 111 0x6F 'o' */ FOO_CH_CLS_WORD, /* 112 0x70 'p' */ FOO_CH_CLS_WORD, 
/* 113 0x71 'q' */ FOO_CH_CLS_WORD, /* 114 0x72 'r' */ FOO_CH_CLS_WORD, 
/* 115 0x73 's' */ FOO_CH_CLS_WORD, /* 116 0x74 't' */ FOO_CH_CLS_WORD, 
/* 117 0x75 'u' */ FOO_CH_CLS_WORD, /* 118 0x76 'v' */ FOO_CH_CLS_WORD, 
/* 119 0x77 'w' */ FOO_CH_CLS_WORD, /* 120 0x78 'x' */ FOO_CH_CLS_WORD, 
/* 121 0x79 'y' */ FOO_CH_CLS_WORD, /* 122 0x7A 'z' */ FOO_CH_CLS_WORD, 
0, 0, 0, 0, 0, 
};
#define char_cls_get(ch) ((byte)char_cls_tbl[(byte)(ch)])

foo_tok_id foo_lex_next(foo_lex_state * lex)
{
	int peek_ch = 0;
	foo_tok_id tok = FOO_TOK_ERROR;
	while (true)
	{
		switch (char_cls_get(foo_lex_read_ch(lex)))
		{
			case FOO_CH_CLS_SPACE:
			{
				continue;
			} break;
			case FOO_CH_CLS_WORD:
			{
				tok = foo_lex_usr_get_word(lex);
				goto done;
			} break;
			case FOO_CH_CLS_NUMBER:
			{
				tok = foo_lex_usr_get_number(lex);
				goto done;
			} break;
			case FOO_CH_CLS_LESS_THAN:
			{
				tok = FOO_TOK_LESS;
				if ('=' == foo_lex_peek_ch(lex))
				{
					foo_lex_read_ch(lex);
					tok = FOO_TOK_LEQ;
				}
				goto done;
			} break;
			case FOO_CH_CLS_GRTR_THAN:
			{
				tok = FOO_TOK_GT;
				if ('=' == foo_lex_peek_ch(lex))
				{
					foo_lex_read_ch(lex);
					tok = FOO_TOK_GEQ;
				}
				goto done;
			} break;
			case FOO_CH_CLS_NEW_LINE:
			{
				++lex->input_line;
				lex->input_pos = 0;
				continue;
			} break;
			case FOO_CH_CLS_EOI:
			{
				tok = FOO_TOK_EOI;
				goto done;
			} break;
			case FOO_CH_CLS_AUTO_1_: /* '=' */
			{
				tok = FOO_TOK_EQ;
				peek_ch = foo_lex_peek_ch(lex);
				if ('!' == peek_ch)
				{
					foo_lex_read_ch(lex);
					tok = FOO_TOK_NEQ;
				}
				else if ('=' == peek_ch)
				{
					foo_lex_read_ch(lex);
					tok = FOO_TOK_EQEQ;
					peek_ch = foo_lex_peek_ch(lex);
					if ('!' == peek_ch)
					{
						foo_lex_read_ch(lex);
						tok = FOO_TOK_NEQEQEQ;
					}
					else if ('=' == peek_ch)
					{
						foo_lex_read_ch(lex);
						tok = FOO_TOK_EQEQEQ;
					}
				}
				goto done;
			} break;
			case FOO_CH_CLS_AUTO_2_: /* '&' */
			{
				tok = FOO_TOK_AND;
				goto done;
			} break;
			default:
			{
				tok = foo_lex_usr_on_unknown_ch(lex);
				goto done;
			} break;
		}
	}
done:
	return (lex->curr_tok = tok);
}

// <lex_keyword_or_base>
#define KW_LONG  5 // longest keyword length
#define VALID_LENGTHS 0x00000034U // 0000_0000 0000_0000 0000_0000 0011_0100
#define is_valid_len(len) (VALID_LENGTHS & (1 << (len)))

foo_tok_id foo_lex_keyword_or_base(foo_lex_state * lex, foo_tok_id base)
{
	foo_tok_id tok = base;
	uint txt_len = lex->write_buff_pos;

	if (!(txt_len <= KW_LONG && is_valid_len(txt_len)))
		return tok;

	const char * ch = lex->write_buff;
	if ('i' == *ch)
	{
		++ch;
		if ('f' == *ch)
		{
			++ch;
			tok = FOO_TOK_IF;
		}
	}
	else if ('e' == *ch)
	{
		++ch;
		if ('l' == *ch)
		{
			++ch;
			if ('s' == *ch)
			{
				++ch;
				if ('e' == *ch)
				{
					++ch;
					tok = FOO_TOK_ELSE;
				}
			}
			else if ('i' == *ch)
			{
				++ch;
				if ('f' == *ch)
				{
					++ch;
					tok = FOO_TOK_ELIF;
				}
			}
		}
	}
	else if ('w' == *ch)
	{
		++ch;
		if ('h' == *ch)
		{
			++ch;
			if ('i' == *ch)
			{
				++ch;
				if ('l' == *ch)
				{
					++ch;
					if ('e' == *ch)
					{
						++ch;
						tok = FOO_TOK_WHILE;
					}
				}
			}
		}
	}

	return ('\0' == *ch) ? tok : base;
}
// </lex_keyword_or_base>
// </lex_source>
