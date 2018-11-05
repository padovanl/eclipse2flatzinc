
:-[libreria].
%:-lib(fd).
%:-lib(fd_global).

prova(L):-
	length(L,4),
	L :: 1..5,
	maxlist(L,5),
	labeling(L).

