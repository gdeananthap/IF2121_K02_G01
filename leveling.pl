expNeeded(2, 10).
expNeeded(3, 20).
expNeeded(4, 40).
expNeeded(5, 80).
expNeeded(6, 160).
expNeeded(7, 320).
expNeeded(8, 640).
expNeeded(9, 1280).
expNeeded(10, 2560).

playerLevelUp(Name) :-
	player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest),
	NextLevel is (Level+1),
	expNeeded(NextLevel, SubExp),
	NewExp is (Exp-SubExp),
	NewAttack is (Attack+20),
	NewDefense is (Defense+20),
	NewSpAtt is (SpecialAttack+20),
	NewMaxHealth is (MaxHealth+20),
	NewCurrHealth is (CurrentHealth+20),
	retract(player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
	asserta(player(Name, NextLevel, Job, NewExp, Gold, NewMaxHealth, NewCurrHealth, NewAttack, NewDefense, NewSpAtt, ActiveQuest)),
	enemyLevelUp(slime),
	enemyLevelUp(goblin),
	enemyLevelUp(wolf).

/* selalu tambahkan fungsi levelUpMarker setiap melakukan kegiatan yang nambah exp */
levelUpMarker(Name, Level, Exp) :-
	Level =:= 1,
	Exp >= 10,
	write('Leveled up to level 2'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 2,
	Exp >= 20,
	write('Leveled up to level 3'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 3,
	Exp >= 40,
	write('Leveled up to level 4'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 4,
	Exp >= 80,
	write('Leveled up to level 5'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 5,
	Exp >= 160,
	write('Leveled up to level 6'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 6,
	Exp >= 320,
	write('Leveled up to level 7'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 7,
	Exp >= 640,
	write('Leveled up to level 8'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 8,
	Exp >= 1280,
	write('Leveled up to level 9'), nl,
	playerLevelUp(Name),
	!.

levelUpMarker(Name, Level, Exp) :-
	Level =:= 9,
	Exp >= 2560,
	write('You have reached max level'), nl,
	playerLevelUp(Name),
	!.

/* Debugging */

tambahExp(Name):-
	player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest),
	ExpPlus is Exp+7,
	retract(player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
	asserta(player(Name, Level, Job, ExpPlus, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
	levelUpMarker(Name, Level, ExpPlus).