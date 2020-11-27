start :-
	\+started(_),
	asserta(started(1)),
	title,
	initQuests,
	initPlayer,
	initMap,
	map, !.
	
start :-
	started(_),
	write('Ini udah mulai broo ._.').


d :-
	isEnemyAlive(_),
	write('Eits, mau kemana? Ada musuh di depanmu loh, kalau mau lari pakai run.'), !.

d :-
	\+started(_),
	write('Tolong di start dulu mas/mbak...'), !.

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
	storeNpc,
	write('Kamu berada di Store.'), nl,
	write('Ketik store. untuk mengakses store'),nl,!.
	
d :-
	koordinatP(X,Y),
	NewX is X+1,
	posisiQ(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	questNpc,
	write('Kamu menemui sebuah Quest!'), nl,
	availQuest(CurrentQuest, _),
	writeQuest(CurrentQuest),
	write('ketik quest. untuk mengambil quest.'), nl,
	!.

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
	posisiD(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	dragonAnimation,
	enemyTriggered(boss), !.
	
d :-
	koordinatP(X,Y),
	NewX is X+1,
	(
	tembokKanan(NewX,Y); 
	tembokTengah(NewX,Y)),
	write('Kamu nabrak tembok...'),!.
	

a :-
	isEnemyAlive(_),
	write('Eits, mau kemana? Ada musuh di depanmu loh, kalau mau lari pakai run.'), !.

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
	storeNpc,
	write('Kamu berada di Store.'),nl,
	write('Ketik store. untuk mengakses store'),nl,!.
	
a :-
	koordinatP(X,Y),
	NewX is X-1,
	posisiQ(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	questNpc,
	write('Kamu menemui sebuah Quest!'), nl,
	availQuest(CurrentQuest, _),
	writeQuest(CurrentQuest),
	write('ketik quest. untuk mengambil quest.'), nl,
	!.

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
	posisiD(NewX,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(NewX,Y)),
	dragonAnimation,
	enemyTriggered(boss), !.

a :-
	koordinatP(X,Y),
	NewX is X-1,
	(
	tembokKiri(NewX,Y);
	tembokTengah(NewX,Y)
	),
	write('Kamu nabrak tembok...'),!.


w :-
	isEnemyAlive(_),
	write('Eits, mau kemana? Ada musuh di depanmu loh, kalau mau lari pakai run.'), !.

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
	storeNpc,
	write('Kamu berada di Store.'),nl,
	write('Ketik store. untuk mengakses store'),nl,!.
	
w :-
	koordinatP(X,Y),
	NewY is Y-1,
	posisiQ(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	questNpc,
	write('Kamu menemui sebuah Quest!'), nl,
	availQuest(CurrentQuest, _),
	writeQuest(CurrentQuest),
	write('ketik quest. untuk mengambil quest.'), nl,
	!.

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
	posisiD(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	dragonAnimation,
	enemyTriggered(boss), !.

w :-
	koordinatP(X,Y),
	NewY is Y-1,
	(
	tembokAtas(X,NewY);
	tembokTengah(X,NewY)
	),
	write('Kamu nabrak tembok...'),!.
	

s :-
	isEnemyAlive(_),
	write('Eits, mau kemana? Ada musuh di depanmu loh, kalau mau lari pakai run.'), !.

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
	store,
	write('Kamu berada di Store.'), nl,
	write('Ketik store. untuk mengakses store'),nl,!.
	
s :-
	koordinatP(X,Y),
	NewY is Y+1,
	posisiQ(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	questNpc,
	write('Kamu menemui sebuah Quest!'), nl,
	availQuest(CurrentQuest, _),
	writeQuest(CurrentQuest),
	write('ketik quest. untuk mengambil quest.'), nl,
	!.

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
	posisiD(X,NewY),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,NewY)),
	dragonAnimation,
	enemyTriggered(boss),!.

s :-
	koordinatP(X,Y),
	NewY is Y+1,
	(
	tembokBawah(X,NewY);
	tembokTengah(X,NewY)
	),
	write('Kamu nabrak tembok...'),!.

teleport(_,_) :-
	isEnemyAlive(_),
	write('Eits, mau kemana? Ada musuh di depanmu loh, kalau mau lari pakai run.'), !.

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
	write('Teleportasi berhasil.'),nl,
	storeNpc,
	write('Kamu berada di Store.'), nl,
	write('Ketik store. untuk mengakses store'),nl,!.
	
teleport(X,Y) :-
	posisiQ(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	write('Teleportasi berhasil.'),nl,
	questNpc,
	availQuest(CurrentQuest, _),
	writeQuest(CurrentQuest),
	write('Kamu menemui sebuah Quest!'), nl,
	write('ketik quest. untuk mengambil quest.'), nl,
	!.


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

teleport(X,Y) :-
	posisiD(X,Y),
	retract(koordinatP(_,_)),
	asserta(koordinatP(X,Y)),
	dragonAnimation,
	write('Teleportasi berhasil.'),
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
	write('D: Dungeon Boss'), nl,
	write('help. -- Show Available Commands'),nl,!.

quit :-
	\+ started(_),
	write('Belum di start udah mau keluar aja nih! Start dulu yuk :)'), !.

quit :- 
	retractall(started(_)),
	retractall(koordinatP(_,_)),
	retractall(koordinatS(_,_)),
	retractall(koordinatQ(_,_)),
	retractall(koordinatD(_,_)),
	retractall(koordinatSlime(_,_)),
	retractall(koordinatGoblin(_,_)),
	retractall(koordinatWolf(_,_)),
	retractall(dimensi(_, _)),
	retractall(tembok(_,_)),
	retractall(player(_, _, _, _, _, _, _, _, _, _, _)),
	retractall(playerEquipment(_, _, _)),
	retractall(inventory(_, _, _, _, _, _, _, _, _, _, _)),
	retractall(enemy(_, _, _, _, _, _, _, _)),
	quitAnimation, !.

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

questNpc :-
	write('       .-""-.            '),nl,
	write('      /-.{}  \\          '),nl,
	write('      | _\\__.|          '),nl,
	write('      \\/^)^ \\/         '),nl,
	write('       \\ =  /           '),nl,
	write('  .---./`--`\\.--._      '),nl,
	write(' /     `;--"`     \\     '),nl,
	write(';        /`       ;      '),nl,
	write('|       |*        |      '),nl,
	write('/   |   |     |    \\    '),nl,
	write('|    \\  |*    /    |    '),nl,
	write('\\_   |\\_|____/|  __/   '),nl,
	write('  \\__//======\\\\__/    '),nl,
	write('  / //_      _\\\\ \\    '),nl,
	write('  -\'  |`""""`|  `-      '),nl,
	write('      |  L   |           '),nl,
	write('      >_ || _<           '),nl,
	write('      |  ||  |           '),nl,
	write('      |  ||  |           '),nl,
	write('     /   ||   \\         '),nl,
	write('    /    /,    \\        '),nl,
	write('     `|"|`"|"|"`         '),nl,
	write('     /  )  /  )          '),nl,
	write('    /__/  /__/           '),nl.

storeNpc :-
	write('                  //////                                       '),nl,
	write('             <====//////====[]                                 '),nl,
	write('                 /////\\\\\\\\\\                               '),nl,
	write('               ((((( ))))))))                                  '),nl,
	write('               ||| /\\   /\\ ||                                '),nl,
	write('               || |_O| |O_|||                                  '),nl,
	write('              (9|     ^    |6)                                 '),nl,
	write('                 \\    V   /                          )        '),nl,
	write('                 (~~~~~~~~~)                   ( ((            '),nl,
	write('                /~~~~~~~~~~~\\                     )) )        '),nl,
	write('              ///////|||\\\\\\\\\\\\\\                 (( ((   '),nl,
	write('            //                 \\\\                )  ))       '),nl,
	write('      ______|~~~|____________|~~~|_________      (((           '),nl,
	write('    []#=====`^^^\'============`^^^\'========#[]    |||         '),nl,
	write('  __[]_____________________________________[]___(___)_         '),nl,
	write(' [____________________________________________________]        '),nl,
	write('   )   ===========================================  (          '),nl,
	write('  /  /\'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`\\  \\      '),nl,
	write('<__/    (___________________________)               \\__>      '),nl.

title :-
	write('                _   _  _____  _   _   ____   _  __ _    _  _   _  _____                           '),nl,
	write('               | \\ | ||_   _|| \\ | | / __ \\ | |/ /| |  | || \\ | ||_   _|                      '),nl,
	write('               |  \\| |  | |  |  \\| || |  | || \' / | |  | ||  \\| |  | |                        '),nl,
	write('               | . ` |  | |  | . ` || |  | ||  <  | |  | || . ` |  | |                            '),nl,
	write('               | |\\  | _| |_ | |\\  || |__| || . \\ | |__| || |\\  | _| |_                       '),nl,
	write('               |_| \\_||_____||_| \\_| \\____/ |_|\\_\\ \\____/ |_| \\_||_____|                   '),nl,
	write('                                                                                                  '),nl,
	write('                                                                                                  '),nl,
	write('    ____                                   _      __           __           _    _                '),nl,
	write('   |  __\\                                 ( )     \\ \\         / /          | |  | |             '),nl,
	write('   | |  | | _ __  __ _   __ _   ___   _ __ |/ ___   \\ \\  /\\  / /_ __  __ _ | |_ | |__          '),nl,
	write('   | |  | || \'__|/ _` | / _` | / _ \\ | \'_ \\  / __|   \\ \\/  \\/ /| \'__|/ _` || __|| \'_ \\  '),nl,
	write('   | |__| || |  | (_| || (_| || (_) || | | | \\__ \\    \\  /\\  / | |  | (_| || |_ | | | |       '),nl,
	write('   |_____/ |_|   \\__,_| \\__, | \\___/ |_| |_| |___/     \\/  \\/  |_|   \\__,_| \\__||_| |_|    '),nl,
	write('                         __/ |                                                                    '),nl,
	write('                        |___/                                                                     '),nl,nl,
	write(' ___________________________________________________________________________________________________'),nl,
	write('| NinoKuni adalah sebuah dunia yang besar, dibagi menjadi 3 ras besar yaitu Sorcerer, Archer, dan   |'),nl,
	write('| Swordsman. Di pusat NinoKuni terdapat sebuah pohon besar yang disebut Pohon Dunia. Suatu hari,    |'),nl,	
	write('| NinoKuni kedatangan sesosok Iblis Naga bernama Great Red yang merusak Pohon Dunia yang merupakan  |'),nl,
	write('| satu-satunya sumber kehidupan di NinoKuni. Salah satu cara untuk menumbuhkan kembali kehidupan    |'),nl,
	write('| di NinoKuni adalah dengan menanam taring emas dari Great Red sehingga kamu harus mengalahkan Great|'),nl,
	write('| Red untuk mendapatkannya. Apakah kamu siap untuk memperkuat dirimu dan mengalahkan Great Red?     |'),nl,
	write('|__________________________________________________________________________________________________ |'),nl,
	write('                                                                                                   \\|'),nl,
	write('                                                                                        ,   A           {}                   '),nl,
	write('                                                                                       / \\, | ,        .--.                 '),nl,
	write('                                                                                      |    =|= >      /.--.\\                '),nl,
	write('                                                                                       \\ /` | `       |====|                '),nl,
	write('                                                                                        `   |         |`::`|                 '),nl,
	write('                                                                                            |     .-;`\\..../`;_.-^-._       '),nl,
	write('                                                                                           /\\\\/  /  |...::..|`   :   `|    '),nl,
	write('                                                                                           |:`\\ |   /\'\'\'::\'\'|   .:.   |'),nl,
	write('                                                                                            \\ /\\;-,/\\   ::  |..:::::..|    '),nl,
	write('                                                                                            |\\ <` >  >._::_.| \':::::\' |   '),nl,
	write('                                                                                            | `""`  /   ^^  |   \':\'   |    '),nl,
	write('                                                                                            |       |       \\    :    /     '),nl,
	write('                                                                                            |       |        \\   :   /      '),nl,
	write('                                                                                            |       |___/\\___|`-.:.-`       '),nl,
	write('                                                                                            |        \\_ || _/    `          '),nl,
	write('                                                                                            |        <_ >< _>                '),nl,
	write('                                                                                            |        |  ||  |                '),nl,
	write('                                                                                            |        |  ||  |                '),nl,
	write('                                                                                            |       _\\.:||:./_              '),nl,
	write('                                                                                            |      /____/\\____\\            '),nl.



titleLoad :-
	write('                _   _  _____  _   _   ____   _  __ _    _  _   _  _____                           '),nl,
	write('               | \\ | ||_   _|| \\ | | / __ \\ | |/ /| |  | || \\ | ||_   _|                      '),nl,
	write('               |  \\| |  | |  |  \\| || |  | || \' / | |  | ||  \\| |  | |                        '),nl,
	write('               | . ` |  | |  | . ` || |  | ||  <  | |  | || . ` |  | |                            '),nl,
	write('               | |\\  | _| |_ | |\\  || |__| || . \\ | |__| || |\\  | _| |_                       '),nl,
	write('               |_| \\_||_____||_| \\_| \\____/ |_|\\_\\ \\____/ |_| \\_||_____|                   '),nl,
	write('                                                                                                  '),nl,
	write('                                                                                                  '),nl,
	write('    ____                                   _      __           __           _    _                '),nl,
	write('   |  __\\                                 ( )     \\ \\         / /          | |  | |             '),nl,
	write('   | |  | | _ __  __ _   __ _   ___   _ __ |/ ___   \\ \\  /\\  / /_ __  __ _ | |_ | |__          '),nl,
	write('   | |  | || \'__|/ _` | / _` | / _ \\ | \'_ \\  / __|   \\ \\/  \\/ /| \'__|/ _` || __|| \'_ \\  '),nl,
	write('   | |__| || |  | (_| || (_| || (_) || | | | \\__ \\    \\  /\\  / | |  | (_| || |_ | | | |       '),nl,
	write('   |_____/ |_|   \\__,_| \\__, | \\___/ |_| |_| |___/     \\/  \\/  |_|   \\__,_| \\__||_| |_|    '),nl,
	write('                         __/ |                                                                    '),nl,
	write('                        |___/                                                                     '),nl,nl,
	write(' ___________________________________________________________________________________________________'),nl,
	write('| Selamat Datang kembali di NinoKuni, Pahlawan! Sekarang, Kehidupan NinoKuni sudah sangat terancam! |'),nl,
	write('| Segera siapkan diri Anda untuk mengalahkan Great Red yang sudah merusak Pohon Dunia di NinoKuni!  |'),nl,	
	write('| Selamatkanlah NinoKuni, Saya menaruh banyak harapan kepadamu!                                     |'),nl,
	write('|__________________________________________________________________________________________________ |'),nl,
	write('                                                                                                   \\|'),nl,
	write('                                                                                      ,   A           {}                   '),nl,
	write('                                                                                     / \\, | ,        .--.                 '),nl,
	write('                                                                                    |    =|= >      /.--.\\                '),nl,
	write('                                                                                     \\ /` | `       |====|                '),nl,
	write('                                                                                      `   |         |`::`|                 '),nl,
	write('                                                                                          |     .-;`\\..../`;_.-^-._       '),nl,
	write('                                                                                         /\\\\/  /  |...::..|`   :   `|    '),nl,
	write('                                                                                         |:`\\ |   /\'\'\'::\'\'|   .:.   |'),nl,
	write('                                                                                          \\ /\\;-,/\\   ::  |..:::::..|    '),nl,
	write('                                                                                          |\\ <` >  >._::_.| \':::::\' |   '),nl,
	write('                                                                                          | `""`  /   ^^  |   \':\'   |    '),nl,
	write('                                                                                          |       |       \\    :    /     '),nl,
	write('                                                                                          |       |        \\   :   /      '),nl,
	write('                                                                                          |       |___/\\___|`-.:.-`       '),nl,
	write('                                                                                          |        \\_ || _/    `          '),nl,
	write('                                                                                          |        <_ >< _>                '),nl,
	write('                                                                                          |        |  ||  |                '),nl,
	write('                                                                                          |        |  ||  |                '),nl,
	write('                                                                                          |       _\\.:||:./_              '),nl,
	write('                                                                                          |      /____/\\____\\            '),nl.

help :-
    write('w. a. s. d.     -- move'),nl,
    write('map.            -- look at the map'),nl,
    write('status.         -- show your status and equipment'),nl,
	write('bag.            -- show your inventory'),nl,
	write('use(\'X\').       -- use X from your inventory'), nl,
	write('infoQuest.      -- see current quest detail    '),nl,
    write('save(Filename). -- save your game'),nl, 
	write('quit.           -- quit game'), nl, !.

ninokuni :-
	write('start.              -- start the game!'),nl,
    write('loadFile(Filename). -- load previously saved game'),nl,
	write('quit.               -- quit the game'),nl,!.

quitAnimation :-
	write('   _____    ____     ____    _____    ____   __     __  ______       '),nl,
	write('  / ____|  / __ \\   / __ \\  |  __ \\  |  _ \\  \\ \\   / / |  ____|'),nl,
	write(' | |  __  | |  | | | |  | | | |  | | | |_) |  \\ \\_/ /  | |__       '),nl,
	write(' | | |_ | | |  | | | |  | | | |  | | |  _ <    \\   /   |  __|       '),nl,
	write(' | |__| | | |__| | | |__| | | |__| | | |_) |    | |    | |____       '),nl,
	write('  \\_____|  \\____/   \\____/  |_____/  |____/     |_|    |______|   '),nl, nl,
	write(' _______________________________________________________________     '),nl,
	write('| Selamat tinggal Pahlawan, .....                               |    '),nl,
	write('| Kehadiranmu akan selalu kami rindukan di NinoKuni!            |    '),nl,	
	write('|______________________________________________________________ |    '),nl,
	write('                                                               \\|   '),nl,
	write('                                                    ,   A           {}                   '),nl,
	write('                                                   / \\, | ,        .--.                 '),nl,
	write('                                                  |    =|= >      /.--.\\                '),nl,
	write('                                                   \\ /` | `       |====|                '),nl,
	write('                                                    `   |         |`::`|                 '),nl,
	write('                                                        |     .-;`\\..../`;_.-^-._       '),nl,
	write('                                                       /\\\\/  /  |...::..|`   :   `|    '),nl,
	write('                                                       |:`\\ |   /\'\'\'::\'\'|   .:.   |'),nl,
	write('                                                        \\ /\\;-,/\\   ::  |..:::::..|   '),nl,
	write('                                                        |\\ <` >  >._::_.| \':::::\' |   '),nl,
	write('                                                        | `""`  /   ^^  |   \':\'   |    '),nl,
	write('                                                        |       |       \\    :    /     '),nl,
	write('                                                        |       |        \\   :   /      '),nl,
	write('                                                        |       |___/\\___|`-.:.-`       '),nl,
	write('                                                        |        \\_ || _/    `          '),nl,
	write('                                                        |        <_ >< _>                '),nl,
	write('                                                        |        |  ||  |                '),nl,
	write('                                                        |        |  ||  |                '),nl,
	write('                                                        |       _\\.:||:./_              '),nl,
	write('                                                        |      /____/\\____\\            '),nl.

                                                               