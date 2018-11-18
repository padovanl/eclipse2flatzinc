:-[libreria].

maxlist_sample:-
	length(L,5),
	L :: 1..5,
	%5 e' il valore massimo della lista
	maxlist(L,5),
	labeling(L).

