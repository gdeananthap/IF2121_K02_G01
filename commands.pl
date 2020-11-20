	
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
