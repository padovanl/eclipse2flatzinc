:-[libreria].

occurrences_sample:-
	length(L,5),
	L :: 1..5,
	%element 2 is in L 3 times
	occurrences(2,L,3),
	labeling(L).

