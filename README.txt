Daniel Ruiz Pérez (d.ruiz.perez)

Para compilar y ejecutar la práctica, ejecutar "make",
La "Base de datos" de Empleados, tiene que llamarse así, "Empleados.txt", y la consulta "consulta.txt".

la parte de después del WHERE sólo reconoce nombres de columnas en la tabla, como idEmpleado|puesto|anho|apellidos|nombre. Si se quiere escribir un número, no hay que poner nada especial, pero un string tiene que ir entre comillas.
Da igual poner "Alberto" = nombre  como nombre = "Alberto", el orden no importa.
El orden si que importa en los atributos que se quieren imprimir, por ejemplo SELECT anho,idEmpleado,nombre los sacará en ese orden y SELECT nombre,idEmpleado,anho los sacará en este otro.
la parte FROM siempre tiene que ir seguida del nombre de la tabla (Empleado). Las tablas activas están en el archivo .l y solo acepta las tablas que ahí aparecen. 

Preferí no hacer comparaciones entre strings (solo el =), por ejemplo si pongo WHERE "a" > "b", da error ya que son dos strings státicos. Para dar la opción de sacar todos los datos, a parte de no poner la opción WHERE, dejo como correcto poner  WHERE 1 < 2. Si no quiero sacar nada puedo poner  WHERE 1 > 2.
Tampoco hago comparaciones entre strings en el sentido de que si pongo where nombre > "a" no saco nada a pesar de que el ASCCII sea mayor en algunos. 

con respecto al tratamiento de errores, diseñé la gramática de tal forma que me indica donde está el fallo, en que operando, o perador, o en el FROM, que falta el ";" , etc.

Utilizo una lista para guardar en memoria dinámica la base de datos.