
:-[libreria].
%:-lib(fd).
%:-lib(fd_global).

prova(L):-
	length(L,3),
	L :: 1..5,
	lexico_le([1,2,3],L),
	labeling(L).

