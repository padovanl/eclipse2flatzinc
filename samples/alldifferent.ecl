:-[eclipse2flatzinc].

alldifferent_sample:-
	length(L,5),
	L :: 1..5,
	alldifferent(L),
	labeling(L).

