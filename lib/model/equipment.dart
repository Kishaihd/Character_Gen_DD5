library model.equipment;

import 'dice.dart';
import 'modify.dart';

class Item {
  String _name;
  String _type;
  String _size;
  int _value;
  int _weight;
  String _description;
  bool _enchanted;
  int _magicBonusValue;
  
  Item(String name, String type, String size, int value, int weight, [String description, bool enchanted = false, int magicBonusValue = 0]) {
    _name = name;
    _type = type;
    _size = size;
    _value = value;
    _weight = weight;
    _description = description;
    _enchanted = enchanted;
    _magicBonusValue = magicBonusValue;
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
  String _location;
  
  Armor(String name, String type, String size, int value, int weight, String location, int bonus, int maxDex, int movePenalty, [String description = "", bool enchanted = false, int magicBonusValue = 0]) : super(name, type, size, value, weight, description, enchanted, magicBonusValue) {
    _location = location.toLowerCase();
    _armorBonus = bonus;
    _maxDex = maxDex;
    _movementPenalty = movePenalty;
  }
  
  int get armorBonus => _enchanted == true ? (_magicBonusValue + _armorBonus) : _armorBonus;
  
  @override toString() => "${capitalize(name)} \nLocation: ${capitalize(_location)} \nAC bonus: $_armorBonus \nMax Dexterity: $maxDex \nMovement Penalty: $_movementPenalty";
  
  //int get armorBonus => _armorBonus;
  int get movePenalty => _movementPenalty;
  String get location => _location;
  int get maxDex => _maxDex == null ? 5 : _maxDex;
  
} // End class Armor.



