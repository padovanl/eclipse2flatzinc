:-[libreria].

occurrences_sample:-
	length(L,5),
	L :: 1..5,
	%element 2 is in L 4 times
	occurrences(2,L,4),
	labeling(L).

