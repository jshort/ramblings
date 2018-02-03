shell : shell.yy.c
	cc -L/usr/local/opt/flex/lib -std=gnu89 -o shell shell.yy.c -lfl -lreadline
shell.yy.c : shell.l
	/usr/local/opt/flex/bin/flex -o shell.yy.c shell.l
.PHONY : clean
clean :
	rm shell shell.yy.c

