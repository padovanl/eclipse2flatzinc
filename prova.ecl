
:-[libreria].
%:-lib(fd).
%:-lib(fd_global).

prova(L):-
	length(L,6),
	L :: 1..5,
	minlist(L,2),
	labeling(L).

