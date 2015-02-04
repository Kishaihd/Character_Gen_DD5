library model.character_class;
import 'ability.dart';

class CharClass {
  final int TIER_ONE = 4;
  final int TIER_TWO = 8;
  final int TIER_THREE = 12;
  final int TIER_FOUR = 16;
  final int TIER_FIVE = 20;
  final int BASE_SPELL_MOD = 8;
  
  String _name;
  int _hitDie;
  int _level;
  int _proficiencyBonus;
  List<String> _primaryAbility;
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
  

  CharClass([int level = 1]) {
    _level = level;
    
    _spellSaveDC = 0;
    _spellAttackMod = 0;
    _cantripsKnown = 0;
    _spellsKnown = 0;
    _spellSlots = 0;
  
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
    const int QUARTER = 4;
    const num ROUND = 0.25;
    
    int tier = ((_level / QUARTER) + ROUND).round(); // 1 to 5

    _proficiencyBonus = tier + 1;
  }
  
  void calcCasterStats(Ability ability) {
    _spellAttackMod = (_proficiencyBonus + ability.mod);
    _spellSaveDC = (BASE_SPELL_MOD + _spellAttackMod);
  }  
  
  void learnsSpells(bool answer) {
    _knowsSpells = answer;
  }
  
  // Getters.
  String get name => _name;
  int get hitDie => _hitDie;
  int get level => _level;
  int get proficiencyBonus => _proficiencyBonus;
  String get numSkills => _numberOfSkills;
  String get description => _description;
  bool get knowsSpells => _knowsSpells;
  List<String> get skills => _skillProficiency;
  List<String> get armors => _armorProficiency;
  List<String> get weapons => _weaponProficiency;
  List<String> get tools => _toolProficiency;
  List<String> get savingThrows => _savingThrowProficiency;
  int get spellSaveDC => _spellSaveDC;
  int get spellAttackMod => _spellAttackMod;
  String get casterStat => _casterStat;
  int get cantripsKnown => _cantripsKnown;
  int get spellsKnown => _spellsKnown;
  int get spellSlots => _spellSlots;
  int get baseSpellMod => BASE_SPELL_MOD;
  
  // Setters.
  void setLevel(int level) {_level = level;}
  //void setProficiencyBonus(int proficiency) {_proficiencyBonus = proficiency;}
    
} // End CharClass parent class.



/*=======================================================================================*/



// === The Warlock Class! ===
class Warlock extends CharClass {
  String _patron;
  int _spellSlotLevel;
  int _invocationsKnown = 0;
  
  // What a huge constructor...
  Warlock([int level = 1]) : super(level) {
    _name = "Warlock";
    _hitDie = 8;
    _level = level;
    _casterStat = "Charisma";
    _primaryAbility = ["Charisma"];    
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
        
    calcProficiencyBonus();
//  calcCasterStats(Entity entity.Charisma);    

  }
  
  void warlockLevelUp() {
    levelUp();
    calcCantripsKnown();
    calcSpellsKnown();
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
  int calcSpellsKnown() {
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
    if (_level == 7 || _level == 8) {
      _invocationsKnown = 4;
    }    
    if (_level > 8 && _level <= 11) {
      _invocationsKnown = 4;
    }    
    if (_level > 11 && _level <= 14) {
      _invocationsKnown = 4;
    }
    if (_level > 14 && _level <= 17) {
      _invocationsKnown = 4;
    }
    if (_level > 17 && _level <= 20) {
      _invocationsKnown = 4;
    }
    return _invocationsKnown;
  }
  
  String get patron => _patron;
  int get spellSlotLevel => _spellSlotLevel;
  int get invocationsKnown => _invocationsKnown;
  
  
  
  
  
  
  
} // End Warlock class.