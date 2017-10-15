%{
#include <stdio.h>
#include <string.h>
#include "employee.h"

#define max(a,b) ((a)>(b)?(a):(b))
void yyerror (char const *);

int numMedidas = 0;
tEmployeeList l;
char aux[10][20];
int indice = 0;
char * tabla;
char * operando1;
char * operando2;
char * operador;
char * nombreError;
char buffer[2];
int ok = 0;
int sinwhere = 0;

%}
/*
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************

								REGLAS

****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
*/

%union{
	int valInt;
	float valFloat;
	char * valString;
}

%token SELECT FROM WHERE
%token <valString> CAMPO TABLA OPERADOR EOFF NUMBERS COMA PUNTOYCOMA ASTERISCO STRINGVALOR WORD
%type <valString> camposelect fromtabla selectfrom wheretabla wherefrom operando
%start S
%%

S :  wheretabla{printf("\n llego wheretabla\n"); ok = 0;}
	|fromtabla{printf("\n llego fromrtabla\n"); ok = 0;}
	;

wheretabla : wherefrom operando OPERADOR operando PUNTOYCOMA {printf("\nWHERE");
	operando1 = $2;
	operador = $3;
	operando2 = $4;
}

wheretabla : wherefrom operando OPERADOR operando {yyerror("ERROR: No se ha encontrado el caracter ; ");
	ok = 1;
	return;
}
	| wherefrom EOFF {//yyerror("ERROR: Alcanzado final de fichero de forma incorrecta");
	//ok = 1;
	//return;
}
	| wherefrom operando OPERADOR error {yyerror("ERROR: no se reconoce el tercer operando");
	ok = 1;
	return;
}
	| wherefrom operando error {yyerror("ERROR: no se reconoce el segundo operando");
	ok = 1;
	return;
}
	| wherefrom error {yyerror("ERROR: no se reconoce el primer operando");
	ok = 1;
	return;
}
	;

operando : CAMPO | NUMBERS | STRINGVALOR;

wherefrom : fromtabla WHERE {printf("\nwherefrom");}
	| fromtabla PUNTOYCOMA {printf("\nWhererom sin were, correcto");
	sinwhere = 1;
	return;
}
	| fromtabla error {yyerror("ERROR: condiciones sin WHERE");
	ok = 1;
	return;
}
	| fromtabla {yyerror("ERROR: No se ha encontardo el caracter ; ");
	ok = 1;
	return;
}
	;
fromtabla : selectfrom TABLA {tabla = $2; printf("\nfromtabla");}
	| selectfrom error {yyerror("ERROR: no se reconoce el nombre de la tabla");
	ok = 1;
	return;
}
	;	
selectfrom: camposelect FROM {printf("\nselectfrom");}
	| selectasterisco FROM {printf("\nselectfrom asterisco");}
	| camposelect error {
	strcpy(nombreError,"ERROR: no se reconoce el token ");
	snprintf(buffer, 2, "%d", indice+2);
	strcat(nombreError,buffer);
	yyerror(nombreError);
	ok = 1;
	return;
}
;

selectasterisco : SELECT ASTERISCO {printf("\n ASTERISCO");}
	| selectasterisco error { yyerror("ERROR: Después del asterisco tiene que haber un FROM");
	ok = 1;
	return;}
;


camposelect : SELECT CAMPO {strcpy(aux[indice], $2);indice++;printf("\nselect");}
	| camposelect COMA CAMPO {strcpy(aux[indice], $3);indice++;printf("\nselect2");}
	| SELECT error {
		strcpy(nombreError,"ERROR: no se reconoce el token ");
		strcat(nombreError,"2");
		yyerror(nombreError);
		ok = 1;
		return;
}
	| camposelect CAMPO error {
		strcpy(nombreError,"ERROR: no se reconoce el token ");
		snprintf(buffer, 2, "%d", indice+3);
		strcat(nombreError,buffer);
		yyerror(nombreError);
		ok = 1;
		return;
} 
	;

/*
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************

								LEER Y PARSEAR FICHERO

****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
*/



%%

//Parsea el fichero de los empleados y construye una lista con ellos

tEmployeeList parseDB(){

	l = createEmployeeList ();

	FILE *f = fopen("Empleados.txt", "r" );	
	if (!f) { 
		printf("Couldn't open file Empleados for reading.\n"); 
		fclose(f);
		exit(0); 
	} 

	fseek(f, 0, SEEK_END);
	long fsize = ftell(f);
	fseek(f, 0, SEEK_SET);
	char *string = malloc(fsize + 1);
	fread(string, fsize, 1, f);
	fclose(f);

	char * idEmpleado = strtok (string, ","); 
	char * nombre = strtok (NULL, ",");
	char * apellidos = strtok (NULL, ",");
	char * puesto = strtok (NULL, ",");
	char * anho = strtok (NULL, "\n");
	tEmployee empleado = createEmployee (nombre, apellidos, puesto,anho, atoi(idEmpleado));
	addEmployeeToList (l, empleado);


	while (1){
		idEmpleado = strtok (NULL, ","); 
		if (idEmpleado == NULL)
			break;
		
		nombre = strtok (NULL, ",");
		apellidos = strtok (NULL, ",");
		puesto = strtok (NULL, ",");
		anho = strtok (NULL, "\n"); 
		empleado = createEmployee (nombre, apellidos, puesto,anho, atoi(idEmpleado));
		addEmployeeToList (l, empleado);
	}
	
	return l;
}



char * getCampo(char * operando,tEmployee tE) {
	int atoi1 = 0;
	char * opp =  malloc(sizeof(char)*100);
	//opp = operando;
	atoi1 = atoi(operando);
	if (atoi1 != NULL)
		return operando;
	else
		if(!strncmp(operando,"idEmpleado",10))
			sprintf(opp, "%d", tE->idEmpleado);
		else if(!strncmp(operando,"nombre",10))
			opp = tE->nombre;
		else if(!strncmp(operando,"apellidos",10))
			opp = tE->apellidos;
		else if(!strncmp(operando,"anho",10))
			opp = tE->anho;
		else if(!strncmp(operando,"puesto",10))
			opp = tE->puesto;
		else {
			opp = strtok(operando,"\"");
			//printf("\n\n%s <- operando", opp);
	}

	return opp;
}



/*
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************

								MAIN

****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
*/



int main() {
	nombreError = malloc(sizeof(char)*100);

	char * campo;
	int len;
	int atoi1, atoi2 ;
	int print = 0;
	char * prueba;
	int k = 0;
	char * campo1 =  malloc(sizeof(char)*100);
	char * campo2 =  malloc(sizeof(char)*100);
	int p = 0;
	int lenght;
	yyparse();

	if (ok != 0 || tabla == NULL){
		printf("\n Exiting...\n");
		return 0 ;
	}

	tEmployeeList l = parseDB();
	lenght = lengthEmployeeList(l);

	int i = 0;
	for (i = 0; i<indice;i++)
		printf("\ncampo %d -> %s",i,aux[i]);

	printf("\ntabla -> %s",tabla);
	printf("\noperando1 -> %s",operando1);
	printf("\noperando2 -> %s",operando2);
	printf("\noperandor -> %s\n\n",operador);



	if (sinwhere){
		//si no hay condiciones, meto unas que hace que lo imprima siempre
		operando1 = "1";
		operando2 = "1";
		operador = "=";
	}

	//hago un primer recorrido de la lista
	for (k=0;k<lenght;k++){
		
		tEmployee ss1 = getEmployeeFromListByIndex (l, k);

		campo1 = getCampo(operando1,ss1);
		//printf("\n\nCAMPO1 -> %s",campo1);

		//si el primer campo es una constante, voy a la ultima iteracion del primer bucle
		if ((!strncmp(campo1,operando1,strlen(campo1))) || !strncmp(operando1,"\"",1)){
			k = lenght;
		}
			
		//hago un segundo recorrido de la lista
		for(p = 0; p<lenght;p++){

			tEmployee ss2 = getEmployeeFromListByIndex (l, p);
			campo2 = getCampo(operando2,ss2);
			//printf("\ncampo2 -> %s",campo2);

			//si el campo es una constante, me voy a la ultima iteracion y pongo para imprimir
			//el empleado correspondiente
			if ((!strncmp(campo2,operando2,strlen(campo2)) && k != lenght)|| !strncmp(operando2,"\"",1)){
				p = lenght;
				ss2 = ss1;
			}
			

			if (!strncmp(operador,"=",1)){
				//si son iguales los comparo a pelo
				//me quedo con el maximo por si la primera parte es igual pero luego no
				len = max(strlen(campo1),strlen(campo2));
				print = !strncmp(campo1,campo2,len);
			}
			else{
				//si llego aqui es que los dos campos son integers
				atoi1 = atoi(campo1);
				atoi2 = atoi(campo2);
				if (atoi1 != NULL && atoi2 != NULL)
					if (!strncmp(operador,">",1))
						print = atoi1 > atoi2;
					if (!strncmp(operador,"<",1))
						print = atoi1 < atoi2;
			}

			if (print){
				// si es *, imprimo todo
				if (indice == 0)
					printf("%d %s %s %s %s", ss2->idEmpleado, ss2->nombre, ss2->apellidos, ss2->puesto, ss2->anho);
				else{
					i = 0;
					for (i=0;i<indice;i++){
						campo = aux[i];
						if(!strncmp(campo,"idEmpleado",10))
							printf(" %d ",ss2->idEmpleado);
						if(!strncmp(campo,"nombre",6))
							printf(" %s ",ss2->nombre);
						if(!strncmp(campo,"apellidos",9))
							printf(" %s ",ss2->apellidos);
						if(!strncmp(campo,"anho",4))
							printf(" %s ",ss2->anho);
						if(!strncmp(campo,"puesto",6))
							printf(" %s ",ss2->puesto);
					}
				}
			printf("\n");
			}
		}

	}
	return 0;
}

void yyerror (char const *message) { if (strncmp(message,"syntax error",12))fprintf (stderr, "%s\n", message);}

