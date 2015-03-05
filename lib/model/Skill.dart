library model.skill;

import 'ability.dart';

class Skill /*implements Comparable*/ {
  String _name;
  int _originalValue; // Used only for converting from a class skill to a non-class skill. (If user is a dumb-dumb and switches back and forth between IS and is NOT a class skill)
  int _value;
  String _abilityName;  
  int _abilityMod;
  bool classSkill;  
  
//  Ability _ability;
  
  Skill.fromBlank(String skillName) {
    _name = skillName;
    _originalValue = 0;
    _value = 0;
    _abilityName = "";
    classSkill = false;
  }
  
  Skill(this._name, Ability ability, {bool classSkill: false}) {
    _abilityName = ability.name;
    _abilityMod = ability.mod;
    setValue(_abilityMod);
  }
  
  void setValue(int value) {
    _originalValue = _value;
    _value = value;
  }
  
  void increaseValue(int value) {
    _originalValue = _value;
    _value += value;
  }

  // I don't know why/when this would get used, but we'll see.
  void decreaseValue(int value) {
    _originalValue = _value;
    _value -= value;
  }
  
  void isClassSkill(int proficiencyBonus) {
    increaseValue(proficiencyBonus);
  }
  
  void notClassSkill() {
    _value = _originalValue;  
  }


  String get name => _name;
  int get score => _value;
  bool get isAClassSkill => classSkill;  
  String get ability => _abilityName;

  void setName(String name) {
    _name = name;
  }

  void setScore(int score) {
    _value = score;
  }
  
  void setIsClassSkill(bool isClassSkill) {
    classSkill = isClassSkill;
  }

  void setAbility(Ability ability) {
    _abilityMod = ability.mod;
    setValue(_abilityMod);
  }
}