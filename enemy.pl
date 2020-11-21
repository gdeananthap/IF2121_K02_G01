/** ENEMY **/
/* Terdapat 4 jenis enemy, yaitu Slime, Goblin, Wolf, dan Boss */

/** Attributes **/
/* Setiap enemy memiliki status level, HP, Attack, dan Defense */
/* Enemy(Name, Attack, Special, Defense, MaxHP, EXPGained, goldGained, Level) */
:- dynamic(enemy/8).

enemy(slime, 50, 70, 40, 80, 3, 15, 1).
enemy(goblin, 70, 90, 35, 80, 3, 20, 1).
enemy(wolf, 80, 100, 40, 90, 5, 35, 1).
enemy(boss, 300, 350, 320, 500, 100, 1000, 1).

enemyLevelUp(Name) :-
    enemy(Name, Attack, Special, Defense, MaxHP, Expgained, Goldgained, Level),
    Nlevel is Level+1,
    Nattack is Attack+15,
    Ndefense is Defense+15,
    NmaxHP is MaxHP+20,
    Nspecial is Special+25,
    Ngold is Goldgained * Nlevel,
    ((Nlevel =:= 2) ->
        Nexp is Expgained+5,
        retract(enemy(Name, Attack, Special, Defense, MaxHP, Expgained, Goldgained, Level)),
        asserta(enemy(Name, Nattack, Nspecial, Ndefense,NmaxHP, Nexp, Ngold, Nlevel)), !
    ;   Nexp is 2^(Nlevel-2) * 4,
        retract(enemy(Name, Attack, Special, Defense, MaxHP, Expgained, Goldgained, Level)),
        asserta(enemy(Name, Nattack, Nspecial, Ndefense,NmaxHP, Nexp, Ngold, Nlevel)), !
    ).

makeListEnemy(ListName, ListAttack, ListSpecial, ListDefense, ListMaxHP, ListEXPGained, ListgoldGained, ListLevel) :-
    findall(Name, enemy(Name,_,_,_,_,_,_,_), ListName),
    findall(Attack, enemy(_,Attack,_,_,_,_,_,_), ListAttack),
    findall(Special, enemy(_,_,Special,_,_,_,_,_), ListSpecial),
    findall(Defense, enemy(_,_,_,Defense,_,_,_,_), ListDefense),
    findall(MaxHP, enemy(_,_,_,_,MaxHP,_,_,_), ListMaxHP),
    findall(EXPGained, enemy(_,_,_,_,_,EXPGained,_,_), ListEXPGained),
    findall(Gold, enemy(_,_,_,_,_,_,Gold,_), ListgoldGained),
    findall(Level, enemy(_,_,_,_,_,_,_,Level), ListLevel).

printEnemy([],[],[],[],[],[],[],[]).
printEnemy([A|B], [C|D], [E|F], [G|H], [I|J], [K|L], [M|N], [O|P]) :-
    write('Nama: '), write(A), nl,
    write('Attack: '), write(C), nl,
    write('Special Attack: '), write(E), nl,
    write('Defense: '), write(G), nl,
    write('Max HP: '), write(I), nl,
    write('EXP Gained: '), write(K), nl,
    write('Gold Gained: '), write(M), nl,
    write('Level: '), write(O), nl,
    nl,
    printEnemy(B,D,F,H,J,L,N,P).

printAllEnemy :-
    nl, write('Enemy Status'), nl,
    makeListEnemy(ListName, ListAttack, ListSpecial, ListDefense, ListMaxHP, ListEXPGained, ListgoldGained, ListLevel),
    printEnemy(ListName, ListAttack, ListSpecial, ListDefense, ListMaxHP, ListEXPGained, ListgoldGained, ListLevel).
    
