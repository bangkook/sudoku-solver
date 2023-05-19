%:- initialization(main).


solve(Rows) :-
    	maplist(in_domain, Rows),
    	maplist(all_distinct, Rows),
	transpose(Rows, Columns),
	maplist(all_distinct, Columns),
	Rows = [A,B,C,D,E,F,G,H,I],
        blocks(A, B, C), 
	blocks(D, E, F), 
	blocks(G, H, I),
	maplist(fd_labeling, Rows).

% in_domain([], X, Y). % member in domain
% in_domain([H|T]) :- member2(H, [1, 2, 3, 4, 5, 6, 7, 8, 9]), in_domain(T).

in_domain(Row) :- fd_domain(Row, 1, 9).

%member2(X,[X|_]).
%member2(X,[_|Xs]) :- member2(X,Xs).

% all_distinct([]).
all_distinct(List) :- fd_all_different(List).

transpose([], []).
transpose([F|Fs], Ts) :-
        transpose([F|Fs], F, Ts).

transpose(_, [], []).
transpose(M, [_|R], [Ts|Tss]) :-
        insert(M, Ts, Ms),
        transpose(Ms, R, Tss).

insert([], [], []).
insert([[F|Fs]|Rest], [F|Ts], [Fs|Fss]) :-
        insert(Rest, Ts, Fss).

blocks([], [], []).
blocks([A, B, C|Bs1], [D, E, F|Bs2], [G, H, I|Bs3]) :-
	all_distinct([A, B, C, D, E, F, G, H, I]),
	blocks(Bs1, Bs2, Bs3).  

% tests
/*test([ [5,1,6,8,4,9,7,3,2]
     , [3,_,7,6,_,5,_,_,_]
     , [8,_,9,7,_,_,_,6,5]
     , [1,3,5,_,6,_,9,_,7]
     , [4,7,2,5,9,1,_,_,6]
     , [9,6,8,3,7,_,_,5,_]
     , [2,5,3,1,8,6,_,7,4]
     , [6,8,4,2,_,7,5,_,_]
     , [7,9,1,_,5,_,6,_,8]
     ]).*/

test([[_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,3,_,8,5],
        [_,_,1,_,2,_,_,_,_],
        [_,_,_,5,_,7,_,_,_],
        [_,_,4,_,_,_,1,_,_],
        [_,9,_,_,_,_,_,_,_],
        [5,_,_,_,_,_,_,7,3],
        [_,_,2,_,1,_,_,_,_],
        [_,_,_,_,4,_,_,_,9]]).

%main :- test(T), solve(T), maplist(show,T).
show(X) :- write(X), nl.