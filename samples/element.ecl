:-[eclipse2flatzinc].

element_sample:-
	length(L,10),
	L :: 1..15,
	% il secondo elemento della lista L deve essere 10
	element(2,L,10),
	% il quinto elemento della lista L deve essere 15
	element(5,L,15),
	labeling(L).
