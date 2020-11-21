start :-
	initPlayer,
	initMap,
	map.

d :-
	koordinatP(X,Y),
	NewX is X+1,
	\+tembokKanan(NewX,Y),
	\+tembokTengah(NewX,Y),
	\+posisiS(NewX,Y),
	\+posisiQ(NewX,Y),
	\+posisiD(NewX,Y),
	\+posisiSlime(NewX,Y),
	\+posisiGoblin(NewX,Y),
	\+posisiWolf(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bergerak satu petak ke kanan.'),!.
	
d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiS(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu berada di Store.'),!.
	
d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiQ(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu menemui sebuah Quest!'),!.

d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiSlime(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bertemu dengan Slime!'),
	enemyTriggered(slime), !.

d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiGoblin(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bertemu dengan Goblin!'),
	enemyTriggered(goblin), !.

d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiWolf(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bertemu dengan Wolf!'),
	enemyTriggered(wolf), !.
	
d :-
	koordinatP(X,Y),
	NewX is X+1,
	(
	tembokKanan(NewX,Y); 
	tembokTengah(NewX,Y)),
	write('Kamu nabrak tembok...'),!.
	
a :-
	koordinatP(X,Y),
	NewX is X-1,
	\+tembokKiri(NewX,Y),
	\+tembokTengah(NewX,Y),
	\+posisiS(NewX,Y),
	\+posisiQ(NewX,Y),
	\+posisiD(NewX,Y),
	\+posisiSlime(NewX,Y),
	\+posisiGoblin(NewX,Y),
	\+posisiWolf(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bergerak satu petak ke kiri.'),!.
	
a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiS(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu berada di Store.'),!.
	
a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiQ(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu menemui sebuah Quest!'),!.

a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiSlime(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bertemu dengan Slime!'),!.

a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiGoblin(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bertemu dengan Goblin!'),!.

a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiWolf(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	write('Kamu bertemu dengan Wolf!'),!.
	
a :-
	koordinatP(X,Y),
	NewX is X-1,
	(
	tembokKiri(NewX,Y);
	tembokTengah(NewX,Y)
	),
	write('Kamu nabrak tembok...'),!.

w :-
	koordinatP(X,Y),
	NewY is Y-1,
	\+tembokAtas(X,NewY),
	\+tembokTengah(X,NewY),
	\+posisiS(X,NewY),
	\+posisiQ(X,NewY),
	\+posisiD(X,NewY),
	\+posisiSlime(X,NewY),
	\+posisiGoblin(X,NewY),
	\+posisiWolf(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bergerak satu petak ke atas.'),!.
	
w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiS(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu berada di Store.'),!.
	
w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiQ(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu menemui sebuah Quest!'),!.

w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiSlime(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bertemu dengan Slime!'),!.

w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiGoblin(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bertemu dengan Goblin!'),!.

w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiWolf(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bertemu dengan Wolf!'),!.
	
w :-
	koordinatP(X,Y),
	NewY is Y-1,
	(
	tembokAtas(X,NewY);
	tembokTengah(X,NewY)
	),
	write('Kamu nabrak tembok...'),!.
	
s :-
	koordinatP(X,Y),
	NewY is Y+1,
	\+tembokBawah(X,NewY),
	\+tembokTengah(X,NewY),
	\+posisiS(X,NewY),
	\+posisiQ(X,NewY),
	\+posisiD(X,NewY),
	\+posisiSlime(X,NewY),
	\+posisiGoblin(X,NewY),
	\+posisiWolf(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bergerak satu petak ke bawah.'),!.
	
s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiS(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu berada di Store.'),
	write('Ketik store untuk mengakses store'),!.
	
s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiQ(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu menemui sebuah Quest!'),!.

s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiSlime(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bertemu dengan Slime!'),
	enemyTriggered(slime),
	!.

s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiGoblin(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bertemu dengan Goblin!'),
	enemyTriggered(goblin),!.

s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiWolf(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	write('Kamu bertemu dengan Wolf!'),
	enemyTriggered(wolf),!.
	
s :-
	koordinatP(X,Y),
	NewY is Y+1,
	(
	tembokAtas(X,NewY);
	tembokTengah(X,NewY)
	),
	write('Kamu nabrak tembok...'),!.
	
teleport(X,Y) :-
	\+tembokBawah(X,Y),
	\+tembokAtas(X,Y),
	\+tembokKiri(X,Y),
	\+tembokKanan(X,Y),
	\+tembokTengah(X,Y),
	\+posisiS(X,Y),
	\+posisiQ(X,Y),
	\+posisiD(X,Y),
	\+posisiSlime(X,Y),
	\+posisiGoblin(X,Y),
	\+posisiWolf(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Teleportasi berhasil.'),nl,!.
	
teleport(X,Y) :-
	posisiS(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Teleportasi berhasil. Kamu berada di Store.'),nl,
	write('Ketik store untuk mengakses store'),!.
	
teleport(X,Y) :-
	posisiQ(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Teleportasi berhasil. Kamu berada di Quest.'),nl,!.


teleport(X,Y) :-
	posisiSlime(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Kamu bertemu dengan Slime!'),!.

teleport(X,Y) :-
	posisiGoblin(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Kamu bertemu dengan Goblin!'),!.

teleport(X,Y) :-
	posisiWolf(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Kamu bertemu dengan Wolf!'),!.

map :-
	writeC(0,0), nl, nl,
	write('Legend'), nl,
	write('P: Player'), nl,
	write('S: Store'), nl,
	write('Q: Quest'), nl,
	write('D: Dungeon Boss'), nl,!.
