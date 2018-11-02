
:-[libreria].
%:-lib(fd).
%:-lib(ic_global).

prova(L):-
	length(L,4),
	L :: 1..5,
	occurrences(2,L,3),
	labeling(L).

