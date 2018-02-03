%{
#include "calc.tab.h"
%}

%%
"+"      { return ADD; }
"-"      { return SUB; }
"*"      { return MUL; }
"/"      { return DIV; }
"|"      { return ABS; }
"!"      { return FACT; }
"("      { return OPEN_PAREN; }
")"      { return CLOSE_PAREN; }
[0-9]+   { yylval = atoi(yytext); return NUMBER; }
[ \t]+   { /* nada */ }
"//".*   { /* nada */ }
\n       { return EOL; }
.        { printf("Unknown character %c\n", *yytext); }
%%
