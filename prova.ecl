
:-[eclipse2flatzinc].
%:-lib(fd).
%:-lib(fd_global).

prova(L):-
	length(L,3),
	L :: 1..5,
	sumlist(L,C),
	minimize(labeling(L),C).
	%labeling(L).

