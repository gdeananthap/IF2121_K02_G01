:- dynamic(isEnemyAlive/1).
:- dynamic(enemyMatched/8).
:- dynamic(peluangRun/1).
:- dynamic(isRun/1).
:- dynamic(isFight/1).
:- dynamic(turn/1).
:- dynamic(enemyturn/1).

enemyTriggered(Name) :-
    enemy(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level),nl,
    asserta(enemyMatched(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level)),
    ((Name == boss) ->
        write('Selamat datang di Boss Dungeon!'), nl,
        write('Disini kamu tidak bisa lari dari hadapanku, HAHAHAHA~~'), nl,
        asserta(peluangRun(0)),
        asserta(isEnemyAlive(Name)),
        asserta(isRun(1)),
        fight
    ;
        write('Attack: '), write(Attack), nl,
        write('Special Attack: '), write(Special), nl,
        write('Defense: '), write(Defense), nl,
        write('HP: '), write(EnemyCurrentHP), nl, nl,
        write('Apa yang akan kamu lakukan?'), nl,
        write('- fight'), nl,
        write('- run'), nl,
        write('Ketik pilihanmu diakhiri dengan titik, contoh: fight.'), nl,
        random(1, 10, X),
        asserta(peluangRun(X)),
        asserta(isEnemyAlive(Name))
    ), !.

bossTriggered :-
    Name = boss,
    enemy(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level),
    asserta(enemyMatched(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level)),
    asserta(isEnemyAlive(Name)),
    fight, !.

/* *** RUN *** */

/* **** BELUM isEnemyAlive **** */
run :- 
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu dengan Enemy.'), !.

/* **** RUN BERHASIL **** */
run :-
    \+ isRun(_),
    \+ isFight(_),
    isEnemyAlive(_),
    peluangRun(X),
    X >= 5,
    write('Kamu berhasil lari! Yeay!'), nl,
    retract(peluangRun(X)),
    retract(isEnemyAlive(_)),
    retract(enemyMatched(_,_,_,_,_,_,_,_)), 
    randomizeEnemy,
    !.

/* **** RUN GAGAL **** */
run :-
    \+ isRun(_),
    \+ isFight(_),
    isEnemyAlive(Name),
    peluangRun(X),
    X < 5,
    write('Kamu gagal lari, kamu harus kalahkan si '), write(Name), nl,
    retract(peluangRun(X)),
    fight, !.

/* **** RUN SUDAH PERNAH GAGAL **** */
run :-
    isRun(_),
    write('E-e-eh! Kamu sudah gagal run... Ayo, semangat kalahkan lawanmu~!'), nl,
    !.

/* **** RUN SUDAH PERNAH FIGHT **** */
run :- 
    \+ isRun(_),
    isFight(_),
    write('E-e-eh! Kamu sudah memilih untuk fight... Ayo, semangat kalahkan lawanmu~!'), nl,
    !.

/* *** FIGHT *** */
/* **** BELUM KETEMU ENEMY **** */
fight :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu dengan enemy.'), !.

/* **** SUDAH FIGHT TAPI FIGHT LAGI **** */
fight :-
    isFight(_),
    isEnemyAlive(_),
    write('Kamu lagi fight enemy-nya. Semangat ya~!'), nl,
    !.

/* **** FIGHT BERHASIL **** */
fight :-
    asserta(isFight(1)),
    isEnemyAlive(_),
    asserta(turn(1)),
    asserta(enemyturn(1)),
    cont, !.

/* *** CONTINUE/END TURN *** */
cont :-
    turn(X),
    ((X mod 3 =:= 0) ->
        nl,write('Sekarang giliranmu, Apa yang kamu mau lakukan?'), nl,
        write('- attack'), nl,
        write('- special'), nl, 
        write('- use(item)'), nl,
        write('Kamu bisa menggunakannya special attack kali ini! Jangan sia-siakan kesempatan ini!'), nl
    ;
        nl,write('Sekarang giliranmu, Apa yang kamu mau lakukan?'), nl,
        write('- attack'), nl,
        write('- special'), nl, 
        write('- use(item)'), nl,
        write('Special attack hanya bisa dilakukan setiap 3 turn sekali, kamu belum bisa menggunakannya kali ini.'), nl
    ), !.

/* *** ATTACK *** */
/* **** MUSUH BELUM MATI **** */
attackWords :-
    enemyMatched(Name, _, _, _, EnemyCurrentHP, _, _, _),
    EnemyCurrentHP > 0,
    write('HP '), write(Name), write(' sekarang adalah '), write(EnemyCurrentHP), nl,
    write('Sekarang giliran musuh...'), nl, nl,
    enemyTurn,
    !.

/* **** MUSUH SUDAH MATI **** */
attackWords :-
    enemyMatched(Name, _, _, _, EnemyCurrentHP, Expgained, Goldgained, _),
    player(X, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack,ActiveQuest),
    EnemyCurrentHP =< 0,
    write(Name), write(' berhasil dikalahkan!'), nl,
    ((Name == boss) ->
        win,
        retract(isEnemyAlive(_)),
        retract(enemyMatched(_,_,_,_,_,_,_,_)), 
        retract(isFight(_)),
        retract(isRun(_)),
        retract(enemyturn(_)),
        retract(turn(_)),
        write('Selamat kamu mendapatkan taring emas Great Red dan menanamkannya untuk menghidupkan kembali NinoKuni!'), nl,
        write('Terimakasih untuk perjuanganmu, Pahlawan! Sampai Jumpa di kesempatan berikutnya.'),nl,nl,nl,nl,nl,nl,
        quit,
        credit
    ;   
        write('Kamu berhasil mendapatkan '), write(Expgained), write(' EXP dan '), write(Goldgained), write(' Gold!'), nl, nl,
        NExp is Exp + Expgained,
        NGold is Gold + Goldgained,
        NCurrentHealth is MaxHealth,
        retract(player(X, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack,ActiveQuest)),
        asserta(player(X, Level, Y, NExp, NGold, MaxHealth, NCurrentHealth, Attack, Defense, SpecialAttack,ActiveQuest)),
        randomizeEnemy,
        retractall(isEnemyAlive(_)),
        retractall(enemyMatched(_,_,_,_,_,_,_,_)), 
        retractall(isFight(_)),
        retractall(isRun(_)),
        retractall(enemyturn(_)),
        retractall(turn(_)),
        kill(Name)
    ), !.

/* **** BELUM KETEMU ENEMY **** */
attack :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu dengan enemy.'), nl,
    !.

/* **** ATTACK BERHASIL **** */
attack :-
    isEnemyAlive(_),
    turn(X),
    player(_, _, _, _, _, _, _, Attack, _, _,_),
    enemyMatched(Name, EnemyAttack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level),
    BDamage is Attack-(Defense//2),
    ((BDamage =< 0) ->
        Damage is 0
    ;
        Damage is BDamage
    ),
    NEnemyCurrentHP is EnemyCurrentHP - Damage,
    retract(enemyMatched(Name, EnemyAttack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level)),
    asserta(enemyMatched(Name, EnemyAttack, Special, Defense, NEnemyCurrentHP, Expgained, Goldgained, Level)),
    NewX is X + 1,
    retract(turn(X)),
    asserta(turn(NewX)),
    write('Berhasil melancarkan serangan!'), nl,
    write('Damage: '), write(Damage), nl,
    attackWords, !.

/* *** SPECIAL ATTACK *** */
/* **** BELUM BERTEMU ENEMY **** */
special :- 
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu dengan enemy.'), nl,
    !.

/* **** SPECIAL ATTACK BERHASIL ATAU BELUM 3 TURN **** */
special :- 
    turn(X),
    ((X mod 3 =:= 0) ->
        player(_, _, _, _, _, _, _, _, _, SpecialAttack, _),
        enemyMatched(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level),
        Damage is SpecialAttack-(Defense//2),
        NEnemyCurrentHP is EnemyCurrentHP - Damage,
        retract(enemyMatched(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level)),
        asserta(enemyMatched(Name, Attack, Special, Defense, NEnemyCurrentHP, Expgained, Goldgained, Level)),
        NewX is X + 1,
        retract(turn(X)),
        asserta(turn(NewX)),
        write('Berhasil melancarkan Special Attack!'), nl,
        write('Damage: '), write(Damage), nl,
        attackWords
    ;
        write('Ingat! Special attack hanya bisa digunakan setiap 3 turn sekali.'), nl
    ), !.

/* *** ENEMY TURN *** */
enemyTurn :-
    enemyturn(X),
    enemyMatched(Name, EnemyAttack, EnemySpecialAttack, _, _, _, _, _),
    player(PlayerName, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest),
    ((X mod 3 =:= 0) ->
        Damage is EnemySpecialAttack-(Defense//2),
        NCurrentHealth is CurrentHealth - Damage,
        retract(player(PlayerName, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
        asserta(player(PlayerName, Level, Y, Exp, Gold, MaxHealth, NCurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
        NewX is X + 1,
        retract(enemyturn(X)),
        asserta(enemyturn(NewX)),
        write(Name), write(' berhasil melancarkan Special Attack!'), nl,
        write('Damage: '), write(Damage), nl
    ;
        BDamage is EnemyAttack-(Defense//2),
        ((BDamage =< 0) ->
            Damage is 0
        ;
            Damage is BDamage
        ),
        NCurrentHealth is CurrentHealth - Damage,
        retract(player(PlayerName, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
        asserta(player(PlayerName, Level, Y, Exp, Gold, MaxHealth, NCurrentHealth, Attack, Defense, SpecialAttack, ActiveQuest)),
        NewX is X + 1,
        retract(enemyturn(X)),
        asserta(enemyturn(NewX)),
        write(Name), write(' berhasil melancarkan serangan!'), nl,
        write('Damage: '), write(Damage), nl
    ), enemyAttackWords, 
    !. 

enemyAttackWords :-
    player(_, _, _, _, _, _, CurrentHealth, _, _, _, _),
    CurrentHealth > 0,
    write('HP kamu sekarang adalah '), write(CurrentHealth), nl,
    write('Sekarang giliran kamu...'), nl, nl,
    cont,
    !.

enemyAttackWords :-
    player(_, _, _, _, _, _, CurrentHealth, _, _, _, _),
    CurrentHealth =< 0,
    lose,
    retract(isEnemyAlive(_)),
    retract(enemyMatched(_,_,_,_,_,_,_,_)), 
    retract(isFight(_)),
    retract(isRun(_)),
    retract(enemyturn(_)),
    retract(turn(_)),
    quit, nl,
    write('HP kamu 0. Kamu gagal menyelamatkan NinoKuni!  Terima kasih untuk Perjuanganmu, Pahlawan!'),nl,
    write('Ketik start. untuk memulai kembali permainan!'),nl,nl,nl,nl,nl, credit,
    !.

/* ---------- WIN ---------- */
win :-
    write('     **    **   *******   **     **       **       **  **  ****     **               **'), nl,
    write('    //**  **   **/////** /**    /**      /**      /** /** /**/**   /**              /**'), nl,
    write('     //****   **     //**/**    /**      /**   *  /** /** /**//**  /**              /**'), nl,
    write('      //**   /**      /**/**    /**      /**  *** /** /** /** //** /**           ******'), nl,
    write('       /**   /**      /**/**    /**      /** **/**/** /** /**  //**/**     **   **///**'), nl, 
    write('       /**   //**     ** /**    /**      /**** //**** /** /**   //****    //   /**  /**'), nl,
    write('       /**    //*******  //*******       /**/   ///** /** /**    //***     **  //******'), nl,
    write('       //      ///////    ///////        //       //  //  //      ///     //    ////// '), nl,
    !.

/* ---------- LOSE ---------- */
lose :-
    write(' __      __   ______   __    __        __        ______    ______   ________ '), nl,
    write('|  \\    /  \\ /      \\ |  \\  |  \\      |  \\      /      \\  /      \\ |        \\'), nl,
    write(' \\$$\\  /  $$|  $$$$$$\\| $$  | $$      | $$     |  $$$$$$\\|  $$$$$$\\| $$$$$$$$'), nl,
    write('  \\$$\\/  $$ | $$  | $$| $$  | $$      | $$     | $$  | $$| $$___\\$$| $$__    '), nl,
    write('   \\$$  $$  | $$  | $$| $$  | $$      | $$     | $$  | $$ \\$$    \\ | $$  \\   '), nl,
    write('    \\$$$$   | $$  | $$| $$  | $$      | $$     | $$  | $$ _\\$$$$$$\\| $$$$$   '), nl,
    write('    | $$    | $$__/ $$| $$__/ $$      | $$_____| $$__/ $$|  \\__| $$| $$_____ '), nl,
    write('    | $$     \\$$    $$ \\$$    $$      | $$     \\\\$$    $$ \\$$    $$| $$     \\'), nl,
    write('     \\$$      \\$$$$$$   \\$$$$$$        \\$$$$$$$$ \\$$$$$$   \\$$$$$$  \\$$$$$$$$'), nl,
    !.

credit :-
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
	write('                        |___/                                                                     '),nl,nl,nl,
    write('                  ____   ____    _____   ____    ___   _____   ____                               '),nl,
    write('                 / ___| |  _ \\  | ____| |  _ \\  |_ _| |_   _| / ___|                            '),nl,
    write('                | |     | |_) | |  _|   | | | |  | |    | |   \\___ \\                            '),nl,
    write('                | |___  |  _ <  | |___  | |_| |  | |    | |    ___) |                             '),nl,
    write('                 \\____| |_| \\_\\ |_____| |____/  |___|   |_|   |____/                           '),nl,nl,nl,
    write('                              Gde Anantha Priharsena                                              '),nl,
    write('                                     13519026                                                     '),nl,nl,
    write('                                 Shifa Salsabiila                                                 '),nl,
    write('                                     13519106                                                     '),nl,nl,
    write('                               Muhammad Fikri Naufal                                              '),nl,
    write('                                     13519158                                                     '),nl,nl,
    write('                             Andres Jerriel Sinabutar                                             '),nl,
    write('                                     13519218                                                     '),nl,nl.                                                         