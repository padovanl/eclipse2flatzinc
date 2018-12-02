:-[eclipse2flatzinc].

occurrences_sample:-
	length(L,5),
	L :: 1..5,
	%element 5 is in L 2 times
	occurrences(5,L,2),
	labeling(L).

