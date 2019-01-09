:-lib(swi). 
:-lib(var_name).
:-lib(lists).

% Libreria che traduce i vincoli di un programma che usa la libreria fd in flatzinc.
% Per ulteriori informazioni leggere il file README.md


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














%A + B #< V :-
%	open("model.fzn", append, stream),
%	%get_var_count(Id),
%	printf(stream,"array [1..2] of int: X_INTRODUCED_0_ = [",[]),
%	print_list_of_ones(stream,2),
%	printf(stream, "];\n",[]),
%	printf(stream, "constraint int_lin_le(X_INTRODUCED_0_,[", []),
%	%constraint int_lin_le(X_INTRODUCED_0_,[X,Y],4);
%	term_string(A,String),
%	substring(String,1,4,_,S),
%	write(stream,S),
%	write(stream, ","),
%	term_string(B,String2),
%	substring(String2,1,4,_,S2),
%	write(stream,S2),
%	printf(stream, "],%d);\n", [V]),
%	close(stream).







% VINCOLO MINORE
% notazione infissa
% X #< Y
A #< B :-
	compound(B),
	compound(A),
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

% VINCOLO MINORE
% notazione infissa
% X #< 5
A #< B :-
	atomic(B),
	compound(A),
	open("model.fzn", append, stream),
	printf(stream, "constraint int_lt(", []),
	term_string(A,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream, ","),
	write(stream,B),
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
atmost(N,L,V) :-
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
	stampa_occurrences_constraint(Length,V,L),
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

print_head_occurrences_global_constraint(Stream,[A|_]):-
	A1 is A + 1,
	printf(Stream,"%d_,[",[A1]).

stampa_occurrences_global_loop(Stream,[_,B]):-
	printf(Stream, "X_INTRODUCED_%d_],", [B]).
stampa_occurrences_global_loop(Stream,[_,B|T]):-
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

print_list(Stream,[_]):-
	printf(Stream,"-1];\n",[]).
print_list(Stream,[_|T]):-
	printf(Stream,"-1,",[]),
	print_list(Stream,T).

% TODO stampa_occurrences_constraint
% qui andrebbe studiato bene come recuperare le variabili della lista, per ora assumo che tra la dichiarazione della lista e il vincolo non siano state dichiarate altre liste
stampa_occurrences_constraint(Length,N,L):-
	open("model.fzn", append, stream),
	%get_var_count(NextId),
	%Start is NextId - Length,
	%End is Length - 1,
	%numlist(Start, End, ListIds),
	term_string(L,Tmp),
	substring(Tmp,1,4,_,NomeLista),
	get_list_variables_id(L,NomeLista,ListIds),
	stampa_occurrences_constraint_loop(stream, Length, ListIds, Length,N),
	close(stream).

stampa_occurrences_constraint_loop(_,_,[],_,_).
stampa_occurrences_constraint_loop(Stream,Length,[H|T], Offset,N):-
	printf(Stream,"constraint int_eq_reif(X_INTRODUCED_%d_,", [H]),
	printf(Stream,"%d,",[N]),
	Temp is H + Offset + 1, % TODO da sistemare
	printf(Stream,"X_INTRODUCED_%d_):: ", [Temp]),
	printf(Stream,"defines_var(X_INTRODUCED_%d_);\n", [Temp]),
	Offset1 is Offset + 1,
	stampa_occurrences_constraint_loop(Stream,Length,T,Offset1,N).
	
	
remove_last([X|Xs], Ys) :-                 
   remove_last_loop(Xs, Ys, X).            

remove_last_loop([], [], _).
remove_last_loop([X1|Xs], [X0|Ys], X0) :-  
   remove_last_loop(Xs, Ys, X1).  

% VINCOLO MAXLIST
maxlist(L,_):-
	length(L,Length),
	get_var_count(Id),
	numlist(Id, Id + Length - 2, ListIds),
	term_string(L,Tmp),
	substring(Tmp,1,4,_,NomeLista),
	get_list_variables_id(L,NomeLista,ListVariableId),
	get_list_dom(V1,V2,ListVariableId),
	stampa_defined_var_maxlist(ListIds, Length,V1,V2),
	stampa_maxlist_constraint(ListVariableId,ListIds),
	ordina_file_fzn.

get_list_dom(V1,V2,ListVariableId):-
	get_lines("model.fzn",Lines),
	get_list_dom_loop(Lines,V1,V2,ListVariableId).

get_list_dom_loop([H|_],V1,V2,[H1|_]):-
	is_var(H),
	split_string(H,"_","",SplitList),
	get_second_last_element(SplitList, Temp2),
	number_string(H1,Temp1),
	Temp1 == Temp2,
	get_dom(H,V1,V2).

get_list_dom_loop([H|T],V1,V2,[H1|_]):-
	is_var(H),
	split_string(H,"_","",SplitList),
	get_second_last_element(SplitList, Temp2),
	number_string(H1,Temp1),
	Temp1 \= Temp2,
	get_list_dom_loop(T,V1,V2,[H1|_]).

get_list_dom_loop([H|T],V1,V2,ListVariableId):-
	not(is_var(H)),
	get_list_dom_loop(T,V1,V2,ListVariableId).

get_dom(String,V1,V2):-
	split_string(String,".","",Temp),
	%recupero estremo inferiore
	get_first_element(Temp,Temp3),
	split_string(Temp3," ","",Temp4),
	get_second_element(Temp4, InfString),
	number_string(V1,InfString),
	%recupero estremo superiore
	split_string(String,"..","",Temp7),
	get_last_element(Temp7,Temp5),
	split_string(Temp5,":","",Temp6),
	get_first_element(Temp6,SupString),
	number_string(V2,SupString).

is_var(String):-substring(String,1,4,"var ").

stampa_maxlist_constraint(ListVariableId,ListIds):-
	open("model.fzn", append, stream),
	stampa_maxlist_constraint_loop(stream,ListVariableId,ListIds,1),
	close(stream).

% solo il primo giro
stampa_maxlist_constraint_loop(_,[],_,_).
stampa_maxlist_constraint_loop(Stream,[A,B|T],[A1|T1],1):-
	printf(Stream,"constraint int_max(X_INTRODUCED_%d_,X_INTRODUCED_%d_,X_INTRODUCED_%d_):: defines_var(X_INTRODUCED_%d_);\n", [B,A,A1,A1]),
	stampa_maxlist_constraint_loop(Stream,T,[A1|T1],2).
stampa_maxlist_constraint_loop(Stream,[A|T],[A1,B1|T1],2):-
	printf(Stream,"constraint int_max(X_INTRODUCED_%d_,X_INTRODUCED_%d_,X_INTRODUCED_%d_):: defines_var(X_INTRODUCED_%d_);\n", [A,A1,B1,B1]),
	stampa_maxlist_constraint_loop(Stream,T,[B1|T1],2).

stampa_defined_var_maxlist(ListIds,Length,V1,V2):-
	open("model.fzn", append, stream),
	stampa_defined_var_maxlist_loop(stream, ListIds,Length,V1,V2),
	close(stream).

stampa_defined_var_maxlist_loop(Stream,[A],_,_,V2):-
	printf(Stream,"var %d..%d: X_INTRODUCED_%d_ ::var_is_introduced :: is_defined_var;\n", [V2,V2,A]).
stampa_defined_var_maxlist_loop(Stream,[A|T],N,V1,V2):-
	printf(Stream,"var %d..%d: X_INTRODUCED_%d_ ::var_is_introduced :: is_defined_var;\n", [V1,V2,A]),
	stampa_defined_var_maxlist_loop(Stream,T,N,V1,V2).

get_list_variables_id(_,Nome,ListId):-
	get_lines("model.fzn", Lines),
	get_list_variables_id_loop(Lines,Nome,ListId).
get_list_variables_id_loop([H|_],Nome,ListId):-
	array(H),
	split_string(H,":","",SplitList),
	get_list_name_from_model(SplitList, Temp2),
	split_string(Temp2," ","",SplitList2),
	get_list_name_from_model(SplitList2, NomeLista2),
	Nome == NomeLista2,
	get_ids(H,ListId).

get_list_variables_id_loop([H|T],Nome,ListId):-
	array(H),
	split_string(H,":","",SplitList),
	get_list_name_from_model(SplitList, Temp2),
	split_string(Temp2," ","",SplitList2),
	get_list_name_from_model(SplitList2, NomeLista2),
	Nome \= NomeLista2,
	get_list_variables_id_loop(T,Nome,ListId).

get_list_variables_id_loop([H|T],Nome,ListId):-
	not(array(H)),
	get_list_variables_id_loop(T,Nome,ListId).

get_ids(H,ListId):-
	split_string(H,"=","",Temp),
	get_second_element(Temp,Temp2),
	split_string(Temp2,",","",List),
	% ottengo il primo indice
	get_first_element(List,First),
	get_first_id(First,FirstIdInt),
	% ottengo l'ultimo indice
	get_last_element(List,Last),
	get_last_id(Last,LastIdInt),
	numlist(FirstIdInt,LastIdInt,ListId).

	
get_last_id(Last,LInt):-
	split_string(Last,"_","",List), % List = ["[X","INTRODUCED","N"]
	get_second_last_element(List,Element),
	number_string(LInt,Element).

%first = "[X_INTRODUCED_N_"
get_first_id(First,FInt):-
	split_string(First,"_","",List), % List = ["[X","INTRODUCED","N"]
	get_second_last_element(List,Element),
	number_string(FInt,Element).

get_second_last_element([A,_],E):-
	E = A.
get_second_last_element([_|T],E):-
	get_second_last_element(T,E).

get_last_element([A],E):-
	E = A.
get_last_element([_|T],E):-
	get_last_element(T,E).

% VINCOLO MINLIST
minlist(L,_):-
	length(L,Length),
	get_var_count(Id),
	numlist(Id, Id + Length - 2, ListIds),
	term_string(L,Tmp),
	substring(Tmp,1,4,_,NomeLista),
	get_list_variables_id(L,NomeLista,ListVariableId),
	get_list_dom(V1,V2,ListVariableId),
	stampa_defined_var_minlist(ListIds, Length,V1,V2),
	stampa_minlist_constraint(ListVariableId,ListIds),
	ordina_file_fzn.

stampa_minlist_constraint(ListVariableId,ListIds):-
	open("model.fzn", append, stream),
	stampa_minlist_constraint_loop(stream,ListVariableId,ListIds,1),
	close(stream).

% solo il primo giro
stampa_minlist_constraint_loop(_,[],_,_).
stampa_minlist_constraint_loop(Stream,[A,B|T],[A1|T1],1):-
	printf(Stream,"constraint int_min(X_INTRODUCED_%d_,X_INTRODUCED_%d_,X_INTRODUCED_%d_):: defines_var(X_INTRODUCED_%d_);\n", [B,A,A1,A1]),
	stampa_minlist_constraint_loop(Stream,T,[A1|T1],2).
stampa_minlist_constraint_loop(Stream,[A|T],[A1,B1|T1],2):-
	printf(Stream,"constraint int_min(X_INTRODUCED_%d_,X_INTRODUCED_%d_,X_INTRODUCED_%d_):: defines_var(X_INTRODUCED_%d_);\n", [A,A1,B1,B1]),
	stampa_minlist_constraint_loop(Stream,T,[B1|T1],2).

stampa_defined_var_minlist(ListIds,Length,V1,V2):-
	open("model.fzn", append, stream),
	stampa_defined_var_minlist_loop(stream, ListIds,Length,V1,V2),
	close(stream).

stampa_defined_var_minlist_loop(Stream,[A],_,_,V2):-
	printf(Stream,"var %d..%d: X_INTRODUCED_%d_ ::var_is_introduced :: is_defined_var;\n", [V2,V2,A]).
stampa_defined_var_minlist_loop(Stream,[A|T],N,V1,V2):-
	printf(Stream,"var %d..%d: X_INTRODUCED_%d_ ::var_is_introduced :: is_defined_var;\n", [V1,V2,A]),
	stampa_defined_var_minlist_loop(Stream,T,N,V1,V2).

% VINCOLO ELEMENT
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

element_loop([H|T], Index, List, Value, [Hlm|Tlm], NomeLista):-
	not(array(H)),
	Hlm = H,
	element_loop(T,Index,List,Value,Tlm, NomeLista).

element_loop([H|T],Index,List,Value,[Hlm|Tlm], NomeLista):-
	array(H),
	split_string(H,":","",SplitList),
	get_list_name_from_model(SplitList, Temp2),
	split_string(Temp2," ","",SplitList2),
	get_list_name_from_model(SplitList2, NomeLista2),
	NomeLista == NomeLista2,
	modifica_dichiarazione_array_2(H,Index,Value,NuovaDichiarazione),
	Hlm = NuovaDichiarazione,
	element_loop(T,Index,List,Value,Tlm,NomeLista).

element_loop([H|T],Index,List,Value,[Hlm|Tlm], NomeLista):-
	array(H),
	split_string(H,":","",SplitList),
	get_list_name_from_model(SplitList, Temp2),
	split_string(Temp2," ","",SplitList2),
	get_list_name_from_model(SplitList2, NomeLista2),
	NomeLista \= NomeLista2,
	Hlm = H,
	element_loop(T,Index,List,Value,Tlm, NomeLista).

modifica_dichiarazione_array_2(H,Index,Value,NuovaDichiarazione):-
	split_string(H,"=","",L1),
	get_second_element(L1,S),
	split_string(S,",","",S1),
	modifica_dichiarazione_array_loop_2(S1,Index,Value,1,ListaVariabiliModificata),
	get_first_element(L1,PrimoElemento),
	string_concat(PrimoElemento,"= ",Temp),
	crea_stringa_variabili(ListaVariabiliModificata,"",VariabiliModificateString),
	string_concat(Temp,VariabiliModificateString, NuovaDichiarazione).
	%write(NuovaDichiarazione).

crea_stringa_variabili([A],String,Result):-
	string_concat(String,A,String2),
	Result = String2.
crea_stringa_variabili([A|T], String, Result):-
	string_concat(String,A,Temp),
	crea_stringa_variabili(T, Temp, Result).

get_first_element([A|_],S):-
	S = A.

modifica_dichiarazione_array_loop_2([], _, _,_,_).

%primo elemento
modifica_dichiarazione_array_loop_2([_|T], Index, Value,Cnt,[H1|T1]):-
	Cnt == 1,
	Index == 1,
	number_string(Value,StringValue),
	string_concat("[", StringValue, Temp),
	string_concat(Temp,",",Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop_2(T,Index,Value,Cnt1,T1).

modifica_dichiarazione_array_loop_2([H|T], Index, Value,Cnt,[H1|T1]):-
	Cnt == 1,
	Index \= 1,
	string_concat(H,",",Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop_2(T,Index,Value,Cnt1,T1).

%non devo modificare l'ultimo elemento
modifica_dichiarazione_array_loop_2([H], Index, Value,Cnt,[H1]):-
	Index \= Cnt,
	H1 = H,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop_2([],Index,Value,Cnt1,[]).

% non devo modificare elementi intermedi
modifica_dichiarazione_array_loop_2([H|T], Index, Value,Cnt,[H1|T1]):-
	Cnt \= 1,
	Index \=Cnt,
	string_concat(H,",",Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop_2(T,Index,Value,Cnt1,T1).

%devo modificare l'ultimo elemento
modifica_dichiarazione_array_loop_2([_], Index, Value,Cnt,[H1]):-
	Index == Cnt,
	number_string(Value,StringValue),
	string_concat(StringValue,"];",Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop_2([],Index,Value,Cnt1,_).

% devo modificare elementi intermedi
modifica_dichiarazione_array_loop_2([_|T], Index, Value,Cnt,[H1|T1]):-
	Cnt \= 1,
	Index == Cnt,
	number_string(Value,StringValue),
	string_concat(StringValue,",",Result),
	H1 = Result,
	Cnt1 is Cnt + 1,
	modifica_dichiarazione_array_loop_2(T,Index,Value,Cnt1,T1).

get_second_element([_,B|_],S):-
	S = B.

get_list_name_from_model([_,B|_],ListName):-
	ListName = B.

array(String):-substring(String,1,5,"array").

% VINCOLO SORTED
sorted(List,SortedList):-
	get_var_count(NextValue),
	length(List,N),
	open("model.fzn",append,stream),
	printf(stream,"array [1..%d] of int: X_INTRODUCED_%d_ = [", [N,NextValue]),
	print_list_to_string(stream,List),
	printf(stream,"];\n", []),
	printf(stream,"constraint sort(X_INTRODUCED_%d_,", [NextValue]),
	term_string(SortedList,String),
	substring(String,1,4,_,S),
	write(stream,S),
	write(stream,");\n"),
	close(stream),
	ordina_file_fzn.
	
print_list_to_string(Stream,[T]):-
	printf(Stream,"%d",[T]).
print_list_to_string(Stream,[H|T]):-
	printf(Stream,"%d,",[H]),
	print_list_to_string(Stream,T).

% VINCOLO SUMLIST
sumlist(List,Sum):-
	%se Sum e' un numero
	number(Sum),
	term_string(List,Tmp),
	substring(Tmp,1,4,_,NomeLista),
	get_list_variables_id(_,NomeLista,ListVariableId),
	get_list_dom(_,_,ListVariableId),
	get_var_count(NextValue),
	open("model.fzn",append,stream),
	printf(stream,"constraint int_lin_eq(X_INTRODUCED_%d_,[",[NextValue]),
	print_list_definition(ListVariableId,stream),
	printf(stream,"],%d);\n",[Sum]),
	length(List,ListLength),
	printf(stream,"array [1..%d] of int: X_INTRODUCED_%d_ = [",[ListLength,NextValue]),
	print_list_of_ones(stream,ListLength),
	printf(stream,"];\n",[]),
	close(stream),
	ordina_file_fzn.

% se Sum non e' un numero, probabilmente lo uso come minimizzatore
sumlist(List,Sum):-
	%se Sum e' un numero
	not(number(Sum)),
	term_string(List,Tmp),
	substring(Tmp,1,4,_,NomeLista),
	get_list_variables_id(_,NomeLista,ListVariableId),
	get_list_dom(_,_,ListVariableId),
	get_var_count(NextValue),
	open("model.fzn",append,stream),
	length(List,Length),
	stampa_defined_var_sumlist(NextValue, stream, Length,ListVariableId),
	stampa_constraint_sumlist(Length,ListVariableId, stream, NextValue),
	close(stream),
	ordina_file_fzn.

stampa_defined_var_sumlist(Next,Stream,Length,ListVariableId):-
	get_list_dom(V1,V2,ListVariableId),
	get_min_sum(V1,Min,Length),
	get_max_sum(V2,Max,Length),
	printf(Stream,"var %d..%d: X_INTRODUCED_%d_ :: is_defined_var;\n",[Min,Max,Next]).

get_min_sum(V,Min,Length):-
	Min is V * Length.
get_max_sum(V,Max,Length):-
	Max is V * Length.

stampa_constraint_sumlist(Length,ListId,Stream,Next):-
	printf(Stream,"constraint int_lin_eq([",[]),
	print_list_of_ones_2(Stream,Length),
	printf(Stream,"[",[]),
	print_list_definition(ListId,Stream),
	printf(Stream,",X_INTRODUCED_%d_",[Next]),
	printf(Stream,"],0) :: defines_var(X_INTRODUCED_%d_);\n",[Next]).
	
	
print_list_definition([T],Stream):-
	printf(Stream,"X_INTRODUCED_%d_",[T]).
print_list_definition([H|T],Stream):-
	printf(Stream,"X_INTRODUCED_%d_,",[H]),
	print_list_definition(T,Stream).

print_list_of_ones(Stream,1):-
	printf(Stream,"1",[]).
print_list_of_ones(Stream,Length):-
	printf(Stream,"1,",[]),
	Length1 is Length - 1,
	print_list_of_ones(Stream,Length1).

print_list_of_ones_2(Stream,1):-
	printf(Stream,"1, -1],",[]).
print_list_of_ones_2(Stream,Length):-
	printf(Stream,"1,",[]),
	Length1 is Length - 1,
	print_list_of_ones_2(Stream,Length1).

% VINCOLO LEXICO_LE (lexico_le([1,2,3],L).)
%lexico_le(L1,L2):-
%	get_var_count(NextValue),
%	length(L2,ListLength),
%	numlist(NextValue, NextValue + ListLength * 2 - 1, ListIds),
%	open("model.fzn",append,stream),
%	print_defined_var_lexico(stream,ListIds),
	%print_constraint_lexico(stream),
%	close(stream),
%	ordina_file_fzn.

%print_defined_var_lexico(_,[]).
%print_defined_var_lexico(Stream,[H|T]):-
%	printf(Stream,"var bool: X_INTRODUCED_%d_ ::var_is_introduced :: is_defined_var;\n",[H]),
%	print_defined_var_lexico(Stream,T).
	

% MINIMIZE
minimize(labeling(_),_):-
	% al momento non devono essere stati implementati altri vincoli prima di questa istruzione. Testato con sumlist
	open("model.fzn", append, stream),
	get_var_count(Next),
	Next1 is Next - 1,
	printf(stream,"solve  minimize X_INTRODUCED_%d_;",[Next1]),
	close(stream),
	%elimino file temporanei
	delete_temp_files.

% LABELING
labeling(_):-
	open("model.fzn", append, stream),
	write(stream, "solve satisfy;\n"),
	close(stream),
	%elimino file temporanei
	delete_temp_files.

delete_temp_files:-
	delete_const_file,
	delete_temp_file,
	delete_var_file,
	delete_array_file.

delete_array_file:-
	exists("model.array"),
	delete("model.array").
delete_array_file:-
	not(exists("model.array")).

delete_const_file:-
	exists("model.const"),
	delete("model.const").
delete_const_file:-
	not(exists("model.const")).

delete_temp_file:-
	exists("model.temp"),
	delete("model.temp").
delete_temp_file:-
	not(exists("model.temp")).

delete_var_file:-
	exists("model.var"),
	delete("model.var").
delete_var_file:-
	not(exists("model.var")).

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
print_all_2([X], _) :-
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

stampa_resto([],_).

stampa_resto([H|T], StreamOut):-
	write(StreamOut, H),
	write(StreamOut, "\n"),
	stampa_resto(T, StreamOut).

variabili(String):-substring(String,1,4,"var ").
variabili(String):-
	split_string(String," ","",SplitList),
	is_array_variable(SplitList,1).

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
	name_value(UltimaDichiarazione, _,Value),
	name_value(Value, _,Value2),
	name_value(Value2,Name3,_),
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


trova_ultima_dichiarazione_loop([A,B|_],Ultima):-
	defined_var(A),
	not(defined_var(B)),
	Ultima = A.

trova_ultima_dichiarazione_loop([A],Ultima):-
	defined_var(A),
	Ultima = A.

trova_ultima_dichiarazione_loop([],Ultima):-
	Ultima = "-1".

defined_var(String):-substring(String,1,4,"var ").
defined_var(String):-
	split_string(String," ","",SplitList), %se definisce una variabile al quarto elemento trovo "int"
	is_array_variable(SplitList,1).

is_array_variable([H|_],4):- !,
	H == "int:".

is_array_variable([_|T],Cnt):-
	Cnt1 is Cnt + 1,
	is_array_variable(T,Cnt1).

is_array_from_eclipse([H|_],4):-
	H == "var".

is_array_from_eclipse([_|T],Cnt):-
	Cnt1 is Cnt + 1,
	is_array_from_eclipse(T,Cnt1).
	
	


ordina_file_fzn:-
	get_lines("model.fzn",LinesFzn),
	split_lines_to_file(LinesFzn),
	merge_files.

split_lines_to_file(Lines):-
	open("model.var", write, streamVar),
	open("model.const", write, streamConst),
	open("model.array", write, streamArray),
	split_lines_to_file_loop(Lines, streamVar, streamConst, streamArray),
	close(streamVar),
	close(streamConst),
	close(streamArray).

split_lines_to_file_loop([],_,_,_).
split_lines_to_file_loop([H|T], StreamVar, StreamConst, StreamArray):-
	decision(H, StreamVar, StreamConst, StreamArray),
	split_lines_to_file_loop(T, StreamVar, StreamConst, StreamArray).

decision(H, StreamVar, _, _):-
	variabili(H),
	printf(StreamVar,"%s\n",[H]).
decision(H, _, _,StreamArray):-
	split_string(H," ","",SplitList),
	is_array_from_eclipse(SplitList,1),
	printf(StreamArray,"%s\n",[H]).
decision(H, _, StreamConst,_):-
	split_string(H," ","",SplitList),
	is_constraint(SplitList),
	printf(StreamConst,"%s\n",[H]).

is_constraint([H|_]):-
	H == "constraint".

merge_files:-
	get_lines("model.var",LinesVar),
	get_lines("model.const",LinesConst),
	get_lines("model.array",LinesArray),
	open("model.fzn",write,streamFzn),
	write_lines_to_file(streamFzn, LinesVar),
	write_lines_to_file(streamFzn, LinesArray),
	write_lines_to_file(streamFzn, LinesConst),
	close(streamFzn).

write_lines_to_file(_,[]).
write_lines_to_file(Stream, [H|T]):-
	printf(Stream,"%s\n",[H]),
	write_lines_to_file(Stream,T).




	





	





