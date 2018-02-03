%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int factorial(int n)
{
  if (n == 1) return 1;
  return n * factorial(n-1);
}
%}

/* Declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS FACT
%token OPEN_PAREN CLOSE_PAREN
%token EOL

%%
calclist:
  | calclist exp EOL { printf(" = %d\n", $2); }
  | calclist EOL { /* nada */ }
  ;
exp:
    term
  | exp ADD term { $$ = $1 + $3; }
  | exp SUB term { $$ = $1 - $3; }
  ;
term:
    factor
  | term MUL factor { $$ = $1 * $3; }
  | term DIV factor { $$ = $1 / $3; }
  ;
factor:
    ABS factor { $$ = $2 > 0 ? $2 : -$2; }
  | SUB factor { $$ = 0 - $2; }
  | OPEN_PAREN exp CLOSE_PAREN { $$ = $2; }
  | OPEN_PAREN exp CLOSE_PAREN FACT { $$ = factorial($2); }
  | NUMBER FACT { $$ = factorial($1); }
  | NUMBER
  ;
%%
int main(int argc, char **argv)
{
  yyparse();
}

void yyerror(const char *s)
{
  fprintf(stderr, "Parse error: %s\n", s);
  exit(1);
}
