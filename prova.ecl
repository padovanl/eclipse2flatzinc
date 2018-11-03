
:-[libreria].
%:-lib(fd).
%:-lib(ic_global).

prova(L):-
	length(L,5),
	L :: 1..5,
	element(2,L,3),
	labeling(L).

