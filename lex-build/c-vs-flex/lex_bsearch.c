// <lex_source>
// generated by lex-c.awk 1.0
#include "lex.h"
#include <string.h>
#include <stdlib.h>

static const char * tokens[] = {
"+",                "-",                "*",                "/",                
/* PLUS */          /* MINUS */         /* MULT */          /* DIVD */          
"%",                "++",               "--",               "==",               
/* MODUL */         /* INCR */          /* DECR */          /* EQEQ */          
"!=",               ">",                "<",                ">=",               
/* NEQ */           /* GRTR */          /* LESS */          /* GEQ */           
"<=",               "&&",               "||",               "!",                
/* LEQ */           /* LAND */          /* LOR */           /* LNOT */          
"&",                "|",                "^",                "<<",               
/* AMPRS */         /* BOR */           /* XOR */           /* LSHFT */         
">>",               "=",                "+=",               "-=",               
/* RSHFT */         /* EQ */            /* PLEQ */          /* MINEQ */         
"*=",               "/=",               "%=",               "(",                
/* MULTEQ */        /* DIVEQ */         /* MODEQ */         /* LPAR */          
")",                "{",                "}",                "[",                
/* RPAR */          /* LCURLY */        /* RCURLY */        /* LSQUARE */       
"]",                ";",                ",",                "EOI",              
/* RSQUARE */       /* SEMI */          /* COMMA */         /* TOK_EOI */       
"auto",             "break",            "case",             "char",             
/* AUTO */          /* BREAK */         /* CASE */          /* CHAR */          
"const",            "continue",         "default",          "do",               
/* CONST */         /* CONTINUE */      /* DEFAULT */       /* DO */            
"double",           "else",             "enum",             "extern",           
/* DOUBLE */        /* ELSE */          /* ENUM */          /* EXTERN */        
"float",            "for",              "goto",             "if",               
/* FLOAT */         /* FOR */           /* GOTO */          /* IF */            
"int",              "long",             "register",         "return",           
/* INT */           /* LONG */          /* REGISTER */      /* RETURN */        
"short",            "signed",           "sizeof",           "static",           
/* SHORT */         /* SIGNED */        /* SIZEOF */        /* STATIC */        
"struct",           "switch",           "typedef",          "union",            
/* STRUCT */        /* SWITCH */        /* TYPEDEF */       /* UNION */         
"unsigned",         "void",             "volatile",         "while",            
/* UNSIGNED */      /* VOID */          /* VOLATILE */      /* WHILE */         
"id",               "number",           
/* ID */            /* NUM */           
"I am Error",
/* TOK_ERROR */
};

const char * lex_tok_to_str(tok_id tok)
{
	return tokens[tok];
}

enum char_cls {
CH_CLS_SPACE = 1,   CH_CLS_WORD,        CH_CLS_NUMBER,      CH_CLS_NEW_LINE,    
CH_CLS_EOI,         CH_CLS_AUTO_1_,     CH_CLS_AUTO_2_,     CH_CLS_AUTO_3_,     
CH_CLS_AUTO_4_,     CH_CLS_AUTO_5_,     CH_CLS_AUTO_6_,     CH_CLS_AUTO_7_,     
CH_CLS_AUTO_8_,     CH_CLS_AUTO_9_,     CH_CLS_AUTO_10_,    CH_CLS_AUTO_11_,    
CH_CLS_AUTO_12_,    CH_CLS_AUTO_13_,    CH_CLS_AUTO_14_,    CH_CLS_AUTO_15_,    
CH_CLS_AUTO_16_,    CH_CLS_AUTO_17_,    CH_CLS_AUTO_18_,    CH_CLS_AUTO_19_,    
CH_CLS_AUTO_20_,    
};

#define CHAR_TBL_SZ (0xFF+1)
typedef unsigned char byte;
static const byte char_cls_tbl[CHAR_TBL_SZ] = {
/* 000 0x00 '\0' */ CH_CLS_EOI,     
0, 0, 0, 0, 0, 0, 0, 0, 
/* 009 0x09 '\t' */ CH_CLS_SPACE,   /* 010 0x0A '\n' */ CH_CLS_NEW_LINE, 
0, 0, 
/* 013 0x0D '\r' */ CH_CLS_SPACE,   
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 
/* 032 0x20 ' ' */ CH_CLS_SPACE,    /* 033 0x21 '!' */ CH_CLS_AUTO_7_,  
0, 0, 0, 
/* 037 0x25 '%' */ CH_CLS_AUTO_5_,  /* 038 0x26 '&' */ CH_CLS_AUTO_10_, 
0, 
/* 040 0x28 '(' */ CH_CLS_AUTO_13_, /* 041 0x29 ')' */ CH_CLS_AUTO_14_, 
/* 042 0x2A '*' */ CH_CLS_AUTO_3_,  /* 043 0x2B '+' */ CH_CLS_AUTO_1_,  
/* 044 0x2C ',' */ CH_CLS_AUTO_20_, /* 045 0x2D '-' */ CH_CLS_AUTO_2_,  
0, 
/* 047 0x2F '/' */ CH_CLS_AUTO_4_,  /* 048 0x30 '0' */ CH_CLS_NUMBER,   
/* 049 0x31 '1' */ CH_CLS_NUMBER,   /* 050 0x32 '2' */ CH_CLS_NUMBER,   
/* 051 0x33 '3' */ CH_CLS_NUMBER,   /* 052 0x34 '4' */ CH_CLS_NUMBER,   
/* 053 0x35 '5' */ CH_CLS_NUMBER,   /* 054 0x36 '6' */ CH_CLS_NUMBER,   
/* 055 0x37 '7' */ CH_CLS_NUMBER,   /* 056 0x38 '8' */ CH_CLS_NUMBER,   
/* 057 0x39 '9' */ CH_CLS_NUMBER,   
0, 
/* 059 0x3B ';' */ CH_CLS_AUTO_19_, /* 060 0x3C '<' */ CH_CLS_AUTO_9_,  
/* 061 0x3D '=' */ CH_CLS_AUTO_6_,  /* 062 0x3E '>' */ CH_CLS_AUTO_8_,  
0, 0, 
/* 065 0x41 'A' */ CH_CLS_WORD,     /* 066 0x42 'B' */ CH_CLS_WORD,     
/* 067 0x43 'C' */ CH_CLS_WORD,     /* 068 0x44 'D' */ CH_CLS_WORD,     
/* 069 0x45 'E' */ CH_CLS_WORD,     /* 070 0x46 'F' */ CH_CLS_WORD,     
/* 071 0x47 'G' */ CH_CLS_WORD,     /* 072 0x48 'H' */ CH_CLS_WORD,     
/* 073 0x49 'I' */ CH_CLS_WORD,     /* 074 0x4A 'J' */ CH_CLS_WORD,     
/* 075 0x4B 'K' */ CH_CLS_WORD,     /* 076 0x4C 'L' */ CH_CLS_WORD,     
/* 077 0x4D 'M' */ CH_CLS_WORD,     /* 078 0x4E 'N' */ CH_CLS_WORD,     
/* 079 0x4F 'O' */ CH_CLS_WORD,     /* 080 0x50 'P' */ CH_CLS_WORD,     
/* 081 0x51 'Q' */ CH_CLS_WORD,     /* 082 0x52 'R' */ CH_CLS_WORD,     
/* 083 0x53 'S' */ CH_CLS_WORD,     /* 084 0x54 'T' */ CH_CLS_WORD,     
/* 085 0x55 'U' */ CH_CLS_WORD,     /* 086 0x56 'V' */ CH_CLS_WORD,     
/* 087 0x57 'W' */ CH_CLS_WORD,     /* 088 0x58 'X' */ CH_CLS_WORD,     
/* 089 0x59 'Y' */ CH_CLS_WORD,     /* 090 0x5A 'Z' */ CH_CLS_WORD,     
/* 091 0x5B '[' */ CH_CLS_AUTO_17_, 
0, 
/* 093 0x5D ']' */ CH_CLS_AUTO_18_, /* 094 0x5E '^' */ CH_CLS_AUTO_12_, 
/* 095 0x5F '_' */ CH_CLS_WORD,     
0, 
/* 097 0x61 'a' */ CH_CLS_WORD,     /* 098 0x62 'b' */ CH_CLS_WORD,     
/* 099 0x63 'c' */ CH_CLS_WORD,     /* 100 0x64 'd' */ CH_CLS_WORD,     
/* 101 0x65 'e' */ CH_CLS_WORD,     /* 102 0x66 'f' */ CH_CLS_WORD,     
/* 103 0x67 'g' */ CH_CLS_WORD,     /* 104 0x68 'h' */ CH_CLS_WORD,     
/* 105 0x69 'i' */ CH_CLS_WORD,     /* 106 0x6A 'j' */ CH_CLS_WORD,     
/* 107 0x6B 'k' */ CH_CLS_WORD,     /* 108 0x6C 'l' */ CH_CLS_WORD,     
/* 109 0x6D 'm' */ CH_CLS_WORD,     /* 110 0x6E 'n' */ CH_CLS_WORD,     
/* 111 0x6F 'o' */ CH_CLS_WORD,     /* 112 0x70 'p' */ CH_CLS_WORD,     
/* 113 0x71 'q' */ CH_CLS_WORD,     /* 114 0x72 'r' */ CH_CLS_WORD,     
/* 115 0x73 's' */ CH_CLS_WORD,     /* 116 0x74 't' */ CH_CLS_WORD,     
/* 117 0x75 'u' */ CH_CLS_WORD,     /* 118 0x76 'v' */ CH_CLS_WORD,     
/* 119 0x77 'w' */ CH_CLS_WORD,     /* 120 0x78 'x' */ CH_CLS_WORD,     
/* 121 0x79 'y' */ CH_CLS_WORD,     /* 122 0x7A 'z' */ CH_CLS_WORD,     
/* 123 0x7B '{' */ CH_CLS_AUTO_15_, /* 124 0x7C '|' */ CH_CLS_AUTO_11_, 
/* 125 0x7D '}' */ CH_CLS_AUTO_16_, 
0, 0, 
};
#define char_cls_get(ch) ((byte)char_cls_tbl[(byte)(ch)])

tok_id lex_next(lex_state * lex)
{
	int peek_ch = 0;
	tok_id tok = TOK_ERROR;
	while (true)
	{
		switch (char_cls_get(lex_read_ch(lex)))
		{
			case CH_CLS_SPACE:
			{
				continue;
			} break;
			case CH_CLS_WORD:
			{
				tok = lex->get_word(lex);
				goto done;
			} break;
			case CH_CLS_NUMBER:
			{
				tok = lex->get_number(lex);
				goto done;
			} break;
			case CH_CLS_NEW_LINE:
			{
				++lex->input_line;
				lex->input_pos = 0;
				continue;
			} break;
			case CH_CLS_EOI:
			{
				tok = TOK_EOI;
				goto done;
			} break;
			case CH_CLS_AUTO_1_: /* '+' */
			{
				tok = PLUS;
				peek_ch = lex_peek_ch(lex);
				if ('=' == peek_ch)
				{
					lex_read_ch(lex);
					tok = PLEQ;
				}
				else if ('+' == peek_ch)
				{
					lex_read_ch(lex);
					tok = INCR;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_2_: /* '-' */
			{
				tok = MINUS;
				peek_ch = lex_peek_ch(lex);
				if ('=' == peek_ch)
				{
					lex_read_ch(lex);
					tok = MINEQ;
				}
				else if ('-' == peek_ch)
				{
					lex_read_ch(lex);
					tok = DECR;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_3_: /* '*' */
			{
				tok = MULT;
				if ('=' == lex_peek_ch(lex))
				{
					lex_read_ch(lex);
					tok = MULTEQ;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_4_: /* '/' */
			{
				tok = DIVD;
				if ('=' == lex_peek_ch(lex))
				{
					lex_read_ch(lex);
					tok = DIVEQ;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_5_: /* '%' */
			{
				tok = MODUL;
				if ('=' == lex_peek_ch(lex))
				{
					lex_read_ch(lex);
					tok = MODEQ;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_6_: /* '=' */
			{
				tok = EQ;
				if ('=' == lex_peek_ch(lex))
				{
					lex_read_ch(lex);
					tok = EQEQ;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_7_: /* '!' */
			{
				tok = LNOT;
				if ('=' == lex_peek_ch(lex))
				{
					lex_read_ch(lex);
					tok = NEQ;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_8_: /* '>' */
			{
				tok = GRTR;
				peek_ch = lex_peek_ch(lex);
				if ('=' == peek_ch)
				{
					lex_read_ch(lex);
					tok = GEQ;
				}
				else if ('>' == peek_ch)
				{
					lex_read_ch(lex);
					tok = RSHFT;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_9_: /* '<' */
			{
				tok = LESS;
				peek_ch = lex_peek_ch(lex);
				if ('<' == peek_ch)
				{
					lex_read_ch(lex);
					tok = LSHFT;
				}
				else if ('=' == peek_ch)
				{
					lex_read_ch(lex);
					tok = LEQ;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_10_: /* '&' */
			{
				tok = AMPRS;
				if ('&' == lex_peek_ch(lex))
				{
					lex_read_ch(lex);
					tok = LAND;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_11_: /* '|' */
			{
				tok = BOR;
				if ('|' == lex_peek_ch(lex))
				{
					lex_read_ch(lex);
					tok = LOR;
				}
				goto done;
			} break;
			case CH_CLS_AUTO_12_: /* '^' */
			{
				tok = XOR;
				goto done;
			} break;
			case CH_CLS_AUTO_13_: /* '(' */
			{
				tok = LPAR;
				goto done;
			} break;
			case CH_CLS_AUTO_14_: /* ')' */
			{
				tok = RPAR;
				goto done;
			} break;
			case CH_CLS_AUTO_15_: /* '{' */
			{
				tok = LCURLY;
				goto done;
			} break;
			case CH_CLS_AUTO_16_: /* '}' */
			{
				tok = RCURLY;
				goto done;
			} break;
			case CH_CLS_AUTO_17_: /* '[' */
			{
				tok = LSQUARE;
				goto done;
			} break;
			case CH_CLS_AUTO_18_: /* ']' */
			{
				tok = RSQUARE;
				goto done;
			} break;
			case CH_CLS_AUTO_19_: /* ';' */
			{
				tok = SEMI;
				goto done;
			} break;
			case CH_CLS_AUTO_20_: /* ',' */
			{
				tok = COMMA;
				goto done;
			} break;
			default:
			{
				tok = lex->on_unknown_ch(lex);
				goto done;
			} break;
		}
	}
done:
	return (lex->curr_tok = tok);
}

// <lex_keyword_or_base>
#define KW_LONG  8 // longest keyword length
#define VALID_LENGTHS 0x000001FCU // 0000_0000 0000_0000 0000_0001 1111_1100
#define is_valid_len(len) (VALID_LENGTHS & (1 << (len)))

typedef struct str_tok {
	const char * str;
	tok_id tok;
} str_tok;
static int compar(const void * a, const void * b)
{
	const char * key = (const char *)a;
	const str_tok * stb = (const str_tok *)b;
	return strcmp(key, stb->str);
}

tok_id lex_keyword_or_base(lex_state * lex, tok_id base)
{
	// ordered by length and value; don't jumble up
	static const str_tok kws[32] = {
	/* 00 */ {"do", DO}, // 2
	/* 01 */ {"if", IF}, // 2
	/* 02 */ {"for", FOR}, // 3
	/* 03 */ {"int", INT}, // 3
	/* 04 */ {"auto", AUTO}, // 4
	/* 05 */ {"case", CASE}, // 4
	/* 06 */ {"char", CHAR}, // 4
	/* 07 */ {"else", ELSE}, // 4
	/* 08 */ {"enum", ENUM}, // 4
	/* 09 */ {"goto", GOTO}, // 4
	/* 10 */ {"long", LONG}, // 4
	/* 11 */ {"void", VOID}, // 4
	/* 12 */ {"break", BREAK}, // 5
	/* 13 */ {"const", CONST}, // 5
	/* 14 */ {"float", FLOAT}, // 5
	/* 15 */ {"short", SHORT}, // 5
	/* 16 */ {"union", UNION}, // 5
	/* 17 */ {"while", WHILE}, // 5
	/* 18 */ {"double", DOUBLE}, // 6
	/* 19 */ {"extern", EXTERN}, // 6
	/* 20 */ {"return", RETURN}, // 6
	/* 21 */ {"signed", SIGNED}, // 6
	/* 22 */ {"sizeof", SIZEOF}, // 6
	/* 23 */ {"static", STATIC}, // 6
	/* 24 */ {"struct", STRUCT}, // 6
	/* 25 */ {"switch", SWITCH}, // 6
	/* 26 */ {"default", DEFAULT}, // 7
	/* 27 */ {"typedef", TYPEDEF}, // 7
	/* 28 */ {"continue", CONTINUE}, // 8
	/* 29 */ {"register", REGISTER}, // 8
	/* 30 */ {"unsigned", UNSIGNED}, // 8
	/* 31 */ {"volatile", VOLATILE}, // 8
	};

	typedef struct kw_len_data {
		byte start;
		byte len;
	} kw_len_data;

	static const kw_len_data kws_len[KW_LONG+1] = {
		{0, 0}, // always empty; can't have keywords of length 0
		{0, 0}, // 1
		{0, 2}, // 2
		{2, 2}, // 3
		{4, 8}, // 4
		{12, 6}, // 5
		{18, 8}, // 6
		{26, 2}, // 7
		{28, 4}, // 8
	};

	tok_id tok = base;
	const char * txt = lex->write_buff;
	uint txt_len = lex->write_buff_pos;
	if (txt_len <= KW_LONG && is_valid_len(txt_len))
	{
		str_tok * kw = (str_tok *)bsearch(txt,
			kws+kws_len[txt_len].start,
			kws_len[txt_len].len,
			sizeof(*kws),
			compar
		);
		return ((!kw) ? tok : kw->tok);
	}
	return tok;
}
// </lex_keyword_or_base>
// </lex_source>
