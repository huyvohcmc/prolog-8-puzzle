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


h(state(P,_,_,_,_,Hvalue)) :- h2(state(P,_,_,_,_,Hvalue)).
h1(state(P,_,_,_,_,Hvalue)) :- manhattan(P, Hvalue).
h2(state(P,_,_,_,_,Hvalue)) :- misplaced_tiles(P, Hvalue).

manhattan(A/B/C/D/E/F/G/H/I, P) :-
    a(A,Pa), b(B,Pb), c(C,Pc),
    d(D,Pd), e(E,Pe), f(F,Pf),
    g(G,Pg), h(H,Ph), i(I,Pi),
    P is Pa+Pb+Pc+Pd+Pe+Pf+Pg+Ph+Pg+Pi.
    
misplaced_tiles(A/B/C/D/E/F/G/H/I, P) :- 
    ma(A,Pa), mb(B,Pb), mc(C,Pc),
    md(D,Pd), me(E,Pe), mf(F,Pf),
    mg(G,Pg), mh(H,Ph), mi(I,Pi),
    P is Pa+Pb+Pc+Pd+Pe+Pf+Pg+Ph+Pg+Pi.
 
a(0,0). a(1,0). a(2,1). a(3,2). a(4,3). a(5,4). a(6,3). a(7,2). a(8,1).
b(0,0). b(1,0). b(2,0). b(3,1). b(4,2). b(5,3). b(6,2). b(7,3). b(8,2).
c(0,0). c(1,2). c(2,1). c(3,0). c(4,1). c(5,2). c(6,3). c(7,4). c(8,3).
d(0,0). d(1,1). d(2,2). d(3,3). d(4,2). d(5,3). d(6,2). d(7,2). d(8,0).
e(0,0). e(1,2). e(2,1). e(3,2). e(4,1). e(5,2). e(6,1). e(7,2). e(8,1).
f(0,0). f(1,3). f(2,2). f(3,1). f(4,0). f(5,1). f(6,2). f(7,3). f(8,2).
g(0,0). g(1,2). g(2,3). g(3,4). g(4,3). g(5,2). g(6,2). g(7,0). g(8,1).
h(0,0). h(1,3). h(2,3). h(3,3). h(4,2). h(5,1). h(6,0). h(7,1). h(8,2).
i(0,0). i(1,4). i(2,3). i(3,2). i(4,1). i(5,0). i(6,1). i(7,2). i(8,3).

ma(0,0). ma(1,0). ma(2,1). ma(3,1). ma(4,1). ma(5,1). ma(6,1). ma(7,1). ma(8,1).
mb(0,0). mb(1,1). mb(2,0). mb(3,1). mb(4,1). mb(5,1). mb(6,1). mb(7,1). mb(8,1).
mc(0,0). mc(1,1). mc(2,1). mc(3,0). mc(4,1). mc(5,1). mc(6,1). mc(7,1). mc(8,1).
md(0,0). md(1,1). md(2,1). md(3,1). md(4,1). md(5,1). md(6,1). md(7,1). md(8,0).
me(0,0). me(1,1). me(2,1). me(3,1). me(4,1). me(5,1). me(6,1). me(7,1). me(8,1).
mf(0,0). mf(1,1). mf(2,1). mf(3,1). mf(4,0). mf(5,1). mf(6,1). mf(7,1). mf(8,1).
mg(0,0). mg(1,1). mg(2,1). mg(3,1). mg(4,1). mg(5,1). mg(6,1). mg(7,0). mg(8,1).
mh(0,0). mh(1,1). mh(2,1). mh(3,1). mh(4,1). mh(5,1). mh(6,0). mh(7,1). mh(8,1).
mi(0,0). mi(1,1). mi(2,1). mi(3,1). mi(4,1). mi(5,0). mi(6,1). mi(7,1). mi(8,1). 





extract(state(NextP,_,_,_,_,_), NextP).

notIn(_, []).
notIn(P, [P1|R]) :- P \= P1, notIn(P, R).

repeat(P, [P|_]).

insert(P, A, A) :- repeat(P, A), !.
insert(P, [P1|R], [P1|S]) :- insert(P, R, S), !.
insert(P, [], [P]).

