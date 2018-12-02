:-[eclipse2flatzinc].

maxlist_sample:-
	length(L,10),
	L :: 1..7,
	%6 e' il valore massimo della lista
	maxlist(L,6),
	labeling(L).

