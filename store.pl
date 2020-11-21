:- dynamic(isStore/1). %Kondisi sedang berada di store

store :-
    koordinatP(X,Y),
    \+koordinatS(X,Y),
    write('Anda berada diluar store!'),nl,
    !,fail.

store :-
    player(NameP,_,_,_,_,_,_,_,_,_),
    asserta(isStore(1)),
    repeat,
    write('Selamat datang di Store, '), write(NameP), nl,
    write('Apa yang ingin kamu lakukan? '), nl,
    write('1. Gacha (1000 gold)'), nl,
    write('2. Buy Items'), nl,
    write('3. Sell Items'), nl,
    write('4. Help'), nl,
    write('5. Exit'),nl,
    read(X),nl,
    ( (X < 1 ; X > 5) -> 
        write('Hal yang bisa dilakukan hanya 1-5!'), nl, fail
    ; (X =:= 1 ) ->
        gacha, nl, fail
    ; (X =:= 2 ) ->
        write('List Item yang bisa dibeli'), nl,
        write('a. Healing Potion       (100  gold)'),nl,
        write('b. Attack Potion        (250  gold)'),nl,
        write('c. Defense Potion       (250  gold)'),nl,
        write('d. Teleportation Scroll (1000 gold)'),nl,
        write('Ketik X diantara tanda petik untuk membeli X'), nl,
        read(Y),
        buy(Y), nl, fail
    ; (X =:= 3) ->
        bag,
        write('Ketik X diantara tanda petik untuk menjual X'), nl,
        read(Y),
        sell(Y), nl, fail
    ; (X =:= 4) ->
        write('Masukkan angka 1-5 untuk berinteraksi dengan Store!'), nl, nl, fail
    ;   write('Terimakasih sudah mengunjungi Store! :D'),nl,
        retract(isStore(_)),!
    ).

gacha :-
   \+isStore(_),
    write('Gacha hanya bisa dilakukan di Store!'),nl,
    write('Silahkan pergi ke Store terdekat!'),nl,!,fail.

gacha :-
    isStore(_),
    player(_,_,_,_,Gold,_,_,_,_,_),
    Gold < 1000,
    write('Gold Anda tidak cukup untuk melakukan Gacha!'),nl,
    write('Farming dulu broo'),nl,!,fail.

gacha :-
    isStore(_),
    isFull,
    write('Inventory Sudah Penuh!'),nl,
    write('Jual salah satu item Anda untuk bisa melakukan gacha!'),nl,!,fail.

gacha :-
    isStore(_),
    player(_,_,_,_,Gold,_,_,_,_,_),
    NewGold is Gold - 1000,
    retract(player(Name, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
    asserta(player(Name, Level, Job, Exp, NewGold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
    random(1,10,X),
    ( (X =< 4) ->
        random(1,6,Y),
        item(Y, ItemName, Type,Rarity,_,_,_,_,_,_),
        addInventory(Y),
        ( (Y =< 3) ->
            ( (Y =:= 1) ->
                commonAnimation, swordAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ; (Y =:= 2) ->
                commonAnimation, bowAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ;   commonAnimation, staffAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            )
        ;   commonAnimation, armorAnimation,
            write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
            write(', '), write(ItemName),nl,
            write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
        )
    ; (X =< 7) ->
        random(7,21,Y),
        item(Y, ItemName, Type,Rarity,_,_,_,_,_,_),
        addInventory(Y),
        ( (Y =< 9) ->
            ( (Y =:= 7) ->
                rareAnimation, swordAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ; (Y =:= 8) ->
                rareAnimation, bowAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ;   rareAnimation, staffAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            )
        ; (Y =< 12) -> 
            rareAnimation, armorAnimation,
            write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
            write(', '), write(ItemName),nl,
            write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
        ;   rareAnimation, accessoryAnimation,
            write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
            write(', '), write(ItemName),nl,
            write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
        )
    ; (X =< 9) ->
        random(22,27,Y),
        item(Y, ItemName, Type,Rarity,_,_,_,_,_,_),
        addInventory(Y),
        ( (Y =< 24) ->
            ( (Y =:= 22) ->
                epicAnimation, swordAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ; (Y =:= 23) ->
                epicAnimation, bowAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ;   epicAnimation, staffAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            )
        ;   epicAnimation, armorAnimation,
            write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
            write(', '), write(ItemName),nl,
            write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
        )
    ;   random(28,33,Y),
        item(Y, ItemName, Type,Rarity,_,_,_,_,_,_),
        addInventory(Y),
        ( (Y =< 30) ->
            ( (Y =:= 28) ->
                legendaryAnimation, swordAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ; (Y =:= 29) ->
                legendaryAnimation, bowAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            ;   legendaryAnimation, staffAnimation,
                write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
                write(', '), write(ItemName),nl,
                write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
            )
        ;   legendaryAnimation, armorAnimation,
            write('Anda mendapatkan sebuah '), write(Rarity), write(' '), write(Type),
            write(', '), write(ItemName),nl,
            write(ItemName), write(' berhasil ditambahkan ke Inventory Anda.'),nl,!
        )
    ).

addInventory(_) :-
    cekJumlahInventory(Sum),
    maxInventory(Max),
    Sum >= Max,
    write('Inventory Sudah Penuh'),
    !,fail.

addInventory(ID) :-
    findall(InvID, inventory(InvID,_,_,_,_,_,_,_,_,_,_), ListID),
    (   member_inventory(ID, ListID) ->
        item(ID, Name, _,_,_,_,_,_,_,_),
        retract(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count)),
        NewCount is Count+1,
        assertz(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, NewCount))
    ;   item(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price),
        Count is 1,
        assertz(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count))
    ).   

buy(_) :-
    \+isStore(_),
    write('Pembelian Items hanya bisa dilakukan di Store!'),nl,
    write('Silahkan pergi ke Store terdekat!'),nl,!,fail.

buy(Name) :-
    isStore(_),
    item(ID,Name,_,_,_,_,_,_,_,_),
    ID =< 33,
    write(Name), (' tidak bisa dibeli langsung!'), nl,
    write('Lakukan Gacha untuk mendapatkan '), write(Name),write('!'),nl,!,fail.

buy(Name) :-
    isStore(_),
    player(_,_,_,_,Gold,_,_,_,_,_),
    item(_,Name,_,_,_,_,_,_,_,Price),
    Gold < Price,
    write('Gold Anda tidak cukup untuk membeli '), write(Name), nl,
    write('Farming dulu broo'),nl,!,fail.

buy(_) :-
    isStore(_),
    isFull,
    write('Inventory Sudah Penuh!'),nl,
    write('Jual salah satu item Anda untuk bisa melakukan pembelian items!'),nl,!,fail.

buy(Name) :-
    isStore(_),
    item(ID,Name,_,_,_,_,_,_,_,Price),
    addInventory(ID),
    player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack),
    NewGold is Gold-Price,
    write(Name), write(' berhasil dibeli'), nl,
    write(Name), write(' berhasil ditambahkan ke Inventory Anda.'),
    write('Jumlah gold anda sekarang adalah '), write(NewGold), write(' gold.'),nl,
    retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
    asserta(player(NameP, Level, Job, Exp, NewGold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),!.

sell(_) :-
    \+isStore(_),
    write('Penjualan Items hanya bisa dilakukan di Store!'),nl,
    write('Silahkan pergi ke Store terdekat!'),nl,!,fail.

sell(Name) :-
    isStore(_),
    item(ID,Name,_,_,_,_,_,_,_,_),
    findall(InvID, inventory(InvID,_,_,_,_,_,_,_,_,_,_), ListID),
    \+member_inventory(ID, ListID),
    write('Items yang ingin Kamu jual tidak ada di inventory mu'), nl,
    !, fail.

sell(Name) :-
    isStore(_),
    player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack),
    inventory(ID,Name,_,_,_,_,_,_,_,Price,Count),
    NewCount is Count - 1,
    (   NewCount =:= 0 ->
        retract(inventory(ID,_,_,_,_,_,_,_,_,_,_))
    ;   retract(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, Count)),
        assertz(inventory(ID, Name, Type, Rarity, Class, AddAttack, AddDefense, AddMaxHP, AddCurrentHP, Price, NewCount))
    ),
    NewGold is Gold+Price,
    write('Items berhasil dijual'), nl,
    write('Jumlah gold anda sekarang adalah '), write(NewGold), write(' gold.'),nl,
    retract(player(NameP, Level, Job, Exp, Gold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),
    asserta(player(NameP, Level, Job, Exp, NewGold, MaxHealth, CurrentHealth, Attack, Defense, SpecialAttack)),!.

commonAnimation :-
    write('               ######   #######  ##     ## ##     ##  #######  ##    ## '),nl,
    write('              ##    ## ##     ## ###   ### ###   ### ##     ## ###   ## '),nl,
    write('              ##       ##     ## #### #### #### #### ##     ## ####  ## '),nl,
    write('              ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## '),nl,
    write('              ##       ##     ## ##     ## ##     ## ##     ## ##  #### '),nl,
    write('              ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### '),nl,
    write('               ######   #######  ##     ## ##     ##  #######  ##    ## '),nl.

rareAnimation :-
    write('                    ########       ###      ########    ######## '),nl, 
    write('                    ##     ##     ## ##     ##     ##   ##       '),nl,
    write('                    ##     ##    ##   ##    ##     ##   ##       '),nl,
    write('                    ########    ##     ##   ########    ######   '),nl,
    write('                    ##   ##     #########   ##   ##     ##       '),nl,
    write('                    ##    ##    ##     ##   ##    ##    ##       '),nl,
    write('                    ##     ##   ##     ##   ##     ##   ######## '),nl.

epicAnimation :-
    write('                      ########   ########    ####    ######  '),nl,
    write('                      ##         ##     ##    ##    ##    ## '),nl,
    write('                      ##         ##     ##    ##    ##       '),nl,
    write('                      ######     ########     ##    ##       '),nl,
    write('                      ##         ##           ##    ##       '),nl,
    write('                      ##         ##           ##    ##    ## '),nl,
    write('                      ########   ##          ####    ######  '),nl.

legendaryAnimation :-
    write('##       ########  ######   ######## ##    ## ########     ###    ########  ##    ## '),nl,
    write('##       ##       ##    ##  ##       ###   ## ##     ##   ## ##   ##     ##  ##  ##  '),nl,
    write('##       ##       ##        ##       ####  ## ##     ##  ##   ##  ##     ##   ####   '),nl,
    write('##       ######   ##   #### ######   ## ## ## ##     ## ##     ## ########     ##    '),nl,
    write('##       ##       ##    ##  ##       ##  #### ##     ## ######### ##   ##      ##    '),nl,
    write('##       ##       ##    ##  ##       ##   ### ##     ## ##     ## ##    ##     ##    '),nl,
    write('######## ########  ######   ######## ##    ## ########  ##     ## ##     ##    ##    '),nl.

swordAnimation :-
    write('                         _                                                 '),nl,
    write('              _         | |                                                '),nl,
    write('             | | _______| |---------------------------------------------\\  '),nl,
    write('             |:-)_______|==[]============================================> '),nl,
    write('             |_|        | |---------------------------------------------/  '),nl,
    write('                        |_|                                                '),nl.

bowAnimation :-                                         
    write('                              #######              ....*. '),nl,
    write('                    #####(#(##(&&&&&#(##(#%%%   ..../**.  '),nl,
    write('                    ##(##(&              %%##(#%**(#...   '),nl,
    write('                    %&&&&                     *(##%       '),nl,
    write('                       ##/                 **(# %%(%      '),nl,
    write('                          #/             *(##     %#%     '),nl,
    write('                            ##/       **(#         #(&&   '),nl,
    write('                               #/   *(##           #(&&   '),nl,
    write('                                 ##/#               ###&  '),nl,
    write('                               *(## #/              ###&  '),nl,
    write('                            **(#      ##/          #(##&  '),nl,
    write('                       **/%(##           #/        #(&&   '),nl,
    write('                     */%%#%&               ##/  ##(#(&&   '),nl,
    write('                  **/%#%%&(                   ####(#&     '),nl,
    write('                  &%&((                      &&&&&&     '),nl.

staffAnimation :-
    write('                             (`-._o_.-\')     '),nl,
    write('                              (`- | -\')      '),nl,
    write('                               `-.|.-\'       '),nl,
    write('                                 o|o          '),nl,
    write('                                ( | )         '),nl,
    write('                                 `!\'         '),nl,
    write('                                 (|)          '),nl,
    write('                                  X           '),nl,
    write('                                 (|)          '),nl,
    write('                                 \'|`         '),nl.

accessoryAnimation :-                                
    write('                           (&&&&&                 '),nl,
    write('                          (%%&     &              '),nl,
    write('                        ///.%   /&   #@.          '),nl,
    write('                       #/@(&      (&    #@        '),nl,
    write('                     %(@@&&@(@     (&      &,     '),nl,
    write('                    #&@@&@&&&@*.    %.       &.   '),nl,
    write('                    #&@@@@@@@@/.   %          &,  '),nl,
    write('                     (&@@@@@&/.   %.          &.  '),nl,
    write('                                %.          (&    '),nl,
    write('                                %.         *&.    '),nl,
    write('                                   *&#((&&*       '),nl.

armorAnimation :-
write('                               /+/ -++++++++hh++-                    '),nl,
write('                             +MNmNMMMMMMNmmmNNNmmNy                  '),nl,
write('                        -::hyyNMNdmMMNmddmNNMMMNNmMhy:::::           '),nl,
write('                   /++oodoNoMh+yNmddddmNMNh/yhNsshNyod::/yymdsd`     '),nl,
write('                  sMhyssm+mMMMNhmNMMMMNsshsyhMMMMd//Nh+///oyo+m`     '),nl,
write('                   dmy:-/hoNNsdMM/hyom//hhNMMMNdmhodh+sddhdmdh/      '),nl,
write('                   .Ndhss/NddhmMMym//myhNdNdhsosdNhdo:-:sMMMM/       '),nl,
write('                    `NsooyssNmmmymmddNsymooydhodN+./ddsydMMh-        '),nl,
write('                     /yhNd-+d+om:-oy/m+/Ny+oN:./dy:+hMMNMMd          '),nl,
write('                      /MMmyNy:+Ndhhdsmddd-.oN:::omddNMMmhMd          '),nl,
write('                      +MMMMMmdyN.+++++-ym++sNNshNMNMMMMMdNd`         '),nl,
write('                     -MMMMMNdsmN/ ` .smmMmhhNMMMMNdmMMMMMMMy         '),nl,
write('                    `mMMMMmmy yMNh+sNMmmd--dMMMNmhhmNMMMMMMy         '),nl,
write('                    oMMMMMmm` sMMmmNMMmNNs ymMMmhdmosMMMMMMd:        '),nl,
write('                   -NMMMMMhNy smdmMdsmdoos   MNdhN+ .hMMMMMMo        '),nl,
write('                  -mMMMMdmhmy sh+oNhhdyoos :hMMmhN.`dNMMMMMMy.       '),nl,
write('                 :dMMMMN/ddMy`ssoMm/:ds+ss yMMMmhm-.NmNMMNMMM+       '),nl,
write('                -dMMMNMo dMMy++  MNhdNh :y` mMMNmmM--mmNMMNMMM/      '),nl,
write('               .mMMMNMMh.dMMy++  MMMNNM `s+ .:MMMNMm /MmNMMMMMM`     '),nl,
write('              oNMMMMNMMMymMs/++  MMMmNM  ++  sMMMMMNoyMNmMMMNMMm     '),nl,
write('              //oddNMMMMMMMm ++  MNNmNMs ++  MMMmdmmddNMm+mMMMMN.    '),nl,
write('                   -:m/dMMN- ++  MNmmmMm ++  MMNdddmNNd/` oMMMMho    '),nl,
write('                     o/`/o.  ++  smmmdNm -o. MMMNMNmo/` `++````      '),nl,
write('                     `odh:   +mo-/NdmmNNsyd: /////`-:++ho            '),nl,
write('                        .s+++s: --. .---  /o+++++++--                '),nl.

