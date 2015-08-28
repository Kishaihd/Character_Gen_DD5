library model.alignment;



class Alignment {
  static const int LAWFUL_LIMIT = 20;
  static const int GOOD_LIMIT = 20;
  static const int CHAOTIC_LIMIT = -20;
  static const int EVIL_LIMIT = -20;

  String _alignment;

  //  Both have 3  'ranges' , (-100, -21), (-20, 20), (21, 100)
  int _lawfulness; // Lawful, neutral, chaotic
  int _morality; // Good, enutral, evil

  Alignment();

  Alignment.fromValue(int lawfulness, int morality) {
    _lawfulness = lawfulness;
    _morality = morality;
    calcAlignment();
  }

  Alignment.fromString(String al) {
    setByString(al);
  }

  String calcAlignment() {
    if (_lawfulness < -20) { // Chaotic
      if (_morality < -20) { // Evil
        return "Chaotic Evil";
      }
      else if (_morality > 20) { // Good
        return "Chaotic Good";
      }
      else { // Neutral
        return "Chaotic Neutral";
      }
    } // End Chaotic

    else if (_lawfulness > 20) { // Lawful
      if (_morality < -24) { // Evil
        return "Lawful Evil";
      }
      else if (_morality > 24) { // Good
        return "Lawful Good";
      }
      else { // Neutral
        return "Lawful Neutral";
      }
    }

    else { // Neutral
      if (_morality < -24) { // Evil
        return "Neutral Evil";
      }
      else if (_morality > 24) { // Good
        return "Neutral Good";
      }
      else { // Neutral
        return "Neutral Neutral";
      }
    }
  }

  void setByString(String al) {
    switch(al.toLowerCase()) {
      case 'lawful good' :
        _lawfulness = 60;
        _morality = 60;
        calcAlignment();
        break;
      case 'lawful neutral' :
        _lawfulness = 60;
        _morality = 0;
        calcAlignment();
        break;
      case 'lawful evil' :
        _lawfulness = 60;
        _morality = -60;
        calcAlignment();
        break;
      case 'neutral good' :
        _lawfulness = 0;
        _morality = 63;
        calcAlignment();
        break;
      case 'neutral neutral' :
        _lawfulness = 0;
        _morality = 0;
        calcAlignment();
        break;
      case 'neutral' :
        _lawfulness = 0;
        _morality = 0;
        calcAlignment();
        break;
      case 'neutral evil' :
        _lawfulness = 0;
        _morality = -63;
        calcAlignment();
        break;
      case 'chaotic good' :
        _lawfulness = -63;
        _morality = 63;
        calcAlignment();
        break;
      case 'chaotic neutral' :
        _lawfulness = -63;
        _morality = 0;
        calcAlignment();
        break;
      case 'chaotic evil' :
        _lawfulness = -63;
        _morality = -63;
        calcAlignment();
        break;
    }
  }

  void _modLawfulness(int value) {
    _lawfulness += value;
    calcAlignment();
  }

  void _modMorality(int value) {
    _morality += value;
    calcAlignment();
  }

  String get score => _alignment;


}