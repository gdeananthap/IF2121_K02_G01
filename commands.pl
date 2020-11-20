	
start :-
	initMap,
	initPlayer.

d :-
	koordinatP(X,Y),
	\+tembokKanan(X+1,Y),
	\+tembokTengah(X+1,Y),
	\+posisiS(X+1,Y),
	\+posisiQ(X+1,Y),
	\+posisiD(X+1,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X+1,Y)),
	write('Kamu bergerak satu petak ke kanan.'),!.
	
d :-
	koordinatP(X,Y),
	posisiS(X+1,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X+1,Y)),
	write('Kamu berada di Store.'),!.
	
d :-
	koordinatP(X,Y),
	posisiQ(X+1,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X+1,Y)),
	write('Kamu menemui sebuah Quest!'),!.
	
d :-
	koordinatP(X,Y),
	(
	tembokKanan(X+1,Y); 
	tembokTengah(X+1,Y)),
	write('Kamu nabrak tembok...'),!.
	
a :-
	koordinatP(X,Y),
	\+tembokKiri(X-1,Y),
	\+tembokTengah(X-1,Y),
	\+posisiS(X-1,Y),
	\+posisiQ(X-1,Y),
	\+posisiD(X-1,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X-1,Y)),
	write('Kamu bergerak satu petak ke kiri.'),!.
	
a :-
	koordinatP(X,Y),
	posisiS(X-1,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X-1,Y)),
	write('Kamu berada di Store.'),!.
	
a :-
	koordinatP(X,Y),
	posisiQ(X-1,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X-1,Y)),
	write('Kamu menemui sebuah Quest!'),!.
	
a :-
	koordinatP(X,Y),
	(
	tembokKiri(X-1,Y);
	tembokTengah(X-1,Y)
	),
	write('Kamu nabrak tembok...'),!.

w :-
	koordinatP(X,Y),
	\+tembokAtas(X,Y-1),
	\+tembokTengah(X,Y-1),
	\+posisiS(X,Y-1),
	\+posisiQ(X,Y-1),
	\+posisiD(X,Y-1),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y-1)),
	write('Kamu bergerak satu petak ke atas.'),!.
	
w :-
	koordinatP(X,Y),
	posisiS(X,Y-1),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y-1)),
	write('Kamu berada di Store.'),!.
	
w :-
	koordinatP(X,Y),
	posisiQ(X,Y-1),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y-1)),
	write('Kamu menemui sebuah Quest!'),!.
	
w :-
	koordinatP(X,Y),
	(
	tembokAtas(X,Y-1);
	tembokTengah(X,Y-1)
	),
	write('Kamu nabrak tembok...'),!.
	
s :-
	koordinatP(X,Y),
	\+tembokBawah(X,Y+1),
	\+tembokTengah(X,Y+1),
	\+posisiS(X,Y+1),
	\+posisiQ(X,Y+1),
	\+posisiD(X,Y+1),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y+1)),
	write('Kamu bergerak satu petak ke bawah.'),!.
	
s :-
	koordinatP(X,Y),
	posisiS(X,Y+1),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y+1)),
	write('Kamu berada di Store.'),!.
	
s :-
	koordinatP(X,Y),
	posisiQ(X,Y+1),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y+1)),
	write('Kamu menemui sebuah Quest!'),!.
	
s :-
	koordinatP(X,Y),
	(
	tembokAtas(X,Y+1);
	tembokTengah(X,Y+1)
	),
	write('Kamu nabrak tembok...'),!.
	
teleportation_scroll(X,Y) :-
	\+tembokBawah(X,Y),
	\+tembokAtas(X,Y),
	\+tembokKiri(X,Y),
	\+tembokKanan(X,Y),
	\+tembokTengah(X,Y),
	\+posisiS(X,Y),
	\+posisiQ(X,Y),
	\+posisiD(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Teleportasi berhasil.'),!.
	
teleportation_scroll(X,Y) :-
	posisiS(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Teleportasi berhasil. Kamu berada di Store.'),!.
	
teleportation_scroll(X,Y) :-
	posisiQ(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Teleportasi berhasil. Kamu berada di Quest.'),!.
	
teleportation_scroll(X,Y) :-
	(
	tembokAtas(X,Y);
	tembokBawah(X,Y);
	tembokKiri(X,Y);
	tembokKanan(X,Y);
	tembokTengah(X,Y)
	),
	write('Nggak bisa teleport ke situ, ada tembok...'),!.

map :-
	writeC(0,0), nl, nl,
	write('Legend'), nl,
	write('P: Player'), nl,
	write('S: Store'), nl,
	write('Q: Quest'), nl,
	write('D: Dungeon Boss'), nl,!.
