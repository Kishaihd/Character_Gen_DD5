library Character_Gen_DD5;

String capitalize(String word) {
  String firstLetter = word[0].toUpperCase();
  
  if (word.length > 1) {
    return "${firstLetter}${word.substring(1)}";
  }
  else {
    return "${firstLetter}";
  }
}

// This class will handle extraneous data modification/manipulations that come from sources
// such as, items/equipment, conditional/combat bonuses and modifiers.

/* Example generals:
  hp, abilities, skills, size, speed, status,

*/
class Mod {
  int _modValue;
  String _affects_general; //General type of thing affected (Ability, Skill, Speed, Size, etc)
  String _affects_specific; // Specific thing affected.
  String _effectName;
  String _description;


  Mod(this._modValue, this._affects_general, this._affects_specific, this._effectName, this._description);
  
  Mod.parameterized(int value, String statType, String affectedStat, String name, String description) {
    _modValue = value;
    _affects_general = statType;
    _affects_specific = affectedStat;
    _effectName = name;
    _description = description;
  }
  void increase(int amount) {
    _modValue += amount;
  }
  
  void decrease(int amount) {
    _modValue -= amount;    
  }
  
//  String addAttribute(String attribute) {
//
//    return attribute;
//  }
  
  
  int get value => _modValue;
  String get modType => _affects_general;
  String get affects => _affects_specific;
  String get name => _effectName;
  String get description => _description;

  @override toString() {
    return "${capitalize(_effectName)}. $_description by $_modValue";
  }
}


////Derivative classes will be specifically for abilities, skills, hp, damage, speed? Etc? Maybe?
//
//class Mod_Ability extends Mod {
//  String _source;
////  int _mod;
//  String _ability;
//
//  Mod_Ability(int value, String affectedStat, String name, String description, String source, String ability) : super(value, affectedStat, name, description) {
//    _source = source;
//    _ability = ability;
//  }
//
//  String get source => _source;
//  String get ability => _ability;
//}





