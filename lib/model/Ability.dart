library model.ability;

import 'dice.dart';

class Ability {
  static const int LIMIT = 20; // Limit for PCs for now.
  static const int ABILITY_DICE = 3;
  final String _name;
  int _score;
  int _mod;
  
  int _tempScore;
  int _tempMod;
  
  Ability(this._name, [this._score = 0]) {
    _tempScore = _score;
    calcMod();
    _tempMod = _mod;
  }
  
  String get name => _name;
  int get score => _score;
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
  
  // Cap set to 20, can change later.
  void setAbility(int value) {
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