%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>

%}

%union {int num; float f;}         /* Yacc definitions */

%start input

%token <num> number

%type <num> exp
%type <num> term
%type <num> factor
%type <num> unary
%%

/* descriptions of expected inputs     corresponding actions (in C) */

input   : exp '\n'  	{ printf("Answer = %d\n", $1); exit(0) }
		;

exp    	: exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	| term                  {$$ = $1;}
       	;

term   	: term '*' unary         {$$ = $1 * $3;}
		| term '/' unary	     {if($3 != 0)
		                          {
		                            $$ = $1 / $3;
		                          }else {
		                            yyerror("You can't divide by zero");
                                    return 1;
		                          }
		                          }
        | unary                  {$$ = $1}
        ;

unary   : '+' factor            {$$ = $2}
        | '-' factor            {$$ = -1 * $2}
        | factor                {$$ = $1;}
        ;

factor  : number                {$$ = $1;}
        | exp                   {$$ = $1;}
        ;

%%                     /* C code */

int main (void) {
    printf("Input = ");
    yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);exit(0);}

