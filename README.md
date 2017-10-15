FLEX and BISON SQL query engine
============

FLEX and BISON SQL query engine that takes as input a database and a query, both .txt files.
This was a project for the Language Processing course in my senior year of my undergrad in computer science at UDC (Spain).
The file "README.txt" contains more comprehensive instructions (In Spanish)


## Query specification

```
SELECT *|field1[,field2,…] FROM Table_Name
WHERE operand operator operand;
```
where

```
operand: campo|valor
operator: <|>|=
```

## Table format

```
CREATE TABLE Empleado (
idEmpleado BIGINT NOT NULL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellidos VARCHAR(200) NOT NULL,
puesto VARCHAR(100) NOT NULL, anho CHAR(4) NOT NULL
);
```


## Instructions
Download the code and to compile and execute the software, run 

```
make
```

The file "consulta.txt" and "Empleados.txt" contain a working example, ready to use. Feel free to change it with your own.

## Tools and requirements

The project was developed with 

- C
- FLEX
- BISON


## Contact

Contact [Daniel Ruiz Perez](mailto:druiz072@fiu.edu) for requests, bug reports and good jokes.


## License

The software in this repository is available under the GNU General Public License, version 3. See the [LICENSE](https://github.com/DaniRuizPerez/EyeMovementDetection/blob/master/LICENSE) file for more information.
