:-[libreria].

sumlist_sample:-
	length(L,5),
	L :: 1..5,
	%sumlist(L,10),
	%element 1 is in L 2 times
	occurrences(1,L,2),
	labeling(L).

% [1,1,2,2,4]

