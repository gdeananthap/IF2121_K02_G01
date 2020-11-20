:- include('items.pl').

:- dynamic(player/10).       /* Player Status */
:- dynamic(playerEquipment/3). /* Player Equipment */ 
:- dynamic(inventory/11). /* inventory(NamaItem) */

/** Player Status **/
/** player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack) **/
initPlayer :-
    write('Selamat Datang di NinoKuni, Pahlawan!'), nl,
    chooseName(X),
    chooseJob(X, Y),
    Exp is 0,
    Gold is 10000,
    ((Y == swordsman) ->
        Level is 1, 
        MaxHealth is 100,
        CurrentHealth is MaxHealth,
        Attack is 70, %udah ditambah stat dari basic weapon
        Defense is 80,
        SpecialAttack is 120,
        asserta(player(X, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
        asserta(playerEquipment('Wooden Sword', none, none)),
        addInventory(34), addInventory(34), addInventory(34), addInventory(34), addInventory(34),
        asserta(koordinatP(1,1)),!
    ;(Y == archer) ->
        Level is 1, 
        MaxHealth is 100,
        CurrentHealth is MaxHealth,
        Attack is 90, %udah ditambah stat dari basic weapon
        Defense is 60,
        SpecialAttack is 160,
        asserta(player(X, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
        asserta(playerEquipment('Wooden Bow', none, none)),
        addInventory(34), addInventory(34), addInventory(34), addInventory(34), addInventory(34),
        asserta(koordinatP(1,1)),!
    ;   Level is 1,
        MaxHealth is 120,
        CurrentHealth is MaxHealth,
        Attack is 90, %udah ditambah stat dari basic weapon
        Defense is 40,
        SpecialAttack is 160,
        asserta(player(X, Level, Y, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
        asserta(playerEquipment('Wooden Staff', none, none)),
        addInventory(34), addInventory(34), addInventory(34), addInventory(34), addInventory(34),
        asserta(koordinatP(1,1)),!   
    ).
	
chooseName(X) :-
    write('Siapa Nama Anda : '), read(X), nl, write(X), nl.

chooseJob(X, Y) :-
    write('Halo '), write(X), nl, 
    repeat,
    write('Silahkan Pilih Job Anda (swordsman / archer / sorcerer): '), nl,
    read(Y), nl,
    ((Y == swordsman ; Y == archer ; Y == sorcerer) -> 
        write('Anda memilih '), write(Y), nl, !
    ;   write('Job yang Anda pilih tidak tersedia!'), nl,
        fail
    ).

status :-
    player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack),
    playerEquipment(Weapon, Armor, Accessory),
    write('Player Status'), nl,
    write('Nama           : '), write(Name),nl,
    write('Level          : '), write(Level),nl,
    write('Job            : '), write(Job),nl,
    write('Exp            : '), write(Exp),nl,
    write('Gold           : '), write(Gold),nl,
    write('Max Health     : '), write(MaxHealth),nl,
    write('Current Health : '), write(CurrentHealth),nl,
    write('Attack         : '), write(Attack),nl,
    write('Defense        : '), write(Defense),nl,
    write('Special Attack : '), write(SpecialAttack),nl,
    write('Weapon         : '), write(Weapon), nl,
    write('Armor          : '), write(Armor), nl,
    write('Accessory      : '), write(Accessory),nl.

/** Player Equipment **/
/** playerEquipment(Weapon, Armor, Accessory) **/
use(X) :-
    findall(InvID, inventory(InvID,_,_,_,_,_,_,_,_,_,_), ListID),
    item(ID, X,_,_,_,_,_,_,_,_),
    \+member_inventory(ID, ListID),
    write(X), write(' tidak ada di Inventory Anda'), nl,
    !,fail.

use(X) :-
    item(ID, X, Type,_,_,_,_,_,_,_),
    ((Type == potion) -> 
        usePotion(ID),!
    ;   equip(ID), !
    % bisa use scroll kalo udh ada teleport   
    ).

usePotion(ID) :-
    player(NameP,_,Job,_,_,MaxHealth,CurrentHealth, Attack, Defense,_),
    inventory(ID, _,_,_,_, AddAttack, AddDefense, _, AddCurrentHP, _, Count),
    NewAttack is Attack+AddAttack,
    NewDefense is Defense+AddDefense,
    NewCurrentHealth is CurrentHealth+AddCurrentHP,
    ( (NewCurrentHealth >= MaxHealth) ->
        NewCurrentHealth is MaxHealth
    ; NewCurrentHealth is NewCurrentHealth
    ),
    NewCount is Count-1,
    ((NewCount =:= 0) -> 
        retract(player(NameP, Level, Job, Exp, Gold, MaxHealth,_,_,_,SpecialAttack)),
        asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, NewCurrentHealth, NewAttack, NewDefense, SpecialAttack)),
        retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),!
    ;   retract(player(NameP, Level, Job, Exp, Gold, MaxHealth,_,_,_,SpecialAttack)),
        asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, NewCurrentHealth, NewAttack, NewDefense, SpecialAttack)),
        retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),
        assertz(inventory(ID,_,_,_,_,_,_,_,_,_,NewCount)),!  
    ).

equip(ID) :-
    player(_,_,Job,_,_,_,_,_,_,_),
    item(ID, X,_,_,Class,_,_,_,_,_),
    \+(Job == Class),
    write(X), write(' tidak bisa digunakan karena tidak sesuai dengan Job Anda!'), nl,
    !,fail.

equip(ID) :-
    player(NameP,_,Job,_,_,MaxHealth,_, Attack, Defense,_),
    inventory(ID, Name,Type,_,_, AddAttack, AddDefense, AddMaxHP, _, _, Count),
    playerEquipment(CurrentWeapon, CurrentArmor, CurrentAccessory),
    ( (Type == weapon) ->
        ((CurrentWeapon == none) -> 
            NewAttack is Attack+AddAttack,
            NewDefense is Defense+AddDefense,
            NewMaxHealth is MaxHealth+AddMaxHP,
            retract(playerEquipment(CurrentWeapon, CurrentArmor, CurrentAccessory)),
            asserta(playerEquipment(Name, CurrentArmor, CurrentAccessory)),
            NewCount is Count-1,
            ((NewCount =:= 0) -> 
                retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),!
            ;   retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),
                assertz(inventory(ID,_,_,_,_,_,_,_,_,_,NewCount)),!  
            ) 
        ;   item(ID2, CurrentWeapon,_,_,_,MinAttack, MinDefense, MinMaxHP, _,_),
            NewAttack is Attack+AddAttack-MinAttack,
            NewDefense is Defense+AddDefense-MinDefense,
            NewMaxHealth is MaxHealth+AddMaxHP-MinMaxHP,
            addInventory(ID2),
            retract(playerEquipment(CurrentWeapon, CurrentArmor, CurrentAccessory)),
            asserta(playerEquipment(Name, CurrentArmor, CurrentAccessory)),
            NewCount is Count-1,
            ((NewCount =:= 0) -> 
                retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),!
            ;   retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),
                assertz(inventory(ID,_,_,_,_,_,_,_,_,_,NewCount)),!  
            ) 
        )
    ; (Type == armor) ->
        ((CurrentArmor == none) -> 
            NewAttack is Attack+AddAttack,
            NewDefense is Defense+AddDefense,
            NewMaxHealth is MaxHealth+AddMaxHP,
            retract(playerEquipment(CurrentWeapon, CurrentArmor, CurrentAccessory)),
            asserta(playerEquipment(CurrentWeapon, Name, CurrentAccessory)),
            NewCount is Count-1,
            ((NewCount =:= 0) -> 
                retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),!
            ;   retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),
                assertz(inventory(ID,_,_,_,_,_,_,_,_,_,NewCount)),!  
            ) 
        ;   item(ID2, CurrentArmor,_,_,_,MinAttack, MinDefense, MinMaxHP,_,_),
            NewAttack is Attack+AddAttack-MinAttack,
            NewDefense is Defense+AddDefense-MinDefense,
            NewMaxHealth is MaxHealth+AddMaxHP-MinMaxHP,
            addInventory(ID2),
            retract(playerEquipment(CurrentWeapon, CurrentArmor, CurrentAccessory)),
            asserta(playerEquipment(CurrentWeapon, Name, CurrentAccessory)),
            NewCount is Count-1,
            ((NewCount =:= 0) -> 
                retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),!
            ;   retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),
                assertz(inventory(ID,_,_,_,_,_,_,_,_,_,NewCount)),!  
            ) 
        )
    ;   ((CurrentAccessory == none) -> 
            NewAttack is Attack+AddAttack,
            NewDefense is Defense+AddDefense,
            NewMaxHealth is MaxHealth+AddMaxHP,
            retract(playerEquipment(CurrentWeapon, CurrentArmor, CurrentAccessory)),
            asserta(playerEquipment(CurrentWeapon, CurrentArmor, Name)),
            NewCount is Count-1,
            ((NewCount =:= 0) -> 
                retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),!
            ;   retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),
                assertz(inventory(ID,_,_,_,_,_,_,_,_,_,NewCount)),!  
            ) 
        ;   item(ID2, CurrentAccessory,_,_,_,MinAttack, MinDefense, MinMaxHP,_,_),
            NewAttack is Attack+AddAttack-MinAttack,
            NewDefense is Defense+AddDefense-MinDefense,
            NewMaxHealth is MaxHealth+AddMaxHP-MinMaxHP,
            addInventory(ID2),
            retract(playerEquipment(CurrentWeapon, CurrentArmor, CurrentAccessory)),
            asserta(playerEquipment(CurrentWeapon, CurrentArmor, Name)),
            NewCount is Count-1,
            ((NewCount =:= 0) -> 
                retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),!
            ;   retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth,_,_,SpecialAttack)),
                asserta(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, NewAttack, NewDefense, SpecialAttack)),
                retract(inventory(ID,_,_,_,_,_,_,_,_,_,_)),
                assertz(inventory(ID,_,_,_,_,_,_,_,_,_,NewCount)),!  
            ) 
        )
    ).

/** Player Inventory **/
/** inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count) **/

/** Player Inventory **/
maxInventory(100).

cekJumlahInventory(Sum):-
    findall(Count, inventory(_,_,_,_,_,_,_,_,_,_, Count), List),
    sum_list(List, Sum).

member_inventory(ID,[ID|_]).
member_inventory(ID,[_|T]) :- member(ID,T).

isEmpty :-
    cekJumlahInventory(Sum),
    Sum == 0.

isFull :-
    cekJumlahInventory(Sum),
    Sum == 100.

addInventory(_) :-
    cekJumlahInventory(Sum),
    maxInventory(Max),
    Sum >= Max,
    write('Inventory Sudah Penuh'),
    !,fail.

addInventory(ID) :-
    findall(InvID, inventory(InvID,_,_,_,_,_,_,_,_,_,_), ListID),
    (   member_inventory(ID, ListID) ->
        retract(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count)),
        NewCount is Count+1,
        assertz(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, NewCount))
    ;   item(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price),
        Count is 1,
        assertz(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count))
    ).   

sellItems(Name) :-
    item(ID,Name,_,_,_,_,_,_,_,_),
    findall(InvID, inventory(InvID,_,_,_,_,_,_,_,_,_,_), ListID),
    \+member_inventory(ID, ListID),
    write('Items yang ingin Kamu jual tidak ada di inventory mu'), nl,
    !,fail.

sellItems(Name) :-
    inventory(ID,Name,_,_,_,_,_,_,_,Price,Count),
    NewCount is Count - 1,
    (   NewCount =:= 0 ->
        retract(inventory(ID,_,_,_,_,_,_,_,_,_,_))
    ;   retract(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count)),
        assertz(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, NewCount))
    ),!,
    write('Items berhasil dijual'), nl,
    write('Anda mendapatkan '), write(Price), write(' gold'), nl.

makeListInventory(ListNama, ListType, ListRarity, ListClass, ListCount) :-
    findall(Name, inventory(_,Name,_,_,_,_,_,_,_,_,_), ListNama),
    findall(Type, inventory(_,_,Type,_,_,_,_,_,_,_,_), ListType),
    findall(Rarity, inventory(_,_,_,Rarity,_,_,_,_,_,_,_), ListRarity),
    findall(Class, inventory(_,_,_,_,Class,_,_,_,_,_,_), ListClass),
    findall(Count, inventory(_,_,_,_,_,_,_,_,_,_,Count), ListCount).

printInventory([], [], [], [], []).
printInventory([A|V], [B|W], [C|X], [D|Y], [E|Z]) :-
    (
        B == potion ->
        write('- '), write(E), write(' '), write(A), nl,
        printInventory(V,W,X,Y,Z)
    ;   write('- '), write(E), write(' '), write(A), write(' ('), write(B), 
        write(', '), write(C), write(', '), write(D), write(')'), nl,
        printInventory(V,W,X,Y,Z) 
    ).
    

printAllInventory :-
    write('Inventory Anda: '), nl,
    makeListInventory(ListNama, ListType, ListRarity, ListClass, ListCount),
    printInventory(ListNama, ListType, ListRarity, ListClass, ListCount).

