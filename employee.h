#ifndef Employee
#define Employee 

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct tEEmployee {
	char *nombre;
	char *apellidos;
	char *puesto;
	char *anho;
	int idEmpleado;
};

typedef struct tEEmployee *tEmployee;

struct tSNodeEmployee {
	tEmployee tEmployee;
	struct tSNodeEmployee *sig;
};

typedef struct tSNodeEmployee *tNodeEmployee;

struct tEEmployeeList {
	tNodeEmployee head;
	tNodeEmployee tail;
};

typedef struct tEEmployeeList *tEmployeeList;


/*
*	Crea un estado a partir de su nombre y si es estado final. Si esto no se indica se considerara que no es final.
*/
tEmployee createEmployee (char *nombre,char *apellidos,char *puesto, char *anho, int idEmpleado);

/*
*	Crea una lista de estados y la inicializa a lista vacia.
*	Devuelve NULL si hubo algun error
*/
tEmployeeList createEmployeeList ();

/*
*	Devuelve true (!= 0) si la lista esta vacia. Flase (== 0) en caso contrario.
*	La lista es valida
*/
int isEmptyEmployeeList (tEmployeeList EmployeeList);

/*
*	Elimina la estructura (no los datos) de la lista dejandola en NULL
*	PreCD: la lista es valida
*/
void deleteEmployeeList (tEmployeeList *EmployeeList);

/*
*	Elimina todos los datos de la lista dejandola en NULL
*	PreCD: la lista es valida
*/

int addEmployeeToList (tEmployeeList EmployeeList, tEmployee Employee);

/*
*	Elimina de la lista el estado de la posicion index de la lista. La lista empieza en 0.
*	No borra el estado.
*	PreCD: la lista es valida y el indice apunta a un elemento
*/
void removeFromEmployeeListIndex (tEmployeeList EmployeeList, int index);

/*
*	Devuelve la longitud total de la lista
*	PreCD: la lista es valida
*/
int lengthEmployeeList (tEmployeeList EmployeeList);

/*
*	Devuelve el estado de la posicion index de la lista. La lista empieza en 0. 
*	NULL en caso de no existir
*	PreCD: la lista es valida
*/
tEmployee getEmployeeFromListByIndex (tEmployeeList EmployeeList, int index);

#endif
