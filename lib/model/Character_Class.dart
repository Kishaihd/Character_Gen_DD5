library model.character_class;

import 'ability.dart';
import 'dart:convert';

class CharClass {
  final int TIER_ONE = 4;
  final int TIER_TWO = 8;
  final int TIER_THREE = 12;
  final int TIER_FOUR = 16;
  final int TIER_FIVE = 20;
  final int BASE_SPELL_MOD = 8;
  
  String CLASS_FEATURES_PATH;
  
  String _name;
  int _hitDie;
  int _level;
  int _proficiencyBonus;
  List<String> _primaryAbilities;
  String _numberOfSkills;
  bool _knowsSpells = false;
  List<String> _skillProficiency;
  List<String> _armorProficiency;
  List<String> _weaponProficiency;
  List<String> _toolProficiency;
  List<String> _savingThrowProficiency;
  String _description;
  
  // Should these be in the specific class?
  String _casterStat;
  int _spellSaveDC;
  int _spellAttackMod;
  int _cantripsKnown;
  int _spellsKnown;
  int _spellSlots;
  Map<int, int> spellSlotsPerLevel = {
    1 : 0,
    2 : 0,
    3 : 0,
    4 : 0,
    5 : 0,
    6 : 0,
    7 : 0,
    8 : 0,
    9 : 0
  };
  
  

  CharClass([int level = 1]) {
    _level = level;
    
    _spellSaveDC = 0;
    _spellAttackMod = 0;
    _cantripsKnown = 0;
    _spellsKnown = 0;
  
    calcProficiencyBonus();
  }
  
  void levelUp() {
    _level += 1;
    calcProficiencyBonus();
  }
  
  // This should never or rarely be used. 
  void levelDown() {
    _level -= 1;
    calcProficiencyBonus();
  }
  
//  void calcSpellSaveDC() {
//    
//  }
//  
//  void calcSpellAttackMod() {
//    
//  }
  
  int calcProficiencyBonus() {
    if (_level <= TIER_ONE) {
      _proficiencyBonus = 2;
    }
    else if (_level > TIER_ONE && _level <= TIER_TWO) {
          _proficiencyBonus = 3;
    }
    else if (_level > TIER_TWO && _level  <= TIER_THREE) {
          _proficiencyBonus = 4;
    }
    else if (_level > TIER_THREE && _level  <= TIER_FOUR) {
          _proficiencyBonus = 5;
    }
    else if (_level > TIER_FOUR && _level  <= TIER_FIVE) {
          _proficiencyBonus = 6;
    }
    return _proficiencyBonus;
  }
  
  
  // ################
  // ### UNTESTED ###
  // ################
  // Alternate, shorter proficiency calculation! :D
  void calcProfBonus() {
    // Divide level by 4, then add the "rounding constant", then round the number. Pulling up or down to the correct number.
    int tier = ((_level / 4) + 0.25).round(); // 1 to 5

    _proficiencyBonus = tier + 1;
  }
  
  void calcCasterStats(Ability ability) {
    _spellAttackMod = (_proficiencyBonus + ability.mod);
    _spellSaveDC = (BASE_SPELL_MOD + _spellAttackMod);
  }  
  
  void calcSmallSpellSlots() {
    // First level
    if (_level < 3) {
      spellSlotsPerLevel[1] = 0;
    }
    else if (_level == 3) {
      spellSlotsPerLevel[1] = 2;
    }
    else if (_level >= 4 && _level <= 6) {
      spellSlotsPerLevel[1] = 3;
    }
    else {
      spellSlotsPerLevel[1] = 4;
    }
    
    // Second level
    if (_level < 7) {
      spellSlotsPerLevel[2] = 0;
    }
    else if (_level >= 7 && _level <= 9) {
        spellSlotsPerLevel[2] = 2;
    }
    else {
      spellSlotsPerLevel[2] = 3;
    }
    // Third level
    if (_level < 13) {
      spellSlotsPerLevel[3] = 0;
    }
    else if (_level >= 13 && _level <= 15) {
      spellSlotsPerLevel[3] = 2;
    }
    else {
      spellSlotsPerLevel[3] = 3;
    }
     
    // Fourth level
    if (_level < 19) {
      spellSlotsPerLevel[4] = 0;
    }
    else {
      spellSlotsPerLevel[4] = 1;
    }
  }
  
  void calcBigSpellSlots() {
    // First level
    if (_level < 4) {
      spellSlotsPerLevel[1] = _level + 1;
    }
    else {
      spellSlotsPerLevel[1] = 4;
    }
    
    // Second level
    if (_level < 3) {
      spellSlotsPerLevel[2] = 0;
    }
    else if (_level == 3) {
        spellSlotsPerLevel[2] = 2;
    }
    else {
      spellSlotsPerLevel[2] = 3;
    }

    // Third level
    if (_level < 5) {
      spellSlotsPerLevel[3] = 0;
    }
    else if (_level == 5) {
      spellSlotsPerLevel[3] = 2;
    }
    else {
      spellSlotsPerLevel[3] = 3;
    }
    
    // Fourth level
    if (_level < 7) {
      spellSlotsPerLevel[4] = 0;
    }
    else if (_level == 7) {
      spellSlotsPerLevel[4] = 1;
    }
    else if (_level == 8) {
      spellSlotsPerLevel[4] = 2;
    }
    else {
      spellSlotsPerLevel[4] = 3;
    }
    
    // Fifth level
    if (_level < 9) {
      spellSlotsPerLevel[5] = 0;
    }
    else if (_level == 9) {
      spellSlotsPerLevel[5] = 1;
    }
    else if (_level >= 10 || _level <= 17) {
      spellSlotsPerLevel[5] = 2;
    }
    else {
      spellSlotsPerLevel[5] = 3;
    }
    
    // Sixth level
    if (_level < 11) {
      spellSlotsPerLevel[6] = 0;
    }
    else if (_level >= 11 || _level <= 18) {
      spellSlotsPerLevel[6] = 1;
    }
    else {
      spellSlotsPerLevel[6] = 2;
    }
    
    // Seventh level
    if (_level < 13) {
      spellSlotsPerLevel[7] = 0;
    }
    else if (_level >= 13 || _level <= 19) {
      spellSlotsPerLevel[7] = 1;
    }
    else {
      spellSlotsPerLevel[7] = 2;
    }
    
    // Eighth level
    if (_level < 15) {
      spellSlotsPerLevel[8] = 0;
    }
    else {
      spellSlotsPerLevel[8] = 1;
    }
    
    // Ninth level
    if (_level < 17) {
      spellSlotsPerLevel[9] = 0;
    }
    else {
      spellSlotsPerLevel[9] = 1;
    }
     
  }
  
  void learnsSpells(bool answer) {
    _knowsSpells = answer;
  }
  
  int spellSlotsAtLevel(int spellLevel) {
    return spellSlotsPerLevel[spellLevel];
  }
  
  // Getters.
  String get name => _name;
  int get hitDie => _hitDie;
  int get level => _level;
  int get proficiencyBonus => _proficiencyBonus;
  String get description => _description;
  bool get knowsSpells => _knowsSpells;
  String get numSkills => _numberOfSkills;      // Use these two together!
  List<String> get skills => _skillProficiency; // Use these two together!

  //  String get numAndSkills =>
  
  List<String> get armors => _armorProficiency;
  List<String> get weapons => _weaponProficiency;
  List<String> get tools => _toolProficiency;
  List<String> get savingThrows => _savingThrowProficiency;
  int get spellSaveDC => _spellSaveDC;
  int get spellAttackMod => _spellAttackMod;
  String get casterStat => _casterStat;
  int get cantripsKnown => _cantripsKnown;
  int get baseSpellMod => BASE_SPELL_MOD;
  String get FEATURES_PATH => CLASS_FEATURES_PATH;
  
  
  int getSpellSlotsAt(int spellLevel) => spellSlotsPerLevel[spellLevel];
  
  // Setters.
  void setLevel(int level) {_level = level;}
  void setSpellSlotsAtLevel(int spellLevel, int numberOfSlots) {
    spellSlotsPerLevel[spellLevel] = numberOfSlots;
  }
    
} // End CharClass parent class.



/*=======================================================================================*/





// === The Warlock Class! ===
class Warlock extends CharClass {
  String _patron;
  String _pact;
//  int _spellsKnown;
//  int _spellSlots;
  int _spellSlotLevel;
  int _invocationsKnown = 0;  
  
  final String CLASS_FEATURES_PATH = "model/warlock_class_features.json";
  
  List<Map<String, String>> class_features = [];
  
  List<String> patronChoices = ["The Fiend", "The Archfey", "The Great Old One"];
  
  List<String> pactChoices = ["Blade", "Tome", "Chain"];
  
  // What a huge constructor...
  Warlock([int level = 1]) : super(level) {
    _name = "Warlock";
    _hitDie = 8;
    _level = level;
    _casterStat = "Charisma";
    _primaryAbilities = ["Charisma"];
    _numberOfSkills = "Choose two skills from: ";
    _skillProficiency = [
      "Arcana", 
      "Deception", 
      "History", 
      "Intimidation", 
      "Investigation",
      "Nature",
      "Religion"
    ];
    _armorProficiency = ["Light Armor"];
    _weaponProficiency = ["Simple Weapons"];
    _toolProficiency = ["None"];
    _savingThrowProficiency = [
      "Wisdom",
      "Charisma"
    ];
    _description = "The Warlock is a wielder of magic that is derived from a bargain with an extraplanar entity.";
    
    class_features = JSON.decode(FEATURES_PATH);
    
    calcProficiencyBonus();
    refactor(); 

  }

//  List<Map<String, String>> class_features = [
//    {"Otherworldly Patron" : "stuff", "Pact Magic" : "stuff"},
//    {"Eldritch Invocations" : ""},
//    {"" : ""},
//    {"" : ""},
//    {},
//    {"" : ""},
//    {},
//    {"" : ""},
//    {},
//    {"" : ""},
//    {"" : ""},
//    {"" : ""},
//    {"" : ""},
//    {"" : ""},
//    {"" : ""},
//    {"" : ""},
//    {"" : ""},
//    {},
//    {"" : ""},
//    {"" : ""}
//  ];                            
  
  void setPatron(patronChoice) {
    _patron = patronChoice;
  }
  
  Map<int, String> features = {
    1 : "Otherworldy Partron"
  };
  
  void warlockLevelUp() {
    levelUp();
    refactor();
  }
  
  void refactor() {
    calcCantripsKnown();
    calcNumSpellsKnown();
    calcSpellSlots();
    calcSpellSlotLevel();
    calcInvocationsKnown();
  }
  
  int calcCantripsKnown() {
    if (_level <= 3) {
      _cantripsKnown = 2;
    }
    if (_level > 3 && _level <= 9) {
      _cantripsKnown = 3;
    }
    if (_level > 9 && _level  <= TIER_FIVE) {
      _cantripsKnown = 4;
    }
    return _cantripsKnown;
  }
  
  // Better way to do this? Ugh.
  int calcNumSpellsKnown() {
    if (_level < 10) {
      _spellsKnown = _level + 1;
    }
    if (_level == 10) {
      _spellsKnown = 10;
    }
    if (_level == 11 || _level  == 12) {
      _spellsKnown = 11;
    }
    if (_level == 13 || _level  == 14) {
      _spellsKnown = 12;
    }
    if (_level == 15 || _level  == 16) {
      _spellsKnown = 13;
    }
    if (_level == 17 || _level  == 18) {
      _spellsKnown = 14;
    }
    if (_level == 19 || _level  == 20) {
      _spellsKnown = 15;
    }
    return _spellsKnown;
  }
  
  int calcSpellSlots() {
    if (_level == 1) {
      _spellSlots = 1;
    }
    if (_level > 1 && _level <= 10) {
      _spellSlots = 2;
    }
    if (_level > 10 && _level <= 16) {
      _spellSlots = 3;
    }
    if (_level > 16 && _level <= 20) {
      _spellSlots = 4;
    }    
    return _spellSlots;
  }
    
  int calcSpellSlotLevel() {
    if (_level > 0 && _level <= 8) {
      _spellSlotLevel = (_level / 2).ceil(); // TEST THIS.
    }
    else {
      _spellSlotLevel = 5;
    }
    return _spellSlotLevel;
  }
  
  int calcInvocationsKnown() {
    if (_level > 1 && _level <= 4) {
      _invocationsKnown = 2;
    }
    if (_level == 5 || _level == 6) {
      _invocationsKnown = 3;
    }
    if (_level >= 7 || _level <= 20) {
      _invocationsKnown = 4;
    }
    return _invocationsKnown;
  }
  
  String fullStats() {
    StringBuffer sb = new StringBuffer();
    
    sb.writeln("Otherwordly patron: $patron");
    sb.writeln("Pact of the: $pact");
    sb.writeln("Spells known: ${spellsKnown}");
    sb.writeln("Spell slots: ${spellSlots}");
    sb.writeln("Spell slot level: ${spellSlotLevel}");
    sb.writeln("Invocations known: ${invocationsKnown}");
    
    return sb.toString();
  }
  
  String get patron => _patron;
  String get pact => _pact; 
  int get spellsKnown => calcNumSpellsKnown();
  int get spellSlots => calcSpellSlots();
  int get spellSlotLevel => calcSpellSlotLevel();
  int get invocationsKnown => calcInvocationsKnown();
 
  
} // End Warlock class.









// === The Ranger Class! === 
class Ranger extends CharClass {

  Ranger([int level = 1]) : super(level) {
       _name = "Ranger";
       _hitDie = 8;
       _level = level;
       _casterStat = "Wisdom";
       _primaryAbilities = ["Charisma"];
       _numberOfSkills = "Choose two skills from: ";
       _skillProficiency = [
         "Arcana", 
         "Deception", 
         "History", 
         "Intimidation", 
         "Investigation",
         "Nature",
         "Religion"
       ];
       _armorProficiency = ["Light Armor"];
       _weaponProficiency = ["Simple Weapons"];
       _toolProficiency = ["None"];
       _savingThrowProficiency = [
         "Wisdom",
         "Charisma"
       ];
       _description = " ";
           
       calcProficiencyBonus();
//  calcCasterStats(Entity entity.Charisma);    
 
  }

  void levelUpRanger() {
    levelUp();
    calcSmallSpellSlots();
  }
  
}
// === End Ranger Class ===








// === The Bard Class! ===
class Bard extends CharClass {

// What a huge constructor...
Bard([int level = 1]) : super(level) {
 _name = "Bard";
 _hitDie = 8;
 _level = level;
 _casterStat = "Charisma";
 _primaryAbilities = ["Charisma"];
 _numberOfSkills = "Choose any three skills.";
 _skillProficiency = [""];
 _armorProficiency = ["Light Armor"];
 _weaponProficiency = ["Simple Weapons", "Hand Crossbows", "Longswords", "Rapiers", "Shortswords"];
 _toolProficiency = ["Three musical instruments of your choice"];
 _savingThrowProficiency = [
   "Dexterity",
   "Charisma"
 ];
 _description = "An inspiring magician whose power echoes the music of creation.";
     
 calcProficiencyBonus();
 calcCantripsKnown();
 calcNumSpellsKnown();
 calcBigSpellSlots();
}

void BardLevelUp() {
 levelUp();
 calcCantripsKnown();
 calcNumSpellsKnown();
 calcBigSpellSlots();
}

int calcCantripsKnown() {
 if (_level <= 3) {
   _cantripsKnown = 2;
 }
 if (_level >= 4 && _level <= 9) {
   _cantripsKnown = 3;
 }
 if (_level >= 10 && _level  <= TIER_FIVE) {
   _cantripsKnown = 4;
 }
 return _cantripsKnown;
}

// Better way to do this? Ugh.
void calcNumSpellsKnown() {
 if (_level < 10) {
   _spellsKnown = _level + 3;
 }
 if (_level == 10) {
   _spellsKnown = 14;
 }
 if (_level == 11 || _level  == 12) {
   _spellsKnown = 15;
 }
 if (_level == 13) {
   _spellsKnown = 16;
 }
 if (_level == 14) {
   _spellsKnown = 18;
 }
 if (_level == 15 || _level  == 16) {
   _spellsKnown = 19;
 }
 if (_level == 17) {
   _spellsKnown = 20;
 }
 if (_level >= 18 && _level  <= 20) {
   _spellsKnown = 22;
 }
}


 

} // End Bard class.


