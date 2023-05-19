:- use_module(library(clpfd)).

sudoku(Rows) :-
    length(Rows, 9),
    maplist(same_length(Rows), Rows),
    append(Rows, Vars),
    in_domain(Vars, 1, 9),  % Specify the domain manually
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [A, B, C, D, E, F, G, H, I],
    blocks(A, B, C), 
	blocks(D, E, F), 
	blocks(G, H, I).

blocks([], [], []).
blocks([A, B, C|Bs1], [D, E, F|Bs2], [G, H, I|Bs3]) :-
	all_distinct([A, B, C, D, E, F, G, H, I]),
	blocks(Bs1, Bs2, Bs3).

% Manual domain specification
in_domain([], _, _).
in_domain([V|Vs], Min, Max) :-
    V in Min..Max,
    in_domain(Vs, Min, Max).

% Example puzzle
example([[5,3,_,_,7,_,_,_,_],
         [6,_,_,1,9,5,_,_,_],
         [_,9,8,_,_,_,_,6,_],
         [8,_,_,_,6,_,_,_,3],
         [4,_,_,8,_,3,_,_,1],
         [7,_,_,_,2,_,_,_,6],
         [_,6,_,_,_,_,2,8,_],
         [_,_,_,4,1,9,_,_,5],
         [_,_,_,_,8,_,_,7,9]]).

% Solve and display the puzzle
solve_sudoku :-
    example(Puzzle),
    sudoku(Puzzle),
    maplist(writeln, Puzzle).