:-[eclipse2flatzinc].

atmost_sample:-
	length(L,5),
	L :: 1..5,
	%al massimo tre elementi della lista L hanno valore 1
	atmost(3,L,1),
	labeling(L).

