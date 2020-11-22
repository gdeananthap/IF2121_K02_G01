start :-
	\+started(_),
	asserta(started(1)),
	initPlayer,
	initMap,
	map.
	
start :-
	started(_),
	write('Ini udah mulai broo ._.').

d :-
	\+started(_),
	write('Tolong di start dulu mas/mbak...'),!.

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
	slimeAnimation,
	write('Kamu bertemu dengan Slime!'),
	enemyTriggered(slime), !.

d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiGoblin(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	goblinAnimation,
	write('Kamu bertemu dengan Goblin!'),
	enemyTriggered(goblin), !.

d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiWolf(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	wolfAnimation,
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
	\+started(_),
	write('Tolong di start dulu mas/mbak...'),!.
	
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
	slimeAnimation,
	write('Kamu bertemu dengan Slime!'),
	enemyTriggered(slime), !.

a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiGoblin(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	goblinAnimation,
	write('Kamu bertemu dengan Goblin!'),
	enemyTriggered(goblin), !.

a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiWolf(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	wolfAnimation,
	write('Kamu bertemu dengan Wolf!'),
	enemyTriggered(wolf), !.
	
a :-
	koordinatP(X,Y),
	NewX is X-1,
	(
	tembokKiri(NewX,Y);
	tembokTengah(NewX,Y)
	),
	write('Kamu nabrak tembok...'),!.


w :-
	\+started(_),
	write('Tolong di start dulu mas/mbak...'),!.

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
	slimeAnimation,
	write('Kamu bertemu dengan Slime!'),
	enemyTriggered(slime), !.

w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiGoblin(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	goblinAnimation,
	write('Kamu bertemu dengan Goblin!'),
	enemyTriggered(goblin), !.

w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiWolf(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	wolfAnimation,
	write('Kamu bertemu dengan Wolf!'),
	enemyTriggered(wolf), !.
	
w :-
	koordinatP(X,Y),
	NewY is Y-1,
	(
	tembokAtas(X,NewY);
	tembokTengah(X,NewY)
	),
	write('Kamu nabrak tembok...'),!.
	

s :-
	\+started(_),
	write('Tolong di start dulu mas/mbak...'),!.
	
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
	slimeAnimation,
	write('Kamu bertemu dengan Slime!'),
	enemyTriggered(slime),
	!.

s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiGoblin(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	goblinAnimation,
	write('Kamu bertemu dengan Goblin!'),
	enemyTriggered(goblin),!.

s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiWolf(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	wolfAnimation,
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
	slimeAnimation,
	write('Teleportasi berhasil. Kamu bertemu dengan Slime!'),
	enemyTriggered(slime), !.

teleport(X,Y) :-
	posisiGoblin(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	goblinAnimation,
	write('Teleportasi berhasil. Kamu bertemu dengan Goblin!'),
	enemyTriggered(goblin), !.

teleport(X,Y) :-
	posisiWolf(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	wolfAnimation,
	write('Teleportasi berhasil. Kamu bertemu dengan Wolf!'),
	enemyTriggered(wolf), !.

map :-
	\+started(_),
	write('Tolong di start dulu mas/mbak...'),!.

map :-
	writeC(0,0), nl, nl,
	write('Legend'), nl,
	write('P: Player'), nl,
	write('S: Store'), nl,
	write('Q: Quest'), nl,
	write('D: Dungeon Boss'), nl,!.


slimeAnimation :-
	write('              .-~~~-.                '),nl,
	write('      .- ~ ~-(       )_ _            '),nl,
	write('     /                     ~ -.      '),nl,
	write('    |        o       o         \\    '),nl,
	write('     \\          ___           ."    '),nl,
	write('       ~- . _____________ . -~       '),nl.

goblinAnimation :-
	write('             ,      ,           '),nl,
	write('            /(.-""-.)\\         '),nl,
	write('        |\\  \\/      \\/  /|   '),nl,
	write('        | \\ / =.  .= \\ / |    '),nl,
	write('        \\( \\   o\\/o   / )/   '),nl,
	write('         \\_, "-/  \\-" ,_/     '),nl,
	write('           /   \\__/   \\       '),nl,
	write('           \\,___/\\___,/       '),nl,
	write('         ___\\ \\|uu|/ /___     '),nl,
	write('       /`    \\ .--. /    `\\   '),nl,
	write('      /       "----"       \\   '),nl.

wolfAnimation:-
	write('         _                 '),nl,
	write('        / \\      _-"      '),nl,
	write('      _/|  \\-""- _ /      '),nl,
	write(' __-" { |          \\      '),nl,
	write('     /              \\     '),nl,
	write('     /       "o.  |o }     '),nl,
	write('     |            \\ ;     '),nl,
	write('                   ",      '),nl,
	write('        \\_         __\\   '),nl,
	write('           "-_    \\.//    '),nl,
	write('            / "-____"      '),nl,
	write('           /               '),nl,
	write('         _"                '),nl,
	write('       _-"                 '),nl.

dragonAnimation :-
	write(' ######   ########  ########    ###    ########       ########  ######## ########      '),nl,
	write('##    ##  ##     ## ##         ## ##      ##          ##     ## ##       ##     ##     '),nl,
	write('##        ##     ## ##        ##   ##     ##          ##     ## ##       ##     ##     '),nl,
	write('##   #### ########  ######   ##     ##    ##          ########  ######   ##     ##     '),nl,
	write('##    ##  ##   ##   ##       #########    ##          ##   ##   ##       ##     ##     '),nl,
	write('##    ##  ##    ##  ##       ##     ##    ##          ##    ##  ##       ##     ##     '),nl,
	write(' ######   ##     ## ######## ##     ##    ##          ##     ## ######## ########      '),nl,
	write('                               _                                                        '),nl,
	write('                            ==(W{==========-      /===-                                 '),nl,
	write('                              ||  (.--.)         /===-_---~~~~~~~~~------____           '),nl,
	write('                              | \\_,|**|,__      |===-~___                _,-"          '),nl,
	write('                 -==\\        `\\ " `--"   ),    `//~\\   ~~~~`---.___.-~~              '),nl,
	write('             ______-==|        /`\\_. .__/\\ \\    | |  \\           _-~`               '),nl,
	write('       __--~~~  ,-/-==\\      (   | .  |~~~~|   | |   `\\        ,"                     '),nl,
	write('    _-~       /"    |  \\     )__/==0==-\\<>/   / /      \\      /                      '),nl,
	write('  ."        /       |   \\      /~\\___/~~\\/  /" /        \\   /"                      '),nl,
	write(' /  ____  /         |    \\`\\.__/-~~   \\  |_/"  /          \\/"                       '),nl,
	write('/-"~    ~~~~~---__  |     ~-/~         ( )   /"        _--~`                            '),nl,
	write('                  \\_|      /        _) | ;  ),   __--~~                                '),nl,
	write('                    "~~--_/      _-~/- |/ \\   "-~ \\                                   '),nl,
	write('                   {\\__--_/}    / \\_>-|)<__\\      \\                                 '),nl,
	write('                   /"   (_/  _-~  | |__>--<__|      |                                   '),nl,
	write('                  |   _/) )-~     | |__>--<__|      |                                   '),nl,
	write('                  / /~ ,_/       / /__>---<__/      |                                   '),nl,
	write('                 o-o _//        /-~_>---<__-~      /                                    '),nl,
	write('                 (^(~          /~_>---<__-      _-~                                     '),nl,
	write('                ,/|           /__>--<__/     _-~                                        '),nl,
	write('             ,//("(          |__>--<__|     /                  .----_                   '),nl,
	write('            ( ( "))          |__>--<__|    |                 /" _---_~\\                '),nl,
	write('         `-)) )) (           |__>--<__|    |               /"  /     ~\\`\\             '),nl,
	write('        ,/,"//( (             \\__>--<__\\    \\            /"  //        ||            '),nl,
	write('      ,( ( ((, ))              ~-__>--<_~-_  ~--____---~" _/"/        /"                '),nl,
	write('    `~/  )` ) ,/|                 ~-_~>--<_/-__       __-~ _/                           '),nl,
	write('  ._-~//( )/ )) `                    ~~-"_/_/ /~~~~~~~__--~                             '),nl,
	write('   ;"( ")/ ,)(                              ~~~~~~~~~~                                  '),nl,
	write('  " ") "( (/                                                                            '),nl,
	write('    "   "  `                                                                            '),nl.

