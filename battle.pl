:- dynamic(isEnemyAlive/1).
:- dynamic(enemyMatched/8).
:- dynamic(peluangRun/1).
:- dynamic(isRun/1).
:- dynamic(isFight/1).
:- dynamic(turn/1).

enemyTriggered(Name) :-
    enemy(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level),
    asserta(enemyMatched(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level)),
    write('Apa yang akan kamu lakukan?'), nl,
    write('- fight'), nl,
    write('- run'), nl,
    write('Ketik pilihanmu diakhiri dengan titik, contoh: fight.'), nl,
    random(1, 10, X),
    asserta(peluangRun(X)),
    asserta(isEnemyAlive(Name)).

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
    retract(enemyMatched(_,_,_,_,_,_,_,_)), !.

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
    turn(0),
    cont, !.

/* *** CONTINUE/END TURN *** */
cont :-
    write('Sekarang giliranmu, Apa yang kamu mau lakukan?'), nl,
    write('- attack'), nl,
    write('- special'), nl, 
    write('- use(item)'), nl,
    write('Special attack hanya bisa dilakukan setiap 3 turn sekali'), nl,
    !.

/* *** ATTACK *** */
/* **** MUSUH BELUM MATI **** */
attackWords :-
    enemyMatched(Name, _, _, _, EnemyCurrentHP, _, _, _),
    EnemyCurrentHP > 0,
    write('HP '), write(Name), write(' sekarang adalah '), write(EnemyCurrentHP), nl,
    write('Sekarang giliran musuh...'), nl,
    enemyTurn,
    !.

/* **** MUSUH SUDAH MATI **** */
attackWords :-
    enemyMatched(Name, _, _, _, EnemyCurrentHP, Expgained, Goldgained, _),
    player(X, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack),
    EnemyCurrentHP =< 0,
    write(Name), write(' berhasil dikalahkan!'), nl,
    ((Name == boss) ->
        write('Selamat kamu berhasil memenangkan permainan ini!')
    ;   
        write('Kamu berhasil mendapatkan '), write(Expgained), write('EXP dan '), write(Goldgained), write('Gold!'), nl,
        NExp is Exp + Expgained,
        NGold is Gold + Goldgained,
        NCurrentHealth is MaxHealth,
        retract(player(X, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
        asserta(player(X, Level, Y, NExp, NGold, MaxHealth, NCurrentHealth, Attack, Defense, SpecialAttack))
    ), !.

/* **** BELUM KETEMU ENEMY **** */
attack :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu dengan enemy.'), nl,
    !.

/* **** ATTACK BERHASIL **** */
/* KALO SCALINGNYA GINI OKE NGGA */
attack :-
    isEnemyAlive(_),
    turn(X),
    player(_, _, _, _, _, _, _, Attack, _, _),
    enemyMatched(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level),
    Damage is Attack-(Defense//2),
    NEnemyCurrentHP is EnemyCurrentHP - Damage,
    retract(enemyMatched(Name, Attack, Special, Defense, EnemyCurrentHP, Expgained, Goldgained, Level)),
    asserta(enemyMatched(Name, Attack, Special, Defense, NEnemyCurrentHP, Expgained, Goldgained, Level)),
    newX is X + 1,
    retract(turn(X)),
    asserta(turn(newX)),
    write('Berhasil melancarkan serangan!'), nl,
    write('Damage: '), write(Damage), nl,
    attackWords, !.

/* *** SPECIAL ATTACK *** */
/* **** BELUM BERTEMU ENEMY **** */
special :- 
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu dengan enemy.'), nl,
    !.

/* **** SPECIAL ATTACK BELUM 3 TURN **** */
/* special :- */

/* *** ENEMY TURN *** */


