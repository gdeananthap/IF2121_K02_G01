:- dynamic(koordinatP/2).
:- dynamic(koordinatQ/2).

posisiP(X,Y) :-
	koordinatP(A,B),
	X =:= A,
	Y =:= B.

posisiS(X,Y) :-				/* Posisi S statik */
	X =:= 7,
	Y =:= 7.

posisiQ(X,Y) :-
	koordinatQ(A,B),
	X =:= A,
	Y =:= B.
	
posisiD(X,Y) :-				/* Posisi D statik */
	X =:= 1,				
	Y =:= 10.

tembokAtas(_,Y) :-
	Y =:= 0.
	
tembokBawah(_,Y) :-
	Y =:= 11.
	
tembokKiri(X,_) :-
	X =:= 0.
	
tembokKanan(X,_) :-
	X =:= 11.
	
tembokTengah(X,Y) :-
	X =:= 7, Y =:= 2;
	X =:= 8, Y =:= 2;
	X =:= 8, Y =:= 3;
	X =:= 5, Y =:= 5;
	X =:= 6, Y =:= 5;
	X =:= 7, Y =:= 5;
	X =:= 8, Y =:= 5;
	X =:= 3, Y =:= 8;
	X =:= 3, Y =:= 9;
	X =:= 4, Y =:= 9;
	X =:= 5, Y =:= 9.
	
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
    
initPlayer :-
	asserta(koordinatP(1,1)).
	
initQuest :-
	asserta(koordinatQ(2,6)).
	
map :-
	initQuest,
	writeC(0,0), nl, nl,
	write('Legend'), nl,
	write('P: Player'), nl,
	write('S: Store'), nl,
	write('Q: Quest'), nl,
	write('D: Dungeon Boss'), nl,!.











