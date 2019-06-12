%{
#include <stdio.h>
#include <stdlib.h>

#define YYSTYPE long long

void yyerror(const char *s);

long long factorial(long long n);

int yydebug;
%}

/* Declare tokens */
%token NUMBER
%token EOL

%%
calclist:
  | calclist expr EOL { printf(" = %lld\n", $2); }
  | calclist EOL { /* nada */ }
  ;
expr:
    term
  | expr '+' term { $$ = $1 + $3; }
  | expr '-' term { $$ = $1 - $3; }
  ;
term:
    lfactor
  | term '*' lfactor { $$ = $1 * $3; }
  | term '/' lfactor { $$ = $1 / $3; }
  ;
lfactor:
    '|' lfactor { $$ = $2 > 0 ? $2 : -$2; }
  | '-' lfactor { $$ = 0 - $2; }
  | factor
  ;
factor:
    '(' expr ')' { $$ = $2; }
  | factor '!' { $$ = factorial((long long) $1); }
  | NUMBER
  ;
%%

int
main(int argc, char **argv)
{
  // Enable bison debug if -t is passed
  /* yydebug = 1; */
  yyparse();
}

long long
factorial(long long n)
{
  if (n == 0) return 1LL;
  return n * factorial(n - 1LL);
}

void
yyerror(const char *s)
{
  fprintf(stderr, "Parse error: %s\n", s);
  exit(1);
}
