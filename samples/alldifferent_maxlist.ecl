:-[libreria].

alldifferent_maxlist_sample:-
	length(L,10),
	L :: 1..25,
	alldifferent(L),
	maxlist(L,25),
	labeling(L).

