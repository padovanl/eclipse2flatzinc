:-[libreria].

atmost_sample:-
	length(L,5),
	L :: 1..5,
	%al massimo due elementi della lista L hanno valore 1
	atmost(2,L,1),
	labeling(L).

