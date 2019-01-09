:-[eclipse2flatzinc].

prova:-
	A::1..15,
	B::1..5,
	%C :: 1..10,
	A * B #< 10,
	labeling([A,B]).
