%{
#include "parser.tab.h"
void yyerror (char *s);
int yylex();
%}
%%

[0-9]+                 {yylval.num = atoi(yytext); return number;}
[ \t]                  ;

[-+*/=\n;]           	{return yytext[0];}
.                       {yyerror("Invalid input"); }

%%

int yywrap (void) {return 1;}
