% A Prolog program for State Space Search.

% To run this problem, please start swi-prolog.
% At the prompt ?- type in "solve." as
% follows:
%         | ?- [solve].

% To quit Prolog, type "halt." at ?-
% You may interrupt the execution by typing Ctrl-C and then "a" for abort.

solve :- 
   use_module(library(heaps)),
   consult("FindingRoute.pl"),
   %breadthFirstSearch(city("Arad"), city("Bucarest"), 100).
   depthFirstSearch(city("Arad"), city("Bucarest"), 100).
   %bestFirstSearch(city("Arad"), city("Bucarest"), 100).
   %aStar(city("Arad"), city("Bucarest"), 100).

% Breath-First Search
breadthFirstSearch(StartCity, GoalCity, MaxStep) :-
   initializeBrFS(StartCity, GoalCity),
   stepBrFS(1, MaxStep, ProblemState),
   printSolution(StartCity, GoalCity, ProblemState).

initializeBrFS(StartCity , GoalCity) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   add_to_heap(Heap, 0, state(StartCity, empty, 0, 0, 0), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalCity)), 
   retractall(state(_,_,_,_,_)).

stepBrFS(N, MaxStep, false) :- N >= MaxStep, 
   % too far away !!!
   !.
stepBrFS(N, MaxStep, ProblemState) :-
   getBrFS(State), !,
   assert(State),
   checkCurrentStateBrFS(N, MaxStep, ProblemState, State).
stepBrFS(_, _, false).
   % no next state --> fringe is empty

checkCurrentStateBrFS(_, _, true, State) :-
   checkGoal(State, true).
checkCurrentStateBrFS(N, MaxStep, ProblemState, State) :-
   extend(State, NextStateList),
   addToFringeBrFS(NextStateList, N),
   N1 is N + 1,
   stepBrFS(N1, MaxStep, ProblemState).

getBrFS(State) :-
   b_getval(fringe, H),
   get_from_heap(H, N, State, H1),
   write("test: "), write(State), write(" - "), write(N) , nl,
   b_setval(fringe, H1).

addToFringeBrFS([], _).
addToFringeBrFS([state(NextCity, City, NoStep, Distance, X)|T], N) :-
   b_getval(fringe, Heap),
   add_to_heap(Heap, NoStep, state(NextCity, City, NoStep, Distance, X), Heap1),
   b_setval(fringe, Heap1),
   addToFringeBrFS(T, N).

% Depth-First Search

depthFirstSearch(StartCity, GoalCity, MaxStep) :-
   initializeDFS(StartCity, GoalCity),
   stepDFS(1, MaxStep, ProblemState),
   printSolution(StartCity, GoalCity, ProblemState).

initializeDFS(StartCity , GoalCity) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   add_to_heap(Heap, 0, state(StartCity, empty, 0, 0, 0), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalCity)), 
   retractall(state(_,_,_,_,_)).

stepDFS(N, MaxStep, false) :- N >= MaxStep, 
   % too far away !!!
   !.
stepDFS(N, MaxStep, ProblemState) :-
   getDFS(State), !,
   assert(State),
   checkCurrentStateDFS(N, MaxStep, ProblemState, State).
stepDFS(_, _, false).
   % no next state --> fringe is empty

checkCurrentStateDFS(_, _, true, State) :-
   checkGoal(State, true).
checkCurrentStateDFS(N, MaxStep, ProblemState, State) :-
   extend(State, NextStateList),
   addToFringeDFS(NextStateList, N),
   N1 is N + 1,
   stepDFS(N1, MaxStep, ProblemState).

getDFS(State) :-
   b_getval(fringe, H),
   get_from_heap(H, N, State, H1),
   write("test: "), write(State), write(" - "), write(N) , nl,
   b_setval(fringe, H1).

addToFringeDFS([], _).
addToFringeDFS([state(NextCity, City, NoStep, Distance, X)|T], N) :-
   b_getval(fringe, Heap),
   Priority is 10000 - NoStep,
   add_to_heap(Heap, Priority, state(NextCity, City, NoStep, Distance, X), Heap1),
   b_setval(fringe, Heap1),
   addToFringeDFS(T, N).

%Best First-Search
bestFirstSearch(StartCity, GoalCity, MaxStep) :-
   initializeBestFS(StartCity, GoalCity),
   stepBestFS(1, MaxStep, ProblemState),
   printSolution(StartCity, GoalCity, ProblemState).

initializeBestFS(StartCity, GoalCity) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   h(StartCity, GoalCity, Hvalue),
   Priority is Hvalue,	
   add_to_heap(Heap, Priority, state(StartCity, empty, 0, 0, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalCity)), 
   retractall(state(_,_,_,_,_)).

stepBestFS(N, MaxStep, false) :- N >= MaxStep, 
   % too far away !!!
   !.
stepBestFS(N, MaxStep, ProblemState) :-
   getBestFS(State), !,
   assert(State),
   %write("test: "), write(State), nl,
   checkCurrentStateBestFS(N, MaxStep, ProblemState, State).
stepBestFS(_, _, false).
   % no next state --> fringe is empty

checkCurrentStateBestFS(_, _, true, State) :-
   checkGoal(State, true).
checkCurrentStateBestFS(N, MaxStep, ProblemState, State) :-
   extend(State, NextStateList),
   addToFringeBestFS(NextStateList, N),
   N1 is N + 1,
   stepBestFS(N1, MaxStep, ProblemState).

getBestFS(State) :-
   b_getval(fringe, H),
   get_from_heap(H, N, State, H1),
   write("test: "), write(State), write(" - "), write(N) , nl,
   b_setval(fringe, H1).

addToFringeBestFS([], _).
addToFringeBestFS([state(NextCity, City, NoStep, Distance, _)|T], N) :-
   b_getval(fringe, Heap),
   goalState(GoalCity),
   h(NextCity, GoalCity, Hvalue),
   Priority is Hvalue,
   add_to_heap(Heap, Priority, state(NextCity, City, NoStep, Distance, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   addToFringeBestFS(T, N).

%A*
aStar(StartCity, GoalCity, MaxStep) :-
   initializeAStar(StartCity, GoalCity),
   stepAStar(1, MaxStep, ProblemState),
   printSolution(StartCity, GoalCity, ProblemState).

initializeAStar(StartCity, GoalCity) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   h(StartCity, GoalCity, Hvalue),
   Priority is 0 + Hvalue,	% cost is 0
   add_to_heap(Heap, Priority, state(StartCity, empty, 0, 0, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalCity)), 
   retractall(state(_,_,_,_,_)).

stepAStar(N, MaxStep, false) :- N >= MaxStep, 
   % too far away !!!
   !.
stepAStar(N, MaxStep, ProblemState) :-
   getAStar(State), !,
   assert(State),
   %write("test: "), write(State), nl,
   checkCurrentStateAStar(N, MaxStep, ProblemState, State).
stepAStar(_, _, false).
   % no next state --> fringe is empty

checkCurrentStateAStar(_, _, true, State) :-
   checkGoal(State, true).
checkCurrentStateAStar(N, MaxStep, ProblemState, State) :-
   extend(State, NextStateList),
   addToFringeAStar(NextStateList, N),
   N1 is N + 1,
   stepAStar(N1, MaxStep, ProblemState).

getAStar(State) :-
   b_getval(fringe, H),
   get_from_heap(H, N, State, H1),
   write("test: "), write(State), write(" - "), write(N) , nl,
   b_setval(fringe, H1).

addToFringeAStar([], _).
addToFringeAStar([state(NextCity, City, NoStep, Distance, _)|T], N) :-
   b_getval(fringe, Heap),
   goalState(GoalCity),
   h(NextCity, GoalCity, Hvalue),
   Priority is Distance + Hvalue,
   add_to_heap(Heap, Priority, state(NextCity, City, NoStep, Distance, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   addToFringeAStar(T, N).





checkGoal(state(City,_,_,_,_), true) :-
   goalState(City).

extend(state(City, _, NoStep, Cost, _), StateList1) :-
   NoStep1 is NoStep + 1,
   findall(state(NextCity, City, NoStep1, Distance, 0), link(City, NextCity, Distance), StateList),
   adjustCost(StateList, Cost, StateList1).

adjustCost([], _, []).
adjustCost([state(NextCity, City, NoStep, Distance, X)|T], CostFromParent, [state(NextCity, City, NoStep, Cost, X)|T1]) :-
   Cost is CostFromParent + Distance,
   adjustCost(T, CostFromParent, T1).

printSolutionSimple(Start, Goal, ProblemState):-
   write(Start), write(" - "), write(Goal), write(": "), write(ProblemState).

printSolution(Start, Goal, ProblemState):-
   write("Cost: "),
   state(Goal, _, _, Cost, _),
   write(Cost), write(" - Path: "),
   printSolution1(Start, Goal, ProblemState), nl.

printSolution1(Start, Start, _):-
   write("- "), write(Start).
printSolution1(Start, City, ProblemState):-
   state(City, ParentCity, _, _, _),
   printSolution1(Start, ParentCity, ProblemState),
   write(" - "), write(City).
