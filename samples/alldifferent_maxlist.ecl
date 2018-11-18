:-[libreria].

alldifferent_maxlist_sample:-
	length(L,3),
	L :: 1..5,
	alldifferent(L),
	maxlist(L,5),
	labeling(L).

