:-[eclipse2flatzinc].

sumlist_sample:-
	length(L,10),
	L :: 1..10,
	%la somma degli elementi della lista L e' 50
	sumlist(L,50),
	labeling(L).

