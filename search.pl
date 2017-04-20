% State = state(NextPuzzle, CurrentPuzzle, Ancestor, NoStep, Cost, H)

% Test:
% 0/8/1/2/4/3/7/6/5 (BFS)
% 1/3/4/8/0/2/7/6/5 (DFS)
% 1/0/2/8/4/3/7/6/5 (BestFS)
% 8/2/1/7/5/3/0/6/4 (A*)

% Heuristic functions: h1,total Manhattan distance, and h2, number of misplaced tiles.

solve :- 
   use_module(library(heaps)),
   consult("8puzzle.pl"),
   %breadthFirstSearch(8/2/1/7/5/3/0/6/4, 1/2/3/8/0/4/7/6/5, 2000).
   %depthFirstSearch(1/3/4/8/0/2/7/6/5, 1/2/3/8/0/4/7/6/5, 1000).
   %bestFirstSearch(8/2/1/7/5/3/0/6/4, 1/2/3/8/0/4/7/6/5, 6000).
   aStar(8/2/1/7/5/3/0/6/4, 1/2/3/8/0/4/7/6/5, 200).

% Breadth-first search
breadthFirstSearch(StartPuzzle, GoalPuzzle, MaxStep) :-
   initializeBrFS(StartPuzzle, GoalPuzzle),
   stepBrFS(1, MaxStep, ProblemState),
   printSolution(StartPuzzle, GoalPuzzle, ProblemState).
   
initializeBrFS(StartPuzzle , GoalPuzzle) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   add_to_heap(Heap, 0, state(StartPuzzle, empty, [], 0, 0, 0), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalPuzzle)), 
   retractall(state(_,_,_,_,_,_)).
   
stepBrFS(N, MaxStep, false) :- N >= MaxStep, !.
stepBrFS(N, MaxStep, ProblemState) :-
   getBrFS(State), !,
   assert(State),
   checkCurrentStateBrFS(N, MaxStep, ProblemState, State).
stepBrFS(_, _, false).

getBrFS(State) :-
   b_getval(fringe, H),
   get_from_heap(H, N, State, H1),
   extract(State, NextP),
   write("test: "), write(NextP), write(" - "), write(N) , nl,
   b_setval(fringe, H1).
   
checkCurrentStateBrFS(_, _, true, State) :-
   checkGoal(State, true).
checkCurrentStateBrFS(N, MaxStep, ProblemState, State) :-
   extend(State, NextStateList),
   addToFringeBrFS(NextStateList, N),
   N1 is N + 1,
   stepBrFS(N1, MaxStep, ProblemState).
   
addToFringeBrFS([], _).
addToFringeBrFS([state(NextPuzzle, Puzzle, A, NoStep, Distance, X)|T], N) :-
   b_getval(fringe, Heap),
   add_to_heap(Heap, NoStep, state(NextPuzzle, Puzzle, A, NoStep, Distance, X), Heap1),
   b_setval(fringe, Heap1),
   addToFringeBrFS(T, N).
   

% Depth-first search
depthFirstSearch(StartPuzzle, GoalPuzzle, MaxStep) :-
   initializeDFS(StartPuzzle, GoalPuzzle),
   stepDFS(1, MaxStep, ProblemState),
   printSolution(StartPuzzle, GoalPuzzle, ProblemState).

initializeDFS(StartPuzzle, GoalPuzzle) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   add_to_heap(Heap, 0, state(StartPuzzle, empty, [], 0, 0, 0), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalPuzzle)), 
   retractall(state(_,_,_,_,_,_)).

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
   extract(State, NextP),
   write("test: "), write(NextP), write(" - "), write(N) , nl,
   b_setval(fringe, H1).

addToFringeDFS([], _).
addToFringeDFS([state(NextPuzzle, Puzzle, A, NoStep, Distance, X)|T], N) :-
   b_getval(fringe, Heap),
   Priority is 10000 - NoStep,
   add_to_heap(Heap, Priority, state(NextPuzzle, Puzzle, A, NoStep, Distance, X), Heap1),
   b_setval(fringe, Heap1),
   addToFringeDFS(T, N).   


% Best-first search
bestFirstSearch(StartPuzzle, GoalPuzzle, MaxStep) :-
   initializeBestFS(StartPuzzle, GoalPuzzle),
   stepBestFS(1, MaxStep, ProblemState),
   printSolution(StartPuzzle, GoalPuzzle, ProblemState).

initializeBestFS(StartPuzzle, GoalPuzzle) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   h(state(StartPuzzle, empty, [], 0, 0, Hvalue)),
   Priority is Hvalue,	
   add_to_heap(Heap, Priority, state(StartPuzzle, empty, [], 0, 0, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalPuzzle)), 
   retractall(state(_,_,_,_,_,_)).

stepBestFS(N, MaxStep, false) :- N >= MaxStep, 
   % too far away !!!
   !.
stepBestFS(N, MaxStep, ProblemState) :-
   getBestFS(State), !,
   assert(State),
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
   extract(State, NextP),
   write("test: "), write(NextP), write(" - "), write(N) , nl,
   b_setval(fringe, H1).

addToFringeBestFS([], _).
addToFringeBestFS([state(NextPuzzle, Puzzle, A, NoStep, Distance, _)|T], N) :-
   b_getval(fringe, Heap),
   h(state(NextPuzzle, Puzzle, A, NoStep, Distance, Hvalue)),
   Priority is Hvalue,
   add_to_heap(Heap, Priority, state(NextPuzzle, Puzzle, A, NoStep, Distance, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   addToFringeBestFS(T, N).
   

% A*   
aStar(StartPuzzle, GoalPuzzle, MaxStep) :-
   initializeAStar(StartPuzzle, GoalPuzzle),
   stepAStar(1, MaxStep, ProblemState),
   printSolution(StartPuzzle, GoalPuzzle, ProblemState).

initializeAStar(StartPuzzle, GoalPuzzle) :-
   % add the Start state to the fringe
   empty_heap(Heap),
   h(state(StartPuzzle, empty, [], 0, 0, Hvalue)),
   Priority is 0 + Hvalue,	% cost is 0
   add_to_heap(Heap, Priority, state(StartPuzzle, empty, [], 0, 0, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   % add the Goal state
   retractall(goalState(_)),
   assert(goalState(GoalPuzzle)), 
   retractall(state(_,_,_,_,_,_)).

stepAStar(N, MaxStep, false) :- N >= MaxStep, 
   % too far away !!!
   !.
stepAStar(N, MaxStep, ProblemState) :-
   getAStar(State), !,
   assert(State),
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
   extract(State, NextP),
   write("test: "), write(NextP), write(" - "), write(N) , nl,
   b_setval(fringe, H1).

addToFringeAStar([], _).
addToFringeAStar([state(NextPuzzle, Puzzle, A, NoStep, Distance, _)|T], N) :-
   b_getval(fringe, Heap),
   h(state(NextPuzzle, Puzzle, A, NoStep, Distance, Hvalue)),
   Priority is Distance + Hvalue,
   add_to_heap(Heap, Priority, state(NextPuzzle, Puzzle, A, NoStep, Distance, Hvalue), Heap1),
   b_setval(fringe, Heap1),
   addToFringeAStar(T, N).




checkGoal(state(Puzzle,_,_,_,_,_), true) :- goalState(Puzzle).
   
extend(state(Puzzle, _, A, NoStep, Cost, _), StateList1) :-
   NoStep1 is NoStep + 1,
   insert(Puzzle, A, A1),
   findall(state(NextPuzzle, Puzzle, A1, NoStep1, Distance, 0), (link(Puzzle, NextPuzzle, Distance), notIn(NextPuzzle, A)), StateList),
   adjustCost(StateList, Cost, StateList1).

adjustCost([], _, []).
adjustCost([state(NextPuzzle, Puzzle, A, NoStep, Distance, X)|T], CostFromParent, [state(NextPuzzle, Puzzle, A, NoStep, Cost, X)|T1]) :-
   Cost is CostFromParent + Distance,
   adjustCost(T, CostFromParent, T1).
   
printSolution(Start, Goal, ProblemState) :-
   write("Cost: "),
   state(Goal, _, _, _, Cost, _),
   write(Cost), write(" - Path: "),
   print(Start, Goal, ProblemState), nl.
print(Start, Start, _) :-
   write("- "), write(Start).
print(Start, Puzzle, ProblemState) :-
   state(Puzzle, ParentPuzzle, _, _, _, _),
   print(Start, ParentPuzzle, ProblemState),
   write(" - "), write(Puzzle).

