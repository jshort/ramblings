calc : calc.tab.c calc.tab.h calc.yy.c
	cc -L/usr/local/opt/flex/lib -std=gnu89 -o calc calc.tab.c calc.yy.c -lfl
calc.tab.c calc.tab.h : calc.y
	/usr/local/opt/bison/bin/bison -d calc.y
calc.yy.c : calc.l calc.tab.h
	/usr/local/opt/flex/bin/flex -o calc.yy.c calc.l
.PHONY : clean
clean :
	rm calc calc.tab.* calc.yy.*

