library model.speed;

class Speed {

  String _encumberance;
  Map<String, int> _encumberanceMap = {
    "none" : 0,
    "light" : 5,
    "heavy" : 15,
    "overEncumbered" : 100
  };
  
  Map<String, int> _landSpeeds = {
    "base" : 0
  };
  
  Map<String, int> _flySpeeds = {
      "base" : 0
    };
  
  Map<String, int> _swimSpeeds = {
      "base" : 0
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
  
  // This could be a "level" system instead, 0 for none, 1 for lightly, etc.
  void set encumberance(String type) {
    _encumberance = type;
  }
  
  int calculateLandSpeed() {
    int totalSpeed = 0;
    
    _landSpeeds.forEach((String name, int mod) {
      totalSpeed += mod;
    });
    totalSpeed -= _encumberanceMap[_encumberance];
    
    return totalSpeed;
  }
  
  int calculateSwimSpeed() {
    if (_swimSpeeds.isNotEmpty) {
      int totalSpeed = 0;
      
      _swimSpeeds.forEach((String name, int mod) {
        totalSpeed += mod;
      });
      totalSpeed -= _encumberanceMap[_encumberance];
      
      return totalSpeed;
    }
    
    else return calculateLandSpeed(); // Is this correct?
  }
  
  int calculateFlySpeed() {
    int totalSpeed = 0;
    if (_flySpeeds.isNotEmpty) {          
      _flySpeeds.forEach((String name, int mod) {
        totalSpeed += mod;
        totalSpeed -= _encumberanceMap[_encumberance];
      });
    }
    return totalSpeed;
  }
  
  int get landSpeed => calculateLandSpeed();
  int get swimSpeed => calculateSwimSpeed();
  int get flySpeed => calculateFlySpeed();
  
}

