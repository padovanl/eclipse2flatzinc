
:-[libreria].
%:-lib(fd).
%:-lib(fd_global).

prova(L):-
	length(L,3),
	L :: 1..5,
	sorted([3,2,1],L),
	labeling(L).

