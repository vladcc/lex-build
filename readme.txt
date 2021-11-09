!!!NOTE!!! This project has moved to:
https://github.com/vladcc/shawk/tree/main/shawk/awk/lex-build



lex-build - a tokenizer generator

Generates human readable lexers. Has a front end and back ends for different
target languages. The lexers generated in C tend to be either faster than or
comparable to flex. Details in readme_lex-c.txt.

How to run:
$ awk -f lex_lib.awk -f lex-first.awk src.txt | awk -f lex_lib.awk -f lex-c.awk

assuming the lexer descriptions is in src.txt. Try lex-build/input.txt instead
of src.txt for a demo.

Generated source short examples:
lex-build/tests/c/lex*
lex-build/tests/awk/*

Generated source longer examples:
lex-build/c-vs-flex/lex*
lex-build/c-vs-flex/awk/*

Run unit tests:
bash tests/run-tests.sh

Run verbose unit tests:
bash tests/run-tests.sh x

Run performance tests:
$ cd c-vs-flex/ && make -B all
$ cd c-vs-flex/ && make -B awk

More info:
lex-build/readme_lex-first.txt - general framework, syntax, and front end doc
lex-build/readme_lex-c.txt     - the C back end documentation
lex-build/readme_lex-awk.txt   - the awk back end documentation
lex-build/readme_proj.txt      - the project structure
