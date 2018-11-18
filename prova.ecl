
:-[libreria].
%:-lib(fd).
%:-lib(fd_global).

prova(L):-
	length(L,3),
	L :: 1..5,
	sumlist(L,15),
	labeling(L).

