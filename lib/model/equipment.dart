library model.equipment;

import 'dice.dart';

class Item {
  String _name;
  String _type;
  String _size;
  int _value;
  int _weight;
  String _description;
  bool _enchanted;
  int _magicBonusValue;
  
  Item(String name, String type, String size, int value, int weight, String description, [bool enchanted = false, int magicBonusValue = 0]) {
    _name = name;
    _type = type;
    _size = size;
    _value = value;
    _weight = weight;
    _description = description;
    _enchanted = enchanted;
    _magicBonusValue = magicBonusValue;
  }
  
  void enchant(int bonusValue) {
    _enchanted = true;
    _description = _description == null ? "Enchanted item" : "Enchanted " + _description;
    _magicBonusValue = bonusValue;
  }
  
  String get name => _name;
  String get type => _type;
  String get size => _size;
  int get value => _value;
  int get weight => _weight;
  int get magicBonus => _magicBonusValue;
  String get description => _description == null ? "No description available." : _description;
  bool get isEnchanted => _enchanted;
  
  void set description(String describe) {
    if (_enchanted == true) {
      _description = "Enchanted" + describe;
    }
    else {
      _description = describe;      
    }    
  } // End set description.  
  
}


class Armor extends Item {
  int _armorBonus;  
  int _maxDex;
  int _movementPenalty;
  
  Armor(String name, String type, String size, int value, int weight, int bonus, int maxDex, int movePenalty, String description, [bool enchanted = false, int magicBonusValue = 0]) : super(name, type, size, value, weight, description, enchanted, magicBonusValue) {
    _armorBonus = bonus;
    _movementPenalty = movePenalty;
    _maxDex = maxDex;
  }
  
  int get armorBonus => _enchanted == true ? (_magicBonusValue + _armorBonus) : _armorBonus;
  
  @override toString() => "$_name\n AC bonus: $_armorBonus Max Dexterity: $_maxDex Movement Penalty: $_movementPenalty";
  
} // End class Armor.

class Weapon extends Item {
  int _damageDie;
  int _numDice;
  String _dmgType;
  int _magicDmg;
  String _magicDmgType;
  
  Weapon(String name, String type, String size, int value, int weight, int dmgDie, int numDice, String dmgType, String description, [bool enchanted = false, int magicBonusValue = 0]) : super(name, type, size, value, weight, description, enchanted, magicBonusValue) {
    _damageDie = dmgDie;
    _numDice = numDice;
    _dmgType = dmgType;
  }

  void enchant(int bonusValue) {
      _enchanted = true;
      _description = _description == null ? "Enchanted Weapon" : "Enchanted " + _description;
      _magicBonusValue = bonusValue;
    }
  
  @override toString() => "$_name\n Deals ${_numDice}d${_damageDie} $_dmgType";
}


