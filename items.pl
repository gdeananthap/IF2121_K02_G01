/*** Items ***/
/** Terdiri dari equipment, potion, dan scroll **/

/*** Equipments untuk Player ***/
/** Terdiri dari weapon, armor, dan accessory **/
/** Tiap Player Bakal Dapat 1 Common Weapon diawal Permainan **/
/** Equipment Lain didapatkan dengan sistem gacha di shop **/
/** Jika pemain menjual equipment, maka pemain mendapatkan gold seharga item tersebut **/
/** item(ID, Name, Type, Rarity, Class, addAttack, addDefense, addMaxHP, addCurrentHP, Price) **/

/*** Common Equipment ***/
/** Common Weapon **/
item(1, 'Wooden Sword', weapon, common, swordsman, 10, 0, 0, 0, 1000).
item(2, 'Wooden Bow', weapon, common, archer, 10, 0, 0, 0, 1000).
item(3, 'Wooden Staff', weapon, common, sorcerer, 10, 0, 0, 0, 1000).

/** Common Armor **/
item(4, 'Bronze Plate', armor, common, swordsman, 0, 10, 25, 0, 1000).
item(5, 'Leather Vest', armor, common, archer, 0, 10, 25, 0, 1000).
item(6, 'Black Cloak', armor, common, sorcerer, 0, 10, 25, 0, 1000).

/*** Rare Equipment ***/
/** Rare Weapon **/
item(7, 'Hammer of Frost', weapon, rare, swordsman, 20, 0, 0, 0, 2500).
item(8, 'Red Eye Bow', weapon, rare, archer, 20, 0, 0, 0, 2500).
item(9, 'Flare of Lethality', weapon, rare, sorcerer, 20, 0, 0, 0, 2500).

/** Rare Armor **/
item(10, 'Villi Ancient Garb', armor, rare, swordsman, 0, 20, 50, 0, 2500).
item(11, 'Tunic of Courage', armor, rare, archer, 0, 20, 50, 0, 2500).
item(12, 'Glintstone Robe', armor, rare, sorcerer, 0, 20, 50, 0, 2500).

/*** Accessory ***/
/** Swordsman **/
item(13, 'Ancient Planar Pendant', accessory, rare, swordsman, 15, 15, 0, 0, 2500).
item(14, 'Amulet of Doom', accessory, rare, swordsman, 0, 15, 25, 0, 2500).
item(15, 'Ring of Gleipnir', accessory, rare, swordsman, 15, 0, 25, 0, 2500).

/** Archer **/
item(16, 'Circlet of Thorns', accessory, rare, archer, 15, 15, 0, 0, 2500).
item(17, 'Starpower Bracelet', accessory, rare, archer, 0, 15, 25, 0, 2500).
item(18, 'Ring of Punishment', accessory, rare, archer, 15, 0, 25, 0, 2500).

/** Sorcerer **/
item(19, 'Wings of Heaven', accessory, rare, sorcerer, 15, 15, 0, 0, 2500).
item(20, 'Floral Bracelet', accessory, rare, sorcerer, 0, 15, 25, 0, 2500).
item(21, 'Ring of Wisdom', accessory, rare, sorcerer, 15, 0, 25, 0, 2500).

/*** Epic Equipment ***/
/** Epic Weapon **/
item(22, 'Dragon Hunter Sword', weapon, epic, swordsman, 40, 0, 0, 0, 5000).
item(23, 'Frostywind Yeti Bow', weapon, epic, archer, 40, 0, 0, 0, 5000).
item(24, 'Flamed Forged Staff', weapon, epic, sorcerer, 40, 0, 0, 0, 5000).

/** Epic Armor **/
item(25, 'Uller Blazing Plate', armor, epic, swordsman, 0, 40, 100, 0, 5000).
item(26, 'Plate of Brilliance', armor, epic, archer, 0, 40, 100, 0, 5000).
item(27, 'Flame Mail of Hexstone', armor, epic, sorcerer, 0, 40, 100, 0, 5000).

/*** Legendary Equipment ***/
/** Legendary Weapon **/
item(28, 'Maul of Ullerus', weapon, legendary, swordsman, 60, 0, 0, 0, 10000).
item(29, 'Ethereal Bow of Judgement', weapon, legendary, archer, 60, 0, 0, 0, 10000).
item(30, 'Infused Orbital Catalyst', weapon, legendary, sorcerer, 60, 0, 0, 0, 10000).

/** Legendary Armor **/
item(31, 'Himingleva Armor', armor, legendary, swordsman, 0, 60, 150, 0, 1000).
item(32, 'Robe of Arcanist', armor, legendary, archer, 0, 60, 150, 0, 1000).
item(33, 'Emerald of Enchantress', armor, legendary, sorcerer, 0, 60, 150, 0, 1000).

/*** Potions ***/
/** Potion dapat dibeli saat pemain berada di shop **/
/** Potion dapat digunakan saat pemain berada di battle-scene **/
item(34, 'Heal Potion', potion, common, _ , 0, 0, 0, 50, 100).
item(35, 'Attack Potion', potion, common, _ , 20, 0, 0, 0, 250).
item(36, 'Defense Potion', potion, common, _ , 0, 20, 0, 0, 250).

/*** Teleportation Scroll ***/
/** Teleportation scroll dapat dibeli saat pemain berada di shop**/
/** Teleportation Scroll dapat digunakan saat pemain di exploration-scene untuk pindah ke sebuah tiles di map**/
item(37, 'Teleportation Scroll', scroll, rare, _ , 0, 0, 0, 0, 1000).