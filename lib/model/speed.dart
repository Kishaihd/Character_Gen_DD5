library model.speed;

class Speed {

  String _encumberance = "un";
  bool isUnencumbered = true;
  bool isLightlyEncumbered = false;
  bool isHeavilyEncumbered = false;

  void setUnencumbered() {
    isUnencumbered = true;
    isLightlyEncumbered = false;
    isHeavilyEncumbered = false;

    _encumberance = "un";
  }

  void setLightEncumberance() {
    isLightlyEncumbered = true;
    isUnencumbered = false;
    isHeavilyEncumbered = false;

    _encumberance = "lightly ";
  }

  void setHeavyEncumberance() {
    isHeavilyEncumbered = true;
    isLightlyEncumbered = false;
    isUnencumbered = false;

    _encumberance = "heavily ";
  }


  Map<String, int> _landSpeeds = {
    //"base" : 0 // To be filled in by race choice.
  };
  
  Map<String, int> _flySpeeds = {
      //"base" : 0
    };
  
  Map<String, int> _swimSpeeds = {
      //"base" : 0
    };
  
  // Default Constructor.
  Speed();
  
  
  void addLandMod(String modName, int modValue) {
    _landSpeeds.putIfAbsent(modName, () => modValue);
  }
  void removeLandMod(String modName) {
    _landSpeeds.remove(modName);
  }
  
  void addFlyMod(String modName, int modValue) {
    _flySpeeds.putIfAbsent(modName, () => modValue);
  }
  void removeFlyMod(String modName) {
    _flySpeeds.remove(modName);
  }
  
  void addSwimMod(String modName, int modValue) {
    _swimSpeeds.putIfAbsent(modName, () => modValue);
  }
  void removeSwimMod(String modName) {
    _swimSpeeds.remove(modName);
  }
  
//  // This could be a "level" system instead, 0 for none, 1 for lightly, etc.
//  void set encumberance(String type) {
//    _encumberance = type;
//  }
  
  int calculateLandSpeed() {
    int speed = 0;
    
    _landSpeeds.forEach((String name, int mod) {
      speed += mod;
    });
    
    return speed;
  }
  
  int calculateSwimSpeed() {
    if (_swimSpeeds.isNotEmpty) {
      int speed = 0;
      
      _swimSpeeds.forEach((String name, int mod) {
        speed += mod;
      });
      
      return speed;
    }
    
    else return calculateLandSpeed(); // Is this correct?
  }
  
  int calculateFlySpeed() {
    int speed = 0;
    if (_flySpeeds.isNotEmpty) {          
      _flySpeeds.forEach((String name, int mod) {
        speed += mod;
      });
    }
    return speed;
  }

  int totalSpeed( int speedType ) {
    int totalSpeed = anySpeed();

    String e = _encumberance;
    switch(e) {
      case 'lightly':
        totalSpeed -= 5;
        break;
      case 'heavily':
        totalSpeed = (totalSpeed/2).floor(); // If 30, = 15. If 35, = 17.
        break;
      default:

    }

    return totalSpeed;
  }

  int get landSpeed => totalSpeed(calculateLandSpeed());
  int get swimSpeed => totalSpeed(calculateSwimSpeed());
  int get flySpeed => totalSpeed(calculateFlySpeed());
  String get encumberance => "You are ${_encumberance}encumbered. ";
}

