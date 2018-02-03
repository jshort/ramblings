%{
#include <stdlib.h>
#include <readline/readline.h>
#include <readline/history.h>
#define YY_INPUT(buf,result,max_size) result = mygetinput(buf, max_size);

static int mygetinput(char *buf, int size) {
  char *line;
  if (feof(yyin))  return YY_NULL;
  line = readline("> ");
  if(!line)        return YY_NULL;
  if(strlen(line) > size-2) {
    fprintf(stderr,"input line too long\n"); return YY_NULL;
  }
  sprintf(buf,"%s\n",line);
  add_history(line);
  free(line);
  return strlen(buf);
}
%}

%option noyywrap
%%
ls.*         system(yytext);
date.*       system(yytext);
.+           fprintf(stderr, "Error: unknown comand\n");
[ \t\n]+     {}
%%
