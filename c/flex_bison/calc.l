%{
#include "calc.tab.h"
%}

%%
"+" |
"-" |
"*" |
"/" |
"|" |
"!" |
"(" |
")" { return yytext[0]; }
[0-9]+   { yylval = atoi(yytext); return NUMBER; }
[ \t]+   { /* nada */ }
"//".*   { /* nada */ }
\n       { return EOL; }
.        { printf("Unknown character %c\n", *yytext); }
%%
