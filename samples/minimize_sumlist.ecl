:-[eclipse2flatzinc].


minimize_sumlist_sample:-
	length(L,3),
	L :: 1..5,
	sumlist(L,C),
	minimize(labeling(L),C).

