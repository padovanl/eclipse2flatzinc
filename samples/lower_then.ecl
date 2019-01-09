:-[eclipse2flatzinc].

lower_then:-
	A :: 1..5,
	B :: 1..5,
	A  + B #< 3,
	labeling([A,B]).

