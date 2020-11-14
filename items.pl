/*** Items ***/
/** Terdiri dari equipment, potion, dan scroll **/

/*** Equipments untuk Player ***/
/** Terdiri dari weapon, armor, dan accessory **/
/** Tiap Player Bakal Dapat 1 Common Weapon diawal Permainan **/
/** Equipment Lain didapatkan dengan sistem gacha di shop **/
/** Jika pemain menjual equipment, maka pemain mendapatkan gold seharga item tersebut **/
/** item(ID, Name, Type, Rarity, Class, addAttack, addDefense, addMaxHP, addCurrentHP, Price) **/

/*** WEAPON ***/
/** Common Weapon **/
item(1, wooden_sword, weapon, common, swordsman, 10, 0, 0, 0, 100).
item(2, wooden_bow, weapon, common, archer, 10, 0, 0, 0, 100).
item(3, wooden_staff, weapon, common, sorcerer, 10, 0, 0, 0, 100).

/** Rare Weapon **/
item(4, hammer_of_frost, weapon, rare, swordsman, 20, 0, 0, 0, 250).
item(5, red_eye_bow, weapon, rare, archer, 20, 0, 0, 0, 250).
item(6, flare_of_lethality, weapon, rare, sorcerer, 20, 0, 0, 0, 250).

/** Epic Weapon **/
item(7, dragon_hunter_sword, weapon, epic, swordsman, 40, 0, 0, 0, 500).
item(8, frostywind_yeti_bow, weapon, epic, archer, 40, 0, 0, 500).
item(9, flamed_forged_staff, weapon, epic, sorcerer, 40, 0, 0, 0, 500).

/** Legendary Weapon **/
item(10, maul_of_ollerus, weapon, legendary, swordsman, 60, 0, 0, 0, 1000).
item(11, ethereal_bow_of_judgement, weapon, legendary, archer, 60, 0, 0, 0, 1000).
item(12, infused_orbital_catalyst, weapon, legendary, sorcerer, 60, 0, 0, 0, 1000).

/*** Armor ***/
/** Common Armor **/
item(13, bronze_plate, armor, common, swordsman, 0, 10, 25, 0, 100).
item(14, leather_vest, armor, common, archer, 0, 10, 25, 0, 100).
item(15, black_cloak, armor, common, sorcerer, 0, 10, 25, 0, 100).

/** Rare Armor **/
item(16, villi_ancient_garb, armor, rare, swordsman, 0, 20, 50, 0, 250).
item(17, tunic_of_courage, armor, rare, archer, 0, 20, 50, 0, 250).
item(18, glintstone_robe, armor, rare, sorcerer, 0, 20, 50, 0, 250).

/** Epic Armor **/
item(19, uller_blazing_plate, armor, epic, swordsman, 0, 40, 100, 0, 500).
item(20, plate_of_brilliance, armor, epic, archer, 0, 40, 100, 0, 500).
item(21, flame_mail_of_hexstone, armor, epic, sorcerer, 0, 40, 100, 0, 500).

/** Legendary Armor **/
item(22, himingleva_armor, armor, legendary, swordsman, 0, 60, 150, 0, 1000).
item(23, robe_of_arcanist, armor, legendary, archer, 0, 60, 150, 0, 1000).
item(24, emerald_enchantress, armor, legendary, sorcerer, 0, 60, 150, 0, 1000).

/*** Accessory ***/
/** Swordsman **/
item(25, ancient_planar_pendant, accessory, rare, swordsman, 15, 15, 0, 0, 250).
item(26, amulet_of_doom, accessory, rare, swordsman, 0, 15, 25, 0, 250).
item(27, ring_of_gleipnir, accessory, rare, swordsman, 15, 0, 25, 0, 250).

/** Archer **/
item(28, circlet_of_thorns, accessory, rare, archer, 15, 15, 0, 0, 250).
item(29, starpower_bracelet, accessory, rare, archer, 0, 15, 25, 0, 250).
item(30, ring_of_punishment, accessory, rare, archer, 15, 0, 25, 0, 250).

/** Sorcerer **/
item(31, wings_of_heaven, accessory, rare, sorcerer, 15, 15, 0, 0, 250).
item(32, floral_bracelet, accessory, rare, sorcerer, 0, 15, 25, 0, 250).
item(33, ring_of_wisdom, accessory, rare, sorcerer, 15, 0, 25, 0, 250).

/*** Potions ***/
/** Potion dapat dibeli saat pemain berada di shop **/
/** Potion dapat digunakan saat pemain berada di battle-scene **/
item(34, heal_potion, potion, common, _ , 0, 0, 0, 50, 100).
item(35, attack_potion, potion, common, _ , 20, 0, 0, 0, 150).
item(36, defense_potion, potion, common, _ , 0, 20, 0, 0, 150).

/*** Teleportation Scroll ***/
/** Teleportation scroll dapat dibeli saat pemain berada di shop**/
/** Teleportation Scroll dapat digunakan saat pemain di exploration-scene untuk pindah ke sebuah tiles di map**/
item(37, teleportation_scroll, scroll, epic, _ , 0, 0, 0, 0, 500).