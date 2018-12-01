:-[libreria].

sumlist_sample:-
	length(L,5),
	L :: 1..5,
	%element 2 is in L 1 times
	occurrences(2,L,1),
	labeling(L).

