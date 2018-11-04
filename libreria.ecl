:-lib(swi). 
:-lib(var_name).
:-lib(lists).


% DOMINIO
A :: N1..N2 :-
	length(A,N),
	N == 1,
	open("model.fzn", append, stream),
	printf(stream, "var %d..%d: ", [N1, N2]),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ":: output_var;\n"),
	close(stream).

% DOMINIO LISTE
L :: N1..N2 :-
	length(L,N),
	N > 1,
	open("model.fzn", append, stream),
	get_var_count(NextInt),
	numlist(NextInt, NextInt + N - 1, ListTemp),
	print_all(ListTemp, N, N2),
	printf(stream, "array [1..%d] of var int: ", [N]),
	term_string(L,String),
	substring(String,1,4,_,S),
	write(stream,S),
	printf(stream, ":: output_array([%d..%d])=[", [N1, N2]),
	close(stream),
	print_all_2(ListTemp,N).

% VINCOLO DI UGUAGLIANZA
% notazione infissa
A #= B :- 
	open("model.fzn", append, stream),
	printf(stream, "constraint int_eq(", []),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ","),
	term_string(B,String2),
	substring(String2,1,4,_,S2),
	write(stream,S2),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO DI DISUGUAGLIANZA
% notazione infissa
A #\= B :- 
	open("model.fzn", append, stream),
	printf(stream, "constraint int_ne(", []),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ","),
	term_string(B,String2),
	substring(String2,1,4,_,S2),
	write(stream,S2),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO MINORE
% notazione infissa
A #< B :-
	open("model.fzn", append, stream),
	printf(stream, "constraint int_lt(", []),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ","),
	term_string(B,String2),
	substring(String2,1,4,_,S2),
	write(stream,S2),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO MINORE UGUALE
% notazione infissa
A #<= B :-
	open("model.fzn", append, stream),
	printf(stream, "constraint int_le(", []),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ","),
	term_string(B,String2),
	substring(String2,1,4,_,S2),
	write(stream,S2),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO MAGGIORE
% notazione infissa
A #> B :-
	open("model.fzn", append, stream),
	printf(stream, "constraint int_gt(", []),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ","),
	term_string(B,String2),
	substring(String2,1,4,_,S2),
	write(stream,S2),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO MAGGIORE UGUALE
% notazione infissa
A #>= B :-
	open("model.fzn", append, stream),
	printf(stream, "constraint int_ge(", []),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ","),
	term_string(B,String2),
	substring(String2,1,4,_,S2),
	write(stream,S2),
	printf(stream, ");\n", []),
	close(stream).



% VINCOLO ALLDIFFERENT
alldifferent(L) :-
	open("model.fzn", append, stream),
	printf(stream, "constraint all_different_int(", []),
	term_string(L,String),
	substring(String,1,4,_,S),
	write(stream,S),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO ATLEAST
atleast(N,L,V) :-
	open("model.fzn", append, stream),
	printf(stream, "constraint at_least_int(", []),
	printf(stream, "%d,", [N]),
	term_string(L,String),
	substring(String,1,4,_,S),
	write(stream,S),
	printf(stream, ",%d", [V]),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO ATMOST
atleast(N,L,V) :-
	open("model.fzn", append, stream),
	printf(stream, "constraint at_most_int(", []),
	printf(stream, "%d,", [N]),
	term_string(L,String),
	substring(String,1,4,_,S),
	write(stream,S),
	printf(stream, ",%d", [V]),
	printf(stream, ");\n", []),
	close(stream).

% VINCOLO OCCURRENCES
occurrences(V,L,N):-
	length(L,Length),
	get_var_count(Id),
	numlist(Id, Id + Length * 2, ListIds),
	stampa_defined_var(ListIds, Length), 
	stampa_occurrences_constraint(Length),
	stampa_occurrences_bool2int(ListIds),
	stampa_occurrences_global(ListIds,N),
	ordina_file_fzn.

stampa_occurrences_global(ListIds,N):-
	open("model.fzn", append, stream),
	printf(stream,"constraint int_lin_eq(X_INTRODUCED_",[]),
	reverse(ListIds,Lrev),
	print_head_occurrences_global_constraint(stream,Lrev),
	remove_last(ListIds,List),
	stampa_occurrences_global_loop(stream, List),
	printf(stream,"-%d);",[N]),
	close(stream).

print_head_occurrences_global_constraint(Stream,[A|T]):-
	A1 is A + 1,
	printf(Stream,"%d_,[",[A1]).

stampa_occurrences_global_loop(Stream,[A,B]):-
	printf(Stream, "X_INTRODUCED_%d_],", [B]).
stampa_occurrences_global_loop(Stream,[A,B|T]):-
	printf(Stream, "X_INTRODUCED_%d_,", [B]),
	stampa_occurrences_global_loop(Stream,T).

stampa_occurrences_bool2int(ListIds):-
	open("model.fzn", append, stream),
	remove_last(ListIds,List),
	stampa_occurrences_bool2int_loop(stream, List),
	close(stream).

stampa_occurrences_bool2int_loop(_,[]).
stampa_occurrences_bool2int_loop(Stream, [A,B|T]):-
	printf(Stream,"constraint bool2int(X_INTRODUCED_%d_,X_INTRODUCED_%d_):: defines_var(X_INTRODUCED_%d_);\n",[A,B,B]),
	stampa_occurrences_bool2int_loop(Stream, T).

stampa_defined_var(ListIds,Length):-
	open("model.fzn", append, stream),
	stampa_defined_var_loop(stream, ListIds,Length),
	close(stream).

stampa_defined_var_loop(Stream,[H],N):-
	printf(Stream,"array [1..%d]", [N]),
	H1 is H + 1,
	printf(Stream," of int: X_INTRODUCED_%d_ = [", [H1]),
	numlist(1,N,ListTemp),
	print_list(Stream,ListTemp).
stampa_defined_var_loop(Stream,[A,B|T],N):-
	printf(Stream,"var bool: X_INTRODUCED_%d_ ::var_is_introduced :: is_defined_var;\n", [A]),
	printf(Stream,"var 0..1: X_INTRODUCED_%d_ ::var_is_introduced :: is_defined_var;\n", [B]),
	stampa_defined_var_loop(Stream,T,N).

print_list(Stream,[T]):-
	printf(Stream,"-1];\n",[]).
print_list(Stream,[H|T]):-
	printf(Stream,"-1,",[]),
	print_list(Stream,T).

% TODO stampa_occurrences_constraint
% qui andrebbe studiato bene come recuperare le variabili della lista, per ora assumo che tra la dichiarazione della lista e il vincolo non siano state dichiarate altre liste
stampa_occurrences_constraint(Length):-
	open("model.fzn", append, stream),
	get_var_count(NextId),
	Start is NextId - Length,
	End is Length - 1,
	numlist(Start, End, ListIds),
	stampa_occurrences_constraint_loop(stream, Length, ListIds, Length),
	close(stream).

stampa_occurrences_constraint_loop(_,_,[],_).
stampa_occurrences_constraint_loop(Stream,Length,[H|T], Offset):-
	printf(Stream,"constraint int_eq_reif(X_INTRODUCED_%d_,", [H]),
	printf(Stream,"%d,",[Length]),
	Temp is H + Offset,
	printf(Stream,"X_INTRODUCED_%d_):: ", [Temp]),
	printf(Stream,"defines_var(X_INTRODUCED_%d_);\n", [Temp]),
	Offset1 is Offset + 1,
	stampa_occurrences_constraint_loop(Stream,Length,T,Offset1).
	
	
remove_last([X|Xs], Ys) :-                 
   remove_last_loop(Xs, Ys, X).            

remove_last_loop([], [], _).
remove_last_loop([X1|Xs], [X0|Ys], X0) :-  
   remove_last_loop(Xs, Ys, X1).  
	
% VINCOLO ELEMENT TODO da finire
% qui andrebbe studiato bene come recuperare le variabili della lista, per ora assumo che tra la dichiarazione della lista e il vincolo non siano state dichiarate altre liste
element(Index,List,Value):-
	get_lines("model.fzn",Lines),
	term_string(List,Tmp),
	substring(Tmp,1,4,_,NomeLista),
	element_loop(Lines, Index, List, Value, LinesModificate, NomeLista),
	open("model.fzn", write, stream),
	write_lines_to_file(stream, LinesModificate),
	close(stream).

element_loop([],_,_,_,_,_).
element_loop([H|T], Index, List, Value, Lm, NomeLista):-
	not(array(H)),
	element_loop(T,Index,List,Value,Lm, NomeLista).
element_loop([H|T],Index,List,Value,Lm, NomeLista):-
	array(H),
	split_string(H,":","",SplitList),
	get_list_name_from_model(SplitList, Temp2),
	split_string(Temp2," ","",SplitList2),
	get_list_name_from_model(SplitList2, NomeLista2),
	NomeLista == NomeLista2,
	modifica_dichiarazione_array(H,Index,Value).

element_loop([H|T],Index,List,Value,Lm, NomeLista):-
	array(H),
	%term_string(List,Tmp),
	%substring(Tmp,1,4,_,NomeLista),
	split_string(H,":","",SplitList),
	get_list_name_from_model(SplitList, Temp2),
	split_string(Temp2," ","",SplitList2),
	get_list_name_from_model(SplitList2, NomeLista2),
	NomeLista \= NomeLista2,
	element_loop(T,Index,List,Value,Lm, NomeLista).

modifica_dichiarazione_array(H,Index,Value):-
	split_string(H,"=","",L1),
	get_second_element(L1,S),
	split_string(S,",","",S1),
	modifica_dichiarazione_array_loop(S1,Index,Value,1,ListaVariabiliModificata),
	chiamata_di_prova(ListaVariabiliModificata),
	write(ListaVariabiliModificata).

chiamata_di_prova(L):-
	array("array ").

modifica_dichiarazione_array_loop([],_,_,_,_).
% devo modificare il primo elemento
modifica_dichiarazione_array_loop([H|T], Index, Value, Cnt, [H1|T1]):-
	Index == 1,
	Cnt == 1,
	number_string(Value,StringValue),
	string_concat("[", StringValue, Temp),
	string_concat(Temp,",",Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop(T,Index,Value,Cnt1,T1).
% devo modificare l'ultimo elemento
modifica_dichiarazione_array_loop([T], Index, Value, Cnt, [T1]):-
	Index == Cnt,
	number_string(Value,StringValue),
	string_concat(StringValue, "];" Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop(T,Index,Value,Cnt1,T1).
% devo modificare un elemento intermedio
modifica_dichiarazione_array_loop([H|T], Index, Value, Cnt, [H1|T1]):-
	Index == Cnt,
	number_string(Value,StringValue),
	string_concat(StringValue, "," Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop(T,Index,Value,Cnt1,T1).
modifica_dichiarazione_array_loop([H|T], Index, Value, Cnt, [H1|T1]):-
	Index \= Cnt,
	Cnt1 is Cnt + 1,
	H1 = H,
	modifica_dichiarazione_array_loop(T,Index,Value,Cnt1,T1).

get_second_element([A,B|T],S):-
	S = B.

get_list_name_from_model([A,B|T],ListName):-
	ListName = B.

array(String):-substring(String,1,5,"array").

























% VINCOLO MEMBER
























% LABELING
labeling(L):-
	open("model.fzn", append, stream),
	write(stream, "solve satisfy;\n"),
	close(stream).

% stampa la dichiarazione delle variabili di una lista
print_all([], _, _).
print_all([X|Rest], N, Dmax) :-
	open("model.fzn", append, s),
	printf(s, "var 1..%d: ", [Dmax]),
	printf(s, " X_INTRODUCED_%d_", [X]),
	writeln(s, ";"),
	close(s),
	print_all(Rest, N, Dmax).

% stampa la lista di variabili di output_array
print_all_2([X], N) :-
	open("model.fzn", append, s),
	printf(s, "X_INTRODUCED_%d_];\n", [X]),
	close(s).
print_all_2([X|Rest], N) :-
	open("model.fzn", append, s),
	printf(s, "X_INTRODUCED_%d_,", [X]),
	close(s),
	print_all_2(Rest, N).

get_lines(File, Lines) :-
	open(File, read, S),
	stream_get_lines(S, Lines),
	close(S).

stream_get_lines(S, Lines) :-
( 
	read_string(S, end_of_line, _, Line) ->
	Lines = [Line|Ls],
	stream_get_lines(S, Ls)
;
	Lines = []
).

print_new_declaration_scalar:-
	get_lines("model.fzn", Lines),
	open("model.temp", write, stream),
	temp(Lines, stream),
	close(stream),
	copia_file.

temp([],_).
temp([H|T], StreamOut):-
	variabili(H),
	write(StreamOut, H),
	write(StreamOut, "\n"),
	temp(T, StreamOut).
temp([H|T], StreamOut):-
	not(variabili(H)),
	write(StreamOut, "Nuova dichiarazione\n"),
	stampa_resto([H|T], StreamOut).

stampa_resto([],StreamOut).

stampa_resto([H|T], StreamOut):-
	write(StreamOut, H),
	write(StreamOut, "\n"),
	stampa_resto(T, StreamOut).

variabili(String):-substring(String,1,4,"var ").
variabili(String):-substring(String,1,5,"array").

copia_file:-
	get_lines("model.temp", Lines),
	open("model.fzn", write, streamOut),
	copia_file_loop(Lines, streamOut),
	close(streamOut).

copia_file_loop([],_).

copia_file_loop([H|T], StreamOut):-
	write(StreamOut, H),
	write(StreamOut, "\n"),
	copia_file_loop(T, StreamOut).


% recupera il contatore corrente delle variabili intermedie introdotte (ritorna il primo numero disponibile per introdurne una nuova
get_var_count(NextValue):-
	trova_ultima_dichiarazione(UltimaDichiarazione),
	UltimaDichiarazione \= "-1",
	name_value(UltimaDichiarazione, Name,Value),
	name_value(Value, Name2,Value2),
	name_value(Value2,Name3,Value3),
	integer_atom(IntValue,Name3),
	succ(IntValue, NextValue).

get_var_count(NextValue):-
	trova_ultima_dichiarazione(UltimaDichiarazione),
	UltimaDichiarazione == "-1",
	NextValue = 0.

name_value(String, Name, Value) :-
        sub_string(String, Before, _, After, "_"), !,
        sub_string(String, 0, Before, _, NameString),
        atom_string(Name, NameString),
        sub_string(String, _, After, 0, Value).

trova_ultima_dichiarazione(UltimaDichiarazione):-
	get_lines("model.fzn", Lines),
	trova_ultima_dichiarazione_loop(Lines,UltimaDichiarazione).

trova_ultima_dichiarazione_loop([A,B|T],Ultima):-
	defined_var(A),
	defined_var(B),
	trova_ultima_dichiarazione_loop([B|T],Ultima).

trova_ultima_dichiarazione_loop([A,B|T],Ultima):-
	defined_var(A),
	not(defined_var(B)),
	Ultima = A.
trova_ultima_dichiarazione_loop([],Ultima):-
	Ultima = "-1".

defined_var(String):-substring(String,1,4,"var ").

ordina_file_fzn:-
	get_lines("model.fzn",LinesFzn),
	split_lines_to_file(LinesFzn),
	merge_files.

split_lines_to_file(Lines):-
	open("model.var", write, streamVar),
	open("model.const", write, streamConst),
	split_lines_to_file_loop(Lines, streamVar, streamConst),
	close(streamVar),
	close(streamConst).

split_lines_to_file_loop([],_,_).
split_lines_to_file_loop([H|T], StreamVar, StreamConst):-
	decision(H, StreamVar, StreamConst),
	split_lines_to_file_loop(T, StreamVar, StreamConst).

decision(H, StreamVar, StreamConst):-
	variabili(H),
	printf(StreamVar,"%s\n",[H]).
decision(H, StreamVar, StreamConst):-
	not(variabili(H)),
	printf(StreamConst,"%s\n",[H]).

merge_files:-
	get_lines("model.var",LinesVar),
	get_lines("model.const",LinesConst),
	open("model.fzn",write,streamFzn),
	write_lines_to_file(streamFzn, LinesVar),
	write_lines_to_file(streamFzn, LinesConst),
	close(streamFzn).

write_lines_to_file(_,[]).
write_lines_to_file(Stream, [H|T]):-
	printf(Stream,"%s\n",[H]),
	write_lines_to_file(Stream,T).




	





	





