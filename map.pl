:- dynamic(koordinatP/2).
:- dynamic(koordinatS/2).
:- dynamic(koordinatQ/2).
:- dynamic(koordinatD/2).
:- dynamic(dimensi/2).
:- dynamic(tembok/2).

posisiP(X,Y) :-
	koordinatP(A,B),
	X =:= A,
	Y =:= B.

posisiS(X,Y) :-				/* Posisi S statik */
	koordinatS(A,B),
	X =:= A,
	Y =:= B.

posisiQ(X,Y) :-
	koordinatQ(A,B),
	X =:= A,
	Y =:= B.
	
posisiD(X,Y) :-				/* Posisi D statik */
	koordinatD(A,B),
	X =:= A,				
	Y =:= B.

tembokAtas(_,Y) :-
	Y =:= 0.
	
tembokBawah(_,Y) :-
	dimensi(_,B),
	Y =:= B+1.
	
tembokKiri(X,_) :-
	X =:= 0.
	
tembokKanan(X,_) :-
	dimensi(A,_),
	X =:= A+1.
	
tembokTengah(X,Y) :-
	tembok(A,B),
	X =:= A,
	Y =:= B.
	
writeC(X,Y) :-				/* Output sampai di akhir map (selesai) */
	tembokKanan(X,Y),
	tembokBawah(X,Y),
	write('#').
	
writeC(X,Y) :-
	posisiP(X,Y),
	write('P'),
	writeC(X+1,Y).
	
writeC(X,Y) :-
	posisiS(X,Y),
	write('S'),
	writeC(X+1,Y).
	
writeC(X,Y) :-
	posisiQ(X,Y),
	write('Q'),
	writeC(X+1,Y).

writeC(X,Y) :-
	posisiD(X,Y),
	write('D'),
	writeC(X+1,Y).

writeC(X,Y) :-
	tembokTengah(X,Y),
	write('#'),
	writeC(X+1,Y).

writeC(X,Y) :-
	tembokBawah(X,Y),
	write('#'),
	writeC(X+1,Y).

writeC(X,Y) :-
	tembokKanan(X,Y),
	write('#'), 
	nl,
	writeC(0,Y+1).

writeC(X,Y) :-
	tembokAtas(X,Y),
	write('#'),
	writeC(X+1,Y).

writeC(X,Y) :-
	tembokKiri(X,Y),
	write('#'),
	writeC(X+1,Y).

writeC(X,Y) :-
    write('-'),
    writeC(X+1,Y).
  
generateTembok :-
	dimensi(A,B),
	A1 is A-1,
	B1 is B-1,
	random(2,A1,X),
	random(2,B1,Y),
	asserta(tembok(X,Y)).
  
initTembok :-
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok.
	
initDimensi :-
	random(10,20,Lebar),
	random(10,20,Panjang),
	asserta(dimensi(Lebar,Panjang)).

initStore :-
	dimensi(A,B),
	random(2,A,X),
	random(2,B,Y),
	asserta(koordinatS(X,Y)).

initQuest :-
	dimensi(A,B),
	random(2,A,X),
	random(2,B,Y),
	asserta(koordinatQ(X,Y)).

initDungeon :-
	dimensi(A,B),
	random(2,A,X),
	random(2,B,Y),
	asserta(koordinatD(X,Y)).

initMap :-
	initDimensi,
	initStore,
	initDungeon,
	initQuest,
	initTembok.
