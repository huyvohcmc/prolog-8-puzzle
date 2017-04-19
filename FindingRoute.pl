% A Prolog progam to declase the Finding Route problem
link(City1, City2, Cost) :- 
   linkOneWay(City1, City2, Cost).
link(City1, City2, Cost) :- 
   linkOneWay(City2, City1, Cost).

linkOneWay(city("Arad"), city("Zerind"), 75).
linkOneWay(city("Sibiu"), city("Arad"), 140).
linkOneWay(city("Arad"), city("Timisoara"), 118).
linkOneWay(city("Zerind"), city("Oradea"), 71).
linkOneWay(city("Oradea"), city("Sibiu"), 151).
linkOneWay(city("Sibiu"), city("Fagaras"), 99).
linkOneWay(city("Sibiu"), city("Rimicu Vilcea"), 80).
linkOneWay(city("Timisoara"), city("Lugoj"), 111).
linkOneWay(city("Lugoj"), city("Mehadia"), 70).
linkOneWay(city("Mehadia"), city("Dobreta"), 75).
linkOneWay(city("Dobreta"), city("Craiova"), 120).
linkOneWay(city("Craiova"), city("Pitesti"), 138).
linkOneWay(city("Rimicu Vilcea"), city("Pitesti"), 97).
linkOneWay(city("Fagaras"), city("Bucarest"), 211).
linkOneWay(city("Pitesti"), city("Bucarest"), 101).
linkOneWay(city("Glurgiu"), city("Bucarest"), 90).
linkOneWay(city("Urziceni"), city("Bucarest"), 185).
linkOneWay(city("Urziceni"), city("Hirsova"), 98).
linkOneWay(city("Urziceni"), city("Vasiui"), 142).
linkOneWay(city("Eforie"), city("Hirsova"), 86).
linkOneWay(city("Iasi"), city("Vasiui"), 92).
linkOneWay(city("Iasi"), city("Neamt"), 87).

h(City1, City2, Hvalue) :- hSLD(City1, City2, Hvalue).

hSLD(city("Arad"), city("Bucarest"), 366).
hSLD(city("Bucarest"), city("Bucarest"), 0).
hSLD(city("Craiova"), city("Bucarest"), 160).
hSLD(city("Dobreta"), city("Bucarest"), 242).
hSLD(city("Eforie"), city("Bucarest"), 161).
hSLD(city("Fagaras"), city("Bucarest"), 176).
hSLD(city("Glurgiu"), city("Bucarest"), 77).
hSLD(city("Hirsova"), city("Bucarest"), 151).
hSLD(city("Iasi"), city("Bucarest"), 226).
hSLD(city("Lugoj"), city("Bucarest"), 244).
hSLD(city("Mehadia"), city("Bucarest"), 241).
hSLD(city("Neamt"), city("Bucarest"), 234).
hSLD(city("Oradea"), city("Bucarest"), 380).
hSLD(city("Pitesti"), city("Bucarest"), 10).
hSLD(city("Rimicu Vilcea"), city("Bucarest"), 193).
hSLD(city("Sibiu"), city("Bucarest"), 253).
hSLD(city("Timisoara"), city("Bucarest"), 329).
hSLD(city("Urziceni"), city("Bucarest"), 80).
hSLD(city("Vasiui"), city("Bucarest"), 199).
hSLD(city("Zerind"), city("Bucarest"), 374).
