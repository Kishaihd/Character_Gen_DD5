library model.modify;

String capitalize(String word) {
  String firstLetter = word[0].toUpperCase();
  
  if (word.length > 1) {
    return "${firstLetter}${word.substring(1)}";
  }    
  return "${firstLetter}";
}

// This class will handle extraneous data modification/manipulations that come from sources
// such as, items/equipment, conditional/combat bonuses and modifiers.

class Modify {
  int _modValue;
  String _effectName;
  String _description;
  
  Modify();
  
  Modify.parameterized(int value, String name, String description) {
    _modValue = value;
    _effectName = name;
    _description = description;
  }
  void increase(int amount) {
    _modValue += amount;
  }
  
  void decrease(int amount) {
    _modValue -= amount;    
  }
  
  String addAttribute(String attribute) {
    
    return attribute;
  }
  
  
  int get value => _modValue;
  String get name => _effectName;
  String get description => _description;

  @override toString() {
    return "${capitalize(_effectName)}. $_description by $_modValue";
  }
}


//Derivative classes will be specificly for abilities, skills, hp, damage, speed? Etc? Maybe?

class Mod_Ability extends Modify {
  String _source;
//  int _mod; 
  String _ability;
  
  Mod_Ability();
  
  String get source => _source;
  String get ability => _ability;
}





