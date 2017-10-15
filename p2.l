%{
#include <stdlib.h>
#include "p2.tab.h"
%}
tabla Empleado
campo idEmpleado|puesto|anho|apellidos|nombre
numbers [0-9]+
operador <|>|=
coma \,
puntoycoma \;
asterico \*
stringvalor \".+\"
%%
  {}
<<EOF>> {return EOFF;}
SELECT {return SELECT;}
FROM {return FROM;}
WHERE {return WHERE;}
{campo} {yylval.valString = strdup(yytext);printf("\n selecciono campo -> "); printf("%s\n",yytext);return CAMPO;}
{numbers} {yylval.valString = strdup(yytext); return NUMBERS;}
{operador} {yylval.valString = strdup(yytext); return OPERADOR;}
{tabla} {yylval.valString = strdup(yytext); return TABLA;}
{coma} {yylval.valString = strdup(yytext);return COMA;}
{puntoycoma} {yylval.valString = strdup(yytext);return PUNTOYCOMA;}
{asterico} {yylval.valString = strdup(yytext);return ASTERISCO;}
{stringvalor} {yylval.valString = strdup(yytext);printf("STRINGVALOR");return STRINGVALOR;}
. {
	if(!strncmp(yytext," ",1)){
		//printf("\nseleccionado  ->%s<- \n",yytext);
	}
	else{
		//printf("\nselecciono WORD -> %s\n",yytext);
		return WORD;
	}

}
%%

