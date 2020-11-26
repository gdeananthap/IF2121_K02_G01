:- dynamic(availQuest/2).
:- dynamic(killCount/3).

initQuests :-
	KilledSlime is 0, 
	KilledGoblin is 0, 
	KilledWolf is 0, 
	CurrentQuest is 1, 
	IsActive is 0,
	asserta(availQuest(CurrentQuest, IsActive)),
	asserta(killCount(KilledSlime, KilledGoblin, KilledWolf)).

writeQuest(1) :-
	write('Quest 1:'), nl,
	write('Membunuh salah satu dari slime, goblin, atau wolf sebanyak 1 buah.'), nl.

writeQuest(2) :-
	write('Quest 2:'), nl,
	write('Membunuh 2 Slime dan 1 Wolf.'), nl.

writeQuest(3) :-
	write('Quest 3:'), nl,
	write('Membunuh 2 Goblin dan 1 Wolf.'), nl.

writeQuest(4) :-
	write('Quest 4:'), nl,
	write('Membunuh 2 Slime, 1 Goblin, dan 1 Wolf.'), nl.

writeQuest(5) :-
	write('Quest 5:'), nl,
	write('Membunuh 1 Slime, 2 Goblin, dan 1 Wolf.'), nl.

writeQuest(6) :-
	write('Quest 6:'), nl,
	write('Membunuh 1 Slime, 2 Goblin, dan 2 Wolf.'), nl.

writeQuest(7) :-
	write('Quest 7:'), nl,
	write('Membunuh 3 Slime, 2 Goblin, dan 1 Wolf.'), nl.

writeQuest(8) :-
	write('Quest 8:'), nl,
	write('Membunuh 2 Slime, 3 Goblin, dan 1 Wolf.'), nl.

writeQuest(9) :-
	write('Quest 9:'), nl,
	write('Membunuh 1 Slime, 2 Goblin, dan 3 Wolf.'), nl.

writeQuest(10) :-
	write('Quest 10:'), nl,
	write('Membunuh 3 Slime, 3 Goblin, dan 3 Wolf.'), nl.

writeQuest(11) :-
	write('Kamu telah menyelesaikan seluruh quest.'), nl.

writeQuest(0) :-
	write('Kamu belum mengambil quest.'), nl.

infoQuest :-
	player(_, _, _, _, _, _, _, _, _, _, ActiveQuest),
	writeQuest(ActiveQuest).

quest :-
    koordinatP(X,Y),
    \+koordinatQ(X,Y),
    write('Quest hanya dapat diambil pada tempat berlabel Q!'),nl,
    !,fail.

quest :-
	availQuest(_, IsActive),
	IsActive =:= 1,
	write('Selesaikan quest yang telah diambil terlebih dahulu!'), nl,
	!,fail.

quest :-
	availQuest(CurrentQuest, _),
	CurrentQuest =:= 11,
	write('Semua quest telah selesai!'), nl,
	!,fail.

quest :-
	availQuest(CurrentQuest, IsActive),
	IsActive =:= 0,
	TempQuest is CurrentQuest,
	TempActive is 1, A is 0, B is 0, C is 0,
	write('Kamu telah mengambil quest '), write(CurrentQuest), write('!'), nl,
	write('Ketik infoQuest. untuk melihat quest.'),
	retract(player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, _)),
	asserta(player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, TempQuest)),
	retract(availQuest(CurrentQuest, IsActive)),
	asserta(availQuest(CurrentQuest, TempActive)),
	retract(killCount(_,_,_)),
	asserta(killCount(A, B, C)), !.

/* reward(QuestID, PlusExp, PlusGold)*/
reward(1, 10, 1000).
reward(2, 20, 2000).
reward(3, 30, 3000).
reward(4, 40, 4000).
reward(5, 50, 5000).
reward(6, 60, 6000).
reward(7, 70, 7000).
reward(8, 80, 8000).
reward(9, 90, 9000).
reward(10, 100, 10000).

questRewarding(Name) :-
	player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest),
	reward(ActiveQuest, PlusExp, PlusGold),
	availQuest(CurrentQuest, IsActive),
	NextQuest is CurrentQuest+1,
	TempExp is Exp+PlusExp,
	TempGold is Gold+PlusGold,
	TempQuest is 0,
	TempActive is 0,
	A is 0, B is 0, C is 0,
	write('Kamu mendapatkan:'), nl,
	write(' Gold: '), write(Gold), write('+'), write(PlusGold), nl,
	write(' Exp: '), write(Exp), write('+'), write(PlusExp), nl,
	retract(player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
	asserta(player(Name, Level, Job, TempExp, TempGold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, TempQuest)),
	retract(killCount(_,_,_)),
	asserta(killCount(A, B, C)),
	retract(availQuest(CurrentQuest, IsActive)),
	asserta(availQuest(NextQuest, TempActive)),
	levelUpMarker(Name, Level, TempExp).


questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 1,
	(KilledSlime > 0; KilledGoblin > 0; KilledWolf > 0),
	write('Quest 1 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),	
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 2,
	KilledSlime >= 2, KilledGoblin >= 0, KilledWolf >= 1,
	write('Quest 2 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 3,
	KilledSlime >= 0, KilledGoblin >= 2, KilledWolf >= 1,
	write('Quest 3 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 4,
	KilledSlime >= 2, KilledGoblin >= 1, KilledWolf >= 1,
	write('Quest 4 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 5,
	KilledSlime >= 1, KilledGoblin >= 2, KilledWolf >= 1,
	write('Quest 5 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 6,
	KilledSlime >= 1, KilledGoblin >= 2, KilledWolf >= 2,
	write('Quest 6 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 7,
	KilledSlime >= 3, KilledGoblin >= 2, KilledWolf >= 1,
	write('Quest 7 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 8,
	KilledSlime >= 2, KilledGoblin >= 3, KilledWolf >= 1,
	write('Quest 8 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 9,
	KilledSlime >= 1, KilledGoblin >= 2, KilledWolf >= 3,
	write('Quest 9 finished!'),nl,
	questRewarding(Name), !.

questMarker(Name) :-
	player(Name,_,_,_,_,_,_,_,_,_,ActiveQuest),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	ActiveQuest =:= 10,
	KilledSlime >= 3, KilledGoblin >= 3, KilledWolf >= 3,
	write('You have finished all quests!'),nl,
	questRewarding(Name), !.


/* debug */

kill(slime) :-
	player(Name,Level,_,Exp,_,_,_,_,_,_,_),	
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	TempKill is KilledSlime+1,
	retract(killCount(KilledSlime, KilledGoblin, KilledWolf)),
	asserta(killCount(TempKill, KilledGoblin, KilledWolf)),
	(levelUpMarker(Name, Level, Exp);
	questMarker(Name)).

kill(goblin) :-
	player(Name,Level,_,Exp,_,_,_,_,_,_,_),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	TempKill is KilledGoblin+1,
	retract(killCount(KilledSlime, KilledGoblin, KilledWolf)),
	asserta(killCount(KilledSlime, TempKill, KilledWolf)),
	(levelUpMarker(Name, Level, Exp);
	questMarker(Name)).

kill(wolf) :-
	player(Name,Level,_,Exp,_,_,_,_,_,_,_),
	killCount(KilledSlime, KilledGoblin, KilledWolf),
	TempKill is KilledWolf+1,
	retract(killCount(KilledSlime, KilledGoblin, KilledWolf)),
	asserta(killCount(KilledSlime, KilledGoblin, TempKill)),
	(levelUpMarker(Name, Level, Exp);
	questMarker(Name)).
