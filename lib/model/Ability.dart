
library model.ability;

import 'dice.dart';

class Ability {
  static const int LIMIT = 20; // Limit for PCs for now.
  static const int ABILITY_DICE = 3;
  String _name;
  int _score;
  int _mod;
  // int _totalScore;
  // int _fromRaceScore;
  // int _fromClassScore;
  // int _fromLevelUpScore;
  
  int _tempScore;
  int _tempMod;

  Map<String, int> _modList;

  Ability([this._name, this._score = 0]) {
    _tempScore = _score;
    calcMod();
    _tempMod = _mod;
  }
  
  void setName(String name) {
    if (_name == null || _name == "") {
      _name = name;      
    }
  }
  
  String get name => _name;
  int get score => _score == null ? 0 : calcAbilityScore();
  int get mod => _mod;
  int get limit => LIMIT;

  int get tempScore => _tempScore;
  int get tempMod => _tempMod;
  
  int roll() {
    int theRoll = 0;
    
    for (int i = 0; i < ABILITY_DICE; i++) {
      theRoll += Die.rollDie(6);
    }    
    return theRoll;  
  }
  
  @override String toString() => "${_name}: ${_score} (${modAsString()})";
  String modAsString() => "${(_mod >= 0) ? '+' : ''}${_mod.toString()}"; 
  
  void calcMod() {
    _mod = (_score/2 - 5).floor();
  }

  int calcAbilityScore() {
    int total = 0;
    if (_modList.isNotEmpty) {
      _modList.forEach((String k, int v) {
        total += v;
      });
    }
    total += _score;
    _score = total;
    return _score;
  }

  // Cap set to 20, can change later.
  void setAbilityScore(int value) {
    if (value > LIMIT) {
      // Oh fuck off.
      _score = LIMIT;
    }
    else if (value < 0) {
      // Wtf are you doing.
      _score = 0;      
    }
    else {
      _score = value;
    }   
    calcMod();
  }
  
  void increaseAbility(int value) {
    _score += value;
    calcMod();
  }
  void decreaseAbility(int value) {
    _score -= value;
    calcMod();
  }
  
  // Temp Score/ Modifier -----------------------
  
  void setTempAbility(int value) {
    _tempScore = value;
  }
  
  void calcTempMod() {
      _tempMod = (_tempScore/2 - 5).floor();
  }
  
  void increaseTempAbility(int value) {
      _tempScore += value;
      calcTempMod();
  }
  
  void decreaseTempAbility(int value) {
    _tempScore -= value;
    calcTempMod();
  }
  
  void resetTemp() {
    _tempScore = _score;
    calcTempMod();
  }
  
  
  
  
}