FUENTE = p2
PRUEBA = consulta.txt

all: cls employee.o compile run 
cls:
	clear
employee.o:
	gcc -c employee.c

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd
	gcc -o $(FUENTE) lex.yy.c employee.o $(FUENTE).tab.c -lfl -ly -w

run:
	./$(FUENTE) < $(PRUEBA)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h
