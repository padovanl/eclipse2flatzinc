:-[eclipse2flatzinc].

% R1 regione 1
% R2 regione 2
% R3 regione 3
% R4 regione 4
% R5 regione 5

% 1 = Rosso
% 2 = Verde
% 3 = Giallo
% 4 = Blu


map_coloring:-
	R1 :: 1..4,
	R2 :: 1..4,
	R3 :: 1..4,
	R4 :: 1..4,
	R5 :: 1..4,
	R1 #\= R2,
	R1 #\= R3,
	R1 #\= R4,
	R1 #\= R5,
	R2 #\= R3,
	R2 #\= R4,
	R2 #\= R5,
	R3 #\= R4,
	R4 #\= R5,
	labeling([R1,R2,R3,R4,R5]).

