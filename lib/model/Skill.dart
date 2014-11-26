library model.Skill;

import 'Ability.dart';

class Skill {
  final String _name;
  int _originalValue; // Used only for converting from a class skill to a non-class skill. (If user is a dumb-dumb and switches back and forth between IS and is NOT a class skill)
  int _value;
  String _ability;  
  bool classSkill;
  
  Skill(this._name, Ability ability, {bool classSkill: false}) {
    setValue(ability.mod);
    _ability = ability.name;
  }
  
  void setValue(int value) {
    _value = value;
    _originalValue = _value;
  }
  
  void increaseValue(int value) {
    _value += value;
    _originalValue = _value;
  }

  // I don't know why/when this would get used, but we'll see.
  void decreaseValue(int value) {
    _value -= value;
  }
  
  void isClassSkill(int proficiencyBonus) {
    increaseValue(proficiencyBonus);
  }
  
  void notClasSkill() {
    _value = _originalValue;  
  }
  
  String get name => _name;
  int get score => _value;
  bool get isAClassSkill => classSkill;  
  String get ability => _ability;
}