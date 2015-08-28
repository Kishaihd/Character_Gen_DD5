library Character_Gen_DD5;

import 'dart:convert';
import 'dice.dart';
import 'modify.dart';

class Item {
  String _objType;
  String _name;
  String _type;
  String _size;
  int _value;
  int _weight;
  bool _equipable;
  String _description;
  bool _enchanted;
  int _magicBonusValue;
  String _location;

  Item(this._name, this._type, this._size, this._value, this._weight, this._equipable, this._description, [this._enchanted = false, this._magicBonusValue = 0, this._location = ""]) {
    _objType = "item";
  }

  Item.fromMap(String js) {
    Map jsm = JSON.decode(js);
    this._objType = "item";

    this._name = jsm["name"];
    this._type = jsm["type"];
    this._size = jsm["size"];
    this._value = jsm["value"];
    this._weight = jsm["weight"];
    this._equipable = jsm["equipable"];
    this._description = jsm["description"];
    this._enchanted = jsm["enchanted"];
    this._magicBonusValue = jsm["magicBonusValue"];
    this._location = jsm["location"];
  }



//  String capitalize(String word) {
//    String firstLetter = word[0].toUpperCase();
//    
//    if (word.length > 1) {
//      return "${firstLetter}${word.substring(1)}";
//    }    
//    return "${firstLetter}";
//  }

  void enchant(int bonusValue) {
    _enchanted = true;
    _description = _description == null ? "Enchanted $_name" : "Enchanted " + _description;
    _magicBonusValue = bonusValue;
  }

  String get objType => _objType;
  String get name => _name;
  String get type => _type;
  String get size => _size;
  int get value => _value;
  int get weight => _weight;
  bool get equipable => _equipable;
  int get magicBonus => _magicBonusValue;
  String get description {
    if (_description == null) {
      if (_enchanted) {
        return "Enchanted $_name";
      }
      else {
        return "$_name.";
      }
    } // End description == null
    else {
      if (_enchanted) {
        return "Enchanted $_description";
      }
      else {
        return "$_description.";
      }
    }
  }

  bool get isEnchanted => _enchanted;
  void set location(String loc) { _location = loc; }
  void set description(String describeMe) {
    if (_enchanted == true) {
      _description = "Enchanted" + describeMe;
    }
    else {
      _description = describeMe;
    }    
  } // End set description.  
  
}


class Armor extends Item {
  int _armorBonus;
  int _maxDex;
  int _movementPenalty;
  
  Armor(String name, String type, String size, int value, int weight, bool equipable, String location, int bonus, int maxDex, int movePenalty, [String description = "", bool enchanted = false, int magicBonusValue = 0]) : super(name, type, size, value, weight, true, description, enchanted, magicBonusValue) {
    _objType = "armor";
    _location = location.toLowerCase();
    _armorBonus = bonus;
    _maxDex = maxDex;
    _movementPenalty = movePenalty;
  }
  
  int get armorBonus => _enchanted == true ? (_magicBonusValue + _armorBonus) : _armorBonus;

  @override toString() => "${capitalize(name)} \n   Location: ${capitalize(_location)} \n   AC bonus: $_armorBonus \n   Max Dexterity: $maxDex \n   Movement Penalty: $_movementPenalty";
  
  //int get armorBonus => _armorBonus;
  int get movePenalty => _movementPenalty;
  String get location => _location;
  int get maxDex => _maxDex == null ? 5 : _maxDex;
  
} // End class Armor.



class Weapon extends Item {
  int _damageDieType;
  int _numDice;
  String _dmgType;
  int _magicDmgDie;
  int _numMagicDice;
  String _magicDmgType;
  DamageDice _dieRoll;
  DamageDice _magDieRoll;
//  List<String> _properties;

  Map<String, dynamic> _weaponProperties = {
    "Ammunition" : "Must have ammunition to attack with this weapon; Can recover half ammo at end of battle if one minute is spent; Can use ammo as an improvised weapon.",
    "Finesse" : "Can use Strength OR Dexterity for attacks and damage. Must use same ability for both"
  };

  Weapon(String name, String type, String size, int value, int weight, bool isEquipable, int dmgDie, int numDice, String dmgType, [String description, bool enchanted = false, int magicBonusValue = 0, int mgcDmgDieType = 6 /*d6*/, int numMgcDice = 0]) : super(name, type, size, value, weight, true, description, enchanted, magicBonusValue) {
    _objType = "weapon";
    _damageDieType = dmgDie;
    _numDice = numDice;
    _dmgType = dmgType;
    _magicDmgDie = mgcDmgDieType;
    _numMagicDice = numMgcDice;
    _dieRoll = new DamageDice(numDice, dmgDie);
    //_properties = properties;
    //_properties = [];
    if (enchanted) {
      _magDieRoll = new DamageDice(numMgcDice, mgcDmgDieType);
    }
  }

  int rollDamage(){
    int damage = 0;
    if (_enchanted) {
      damage += _magDieRoll.rollDamage();
    }
    damage += _dieRoll.rollDamage();

    return damage;
  }


  @override toString() => "${capitalize(name)} - Deals ${_numDice}d${_damageDieType} ${capitalize(dmgType)} damage.";

  void set location(String loc) { _location = loc ;}

  int get damageDie => _damageDieType;

  int get numDice => _numDice;

  String get dmgType => _dmgType;

  int get magicDmg => _magicDmgDie == null ? 0 : _magicDmgDie;

  String get magicDmgType => _magicDmgType == null ? 0 : _magicDmgType;

  String get properties {
    String props = "";
    _weaponProperties.forEach((String pro, dynamic val) => props += pro + "\n");
    return props;
  }

}
//
//// Should I have a list somewhere of all the weapons? Mebe?
//class Scimitar implements Weapon {
//
//  Scimitar("Scimitar", "Melee", "Medium", 25, 3, 6, 1, "Slashing", "", ) : super("Scimitar", "Melee", "Medium", 25, 3, true, 6, 1, "Slashing") {
//    /*_name = "Scimitar";
//    _type = "Melee";
//    _size = "Medium";
//    _value = 25;
//    _weight = 3;
//    _damageDie = 6;
//    _numDice = 1;
//    _dmgType = "Slashing";
//    _description = "";
//    _weaponProperties.add("Light");
//    _weaponProperties.add("Finesse");*/
//  }
//}


// C'est necessaire?
class Inventory { // Basically just a custom Map class.
  int _quantity;
  var _item;
  List<dynamic> _inventory;

  Inventory();

  Inventory.fromMap() {

  }

  void addItem(dynamic item) {
    switch(item.objType) {
      case 'item' :
        break;
      case 'weapon' :
        break;
      case 'armor' :
        break;
      default:
        break;
    }
  }

}



