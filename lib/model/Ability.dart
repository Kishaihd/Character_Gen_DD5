library model.Ability;

class Ability {
  final int LIMIT = 20; // Limit for PCs for now.
  final String _name;
  int _score;
  int _mod;
  
  Ability(this._name, [this._score = 0]) {
    calcMod();
  }

  String get name => _name;
  int get score => _score;
  int get mod => _mod;
  int get limit => LIMIT;

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
  
}