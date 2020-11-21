:- dynamic(isEnemyAlive/1).
:- dynamic(enemyMatched/8).
:- dynamic(peluangRun/1).
:- dynamic(isRun/1).
:- dynamic(isFight/1).
:- dynamic(turn/1).

enemyTriggered(Name) :-
    enemy(Name, Attack, Special, Defense, MaxHP, Expgained, Goldgained, Level),
    asserta(enemyMatched(Name, Attack, Special, Defense, MaxHP, Expgained, Goldgained, Level)),
    write('Apa yang akan kamu lakukan?'), nl,
    write('- fight'), nl,
    write('- run'), nl,
    write('Ketik pilihanmu diakhiri dengan titik, contoh: fight.'), nl,
    random(1, 10, X),
    asserta(peluangRun(X)),
    asserta(isEnemyAlive(Name)).

bossTriggered :-
    Name = boss,
    enemy(Name, Attack, Special, Defense, MaxHP, Expgained, Goldgained, Level),
    asserta(enemyMatched(Name, Attack, Special, Defense, MaxHP, Expgained, Goldgained, Level)),
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
    asserta(isRun(1)),
    asserta(isFight(1)),
    isEnemyAlive(_),
    cont, !.

/* *** CONTINUE/END TURN *** */
cont :-
    write('Apa yang kamu mau lakukan?'), nl,
    write('- attack'), nl,
    write('- special'), nl, 
    write('- use(item)'), nl,
    write('Special attack hanya bisa dilakukan setiap 3 turn sekali'), nl,
    !.

/* *** ATTACK *** */
/* **** BELUM KETEMU ENEMY **** */
attack :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu dengan enemy.'), nl,
    !.

/* **** ATTACK BERHASIL **** */
/* BELUM KEBAYANG SCALING NYA BEGIMANA */

