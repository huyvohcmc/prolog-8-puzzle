link(Puzzle1, Puzzle2, Cost) :-
   linkOneWay(Puzzle1, Puzzle2, Cost).
   
linkOneWay( A/0/C/D/E/F/H/I/J , 0/A/C/D/E/F/H/I/J , 1).
linkOneWay( A/B/C/D/0/F/H/I/J , A/B/C/0/D/F/H/I/J , 1).
linkOneWay( A/B/C/D/E/F/H/0/J , A/B/C/D/E/F/0/H/J , 1).
linkOneWay( A/B/0/D/E/F/H/I/J , A/0/B/D/E/F/H/I/J , 1).
linkOneWay( A/B/C/D/E/0/H/I/J , A/B/C/D/0/E/H/I/J , 1).
linkOneWay( A/B/C/D/E/F/H/I/0 , A/B/C/D/E/F/H/0/I , 1).

linkOneWay( A/B/C/0/E/F/H/I/J , 0/B/C/A/E/F/H/I/J , 1).
linkOneWay( A/B/C/D/0/F/H/I/J , A/0/C/D/B/F/H/I/J , 1).
linkOneWay( A/B/C/D/E/0/H/I/J , A/B/0/D/E/C/H/I/J , 1).
linkOneWay( A/B/C/D/E/F/0/I/J , A/B/C/0/E/F/D/I/J , 1).
linkOneWay( A/B/C/D/E/F/H/0/J , A/B/C/D/0/F/H/E/J , 1).
linkOneWay( A/B/C/D/E/F/H/I/0 , A/B/C/D/E/0/H/I/F , 1).

linkOneWay( A/0/C/D/E/F/H/I/J , A/C/0/D/E/F/H/I/J , 1).
linkOneWay( A/B/C/D/0/F/H/I/J , A/B/C/D/F/0/H/I/J , 1).
linkOneWay( A/B/C/D/E/F/H/0/J , A/B/C/D/E/F/H/J/0 , 1).
linkOneWay( 0/B/C/D/E/F/H/I/J , B/0/C/D/E/F/H/I/J , 1).
linkOneWay( A/B/C/0/E/F/H/I/J , A/B/C/E/0/F/H/I/J , 1).
linkOneWay( A/B/C/D/E/F/0/I/J , A/B/C/D/E/F/I/0/J , 1).

linkOneWay( A/B/C/0/E/F/H/I/J , A/B/C/H/E/F/0/I/J , 1).
linkOneWay( A/B/C/D/0/F/H/I/J , A/B/C/D/I/F/H/0/J , 1).
linkOneWay( A/B/C/D/E/0/H/I/J , A/B/C/D/E/J/H/I/0 , 1).
linkOneWay( 0/B/C/D/E/F/H/I/J , D/B/C/0/E/F/H/I/J , 1).
linkOneWay( A/0/C/D/E/F/H/I/J , A/E/C/D/0/F/H/I/J , 1).
linkOneWay( A/B/0/D/E/F/H/I/J , A/B/F/D/E/0/H/I/J , 1).

extract(state(NextP,_,_,_,_,_), NextP).

notIn(_, []).
notIn(P, [P1|R]) :- P \= P1, notIn(P, R).

repeat(P, [P|_]).

insert(P, A, A) :- repeat(P, A), !.
insert(P, [P1|R], [P1|S]) :- insert(P, R, S), !.
insert(P, [], [P]).

