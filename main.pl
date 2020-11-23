:- dynamic(started/1).

:- include('leveling.pl').
:- include('map.pl').
:- include('enemy.pl').
:- include('commands.pl').
:- include('player.pl').
:- include('items.pl').
:- include('store.pl').
:- include('battle.pl').
:- include('quest.pl').


save(_) :-
	\+started(_),
	write('Kan belom mulai... mau ngesave apa dong?'), nl,
	write('Masukin command start. untuk mulai yaa!'), nl, !.

save(FileName) :-
	tell(FileName),
		writeDimensi,
		writeKoordinatP,
		writeKoordinatS,
		writeKoordinatD,
		writeKoordinatQ,
		writeKoordinatSlime,
		writeKoordinatGoblin,
		writeKoordinatWolf,
		writeTembok,
		writePlayerEquipment,
		writePlayer,
		writeInventory,
	told, !.

writeDimensi :-
    dimensi(X,Y),
    write('dimensi('), write(X), write(','), write(Y), write(').'), nl.
    
writeKoordinatP :-
    koordinatP(X,Y),
    write('koordinatP('), write(X), write(','), write(Y), write(').'), nl.
    
writeKoordinatS :-
    koordinatS(X,Y),
    write('koordinatS('), write(X), write(','), write(Y), write(').'), nl.
    
writeKoordinatD :-
    koordinatD(X,Y),
    write('koordinatD('), write(X), write(','), write(Y), write(').'), nl.
    
writeKoordinatQ :-
    koordinatQ(X,Y),
    write('koordinatQ('), write(X), write(','), write(Y), write(').'), nl.
    
writeKoordinatSlime:-
	\+koordinatSlime(_, _),
	!.
    
writeKoordinatSlime :-
    forall(koordinatSlime(X,Y),(
    write('koordinatSlime('), write(X), write(','), write(Y), write(').'), nl
    )),!.
    
writeKoordinatGoblin:-
	\+koordinatGoblin(_, _),
	!.
    
writeKoordinatGoblin :-
    forall(koordinatGoblin(X,Y),(
    write('koordinatGoblin('), write(X), write(','), write(Y), write(').'), nl
    )),!.

writeKoordinatWolf:-
	\+koordinatWolf(_, _),
	!.

writeKoordinatWolf :-
    forall(koordinatWolf(X,Y),(
    write('koordinatWolf('), write(X), write(','), write(Y), write(').'), nl
    )),!.
    
writeTembok:-
	\+tembok(_, _),
	!.

writeTembok :-
    forall(tembok(X,Y),(
    write('tembok('), write(X), write(','), write(Y), write(').'), nl
    )),!.
    
writeAvailQuest :-
    availQuest(X,Y),
    write('availQuest('), write(X), write(','), write(Y), write(').'), nl.
    
writeKillCount :-
    killCount(X,Y,Z),
    write('killCount('), write(X), write(','), write(Y), write(','), write(Z), write(').'), nl.
    
writeIsEnemyAlive :-
	isEnemyAlive(X),
	write('isEnemyAlive('), write(X), write(').'), nl.

writeInventory:-
	\+inventory(_, _, _, _, _, _, _, _, _, _, _),
	!.

writeInventory :-
	forall(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count),(
		write('inventory('), write(ID), write(', '), write('\''),write(Name), write('\''), write(', '), write(Type), write(', '),
        write(Rarity), write(', '), write(Class), write(', '), write(AddAttack), write(', '), 
        write(AddDefense), write(', '), write(AddMaxHP), write(', '), write(AddCurrentHP), write(', '), write(Price), 
        write(', '), write(Count), write(').'), nl
	)), !.
	
writePlayerEquipment :-
    playerEquipment(X,Y,Z),
    write('playerEquipment('), write('\''),write(X),write('\''), write(','), write(Y), write(','), write(Z), write(').'), nl.
    
writePlayer :-
	player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest),
	write('player('), write(Name), write(','), write(Level), write(','), write(Job), 
	write(','), write(Exp), write(','), write(Gold), write(','), write(MaxHealth), write(','), write(CurrentHealth), 
	write(','), write(Attack), write(','), write(Defense), write(','), write(SpecialAttack), 
	write(','), write(ActiveQuest), write(').'), nl.

loadFile(_) :-
	started(_),
	write('Kalau udah mulai nggak bisa ngeload game baru.'), nl, !.

loadFile(FileName):-
	\+file_exists(FileName),
	write('Filenya nggak ketemu.'), nl, !.

loadFile(FileName):-
	open(FileName, read, S),
        readLines(S,Lines),
    close(S),
    assertaLine(Lines), 
    asserta(started(1)), !.

assertLines([]) :- !.

assertLines([X|L]):-
	asserta(X),
	assertLines(L), !.

readLines(S,[]) :-
    at_end_of_stream(S).

readLines(S,[X|L]) :-
    \+ at_end_of_stream(S),
    read(S,X),
    readLines(S,L).
