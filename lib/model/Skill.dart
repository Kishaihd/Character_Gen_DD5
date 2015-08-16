library model.skill;

import 'ability.dart';

class Skill /*implements Comparable*/ {
  String _name;
//  int _originalValue; // Used only for converting from a class skill to a non-class skill. (If user is a dumb-dumb and switches back and forth between IS and is NOT a class skill)
  int _value;
  String _abilityName;  
  int _abilityMod;
  bool _isAClassSkill;

  Map<String, int> _modList = {};

//  Ability _ability;
  
  Skill.fromBlank(String skillName) {
    _name = skillName;
//    _originalValue = 0;
    _value = 0;
    _abilityName = "";
    _isAClassSkill = false;
  }
  
  Skill(this._name, Ability ability) {
    _abilityName = ability.name;
    _abilityMod = ability.mod;
//    setValue(_abilityMod);
  }
  
//  void setValue(int value) {
//    _originalValue = _value;
//    _value = value;
//  }
  
//  void increaseValue(int value) {
//    _originalValue = _value;
//    _value += value;
//  }

  // I don't know why/when this would get used, but we'll see.
//  void decreaseValue(int value) {
//    _originalValue = _value;
//    _value -= value;
//  }

  void addMod(String name, int value) {
    _modList.putIfAbsent(name, () => value);
  }

  void removeMod(String name) {
    _modList.remove(name);
  }

  void isClassSkill(int proficiencyBonus) {
    //increaseValue(proficiencyBonus);
    _modList.putIfAbsent("Class Skill", () => proficiencyBonus);
    _isAClassSkill = true;
  }
  
  void notClassSkill() {
    //_value = _originalValue;
    if (_modList.containsKey("Class Skill")) {
      _modList.remove("Class Skill");
    }
    _isAClassSkill = false;
  }

  int calcValue() {
    int totalValue = 0;
    _modList.forEach( (String s, int value) {
      totalValue += value;
    });
    totalValue += _abilityMod;
    _value = totalValue;
    return _value;
  }

  String get name => _name;
  int get score => calcValue();
  bool get isAClassSkill => _isAClassSkill;
  String get ability => _abilityName;

//  void setName(String name) {
//    _name = name;
//  }

//  void setScore(int score) {
//    _value = score;
//  }
  
//  void setIsClassSkill(bool isClassSkill) {
//    classSkill = isClassSkill;
//  }

//  void setAbility(Ability ability) {
//    _abilityMod = ability.mod;
//    setValue(_abilityMod);
//  }
}