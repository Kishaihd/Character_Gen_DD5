library model.race;

class Race {
  String _name;
  String _type;
  Map<String, int> _racialAbilities;
  String _size;
  int _speed;
  List<String> _languages;
  bool _canChooseLanguage;
  String _subrace;
  String _vision;
  List<String> _traits;
  List<String> _skillProficiencies;
  List<String> _weaponProficiencies;
  List<String> _armorProficiencies;
  List<String> _toolProficiencies;
  
  Race([String subrace]) {
    if (subrace != null) {
      _subrace = subrace;      
    }
  }
  
  List<String> get skillProficiencies => (skillProficiencies.isEmpty ? "None" : _skillProficiencies);
  List<String> get weaponProficiencies => (skillProficiencies.isEmpty ? "None" : _weaponProficiencies);
  List<String> get armorProficiencies => (skillProficiencies.isEmpty ? "None" : _armorProficiencies);
  List<String> get toolProficiencies => (toolProficiencies.isEmpty ? "None" : _toolProficiencies);
  
  String get name => _name;
  String get type => _type;
  Map<String, int> get racialAbilities => _racialAbilities;
  
  // Is this getter even necessary?
  int getRacialAbility(String idx) {
    return _racialAbilities[idx];
  }
  String get size => _size;  
  int get speed => _speed;
  List<String> get languages => (_languages.isEmpty ? "None" :  _languages);
  bool get canChooseLanguage => _canChooseLanguage;
  String get subrace => (_subrace == null ? "None" : _subrace);
  List<String> get traits => (_traits.isEmpty ? "None" :  _traits);
  
}

class Tiefling extends Race {
  
  Tiefling() {
    _name = "Tiefling";
    _racialAbilities = {
      "Intelligence": 1,
      "Charisma": 2
    };
    _type = "Outsider";
    _size = "Medium";
    _speed = 30;
    _languages = ["Common", "Infernal"];
    _vision = "Darkvision (60')";
    _traits = ["Hellish Resistance", "Infernal Legacy"];
  }  
}

class Human extends Race {
  
  Human() {
    _name = "Human";
    _racialAbilities = {
      "Strength": 1,
      "Dexterity": 1,
      "Constitution": 1,
      "Intelligence": 1,
      "Wisdom": 1,
      "Charisma": 1
    };
    _type = "Human"; // ?
    _size = "Medium";
    _speed = 30;
    _languages = ["Common"];
    _vision = "Normal";
    _traits = ["Bonus language"];
  }
  
  void bonusLanguage(String language) {
    _languages.add(language);
  }  
}

class Elf extends Race {
  
  Elf(String subrace) : super(subrace) {
    _racialAbilities = {
      "Dexterity": 2        
    };
    
    if (subrace == null) {
      subrace == "high elf";
    }
    _type = "Humanoid"; // Right?
    _size = "Medium";
    _speed = 30;
    _languages = ["Common", "Elvish"];
    _traits = ["Keen Senses", "Fey Ancestry", "Trance"];
    
    if (subrace.toLowerCase() == "high elf") {
      _name = "High Elf";
      _racialAbilities.putIfAbsent("Intelligence", () => 1);
      _traits.add("Elf Weapon Training");
      _traits.add("Cantrip");
      _traits.add("Extra Language");
      _vision = "Darkvision (60')";
    }
    if (subrace.toLowerCase() == "wood elf") {
      _name = "Wood Elf";
      _racialAbilities.putIfAbsent("Wisdom", () => 1);
      _traits.add("Elf Weapon Training");
      _traits.add("Fleet of Foot");
      _speed += 5;
      _traits.add("Mask of the Wild");
      _vision = "Darkvision (60')";
    }
    if (subrace.toLowerCase() == "dark elf") {
      _name = "Dark Elf";
      _racialAbilities.putIfAbsent("Charisma", () => 1);
      _vision = "Superior Darkvision (120')";
      _traits.add("Sunlight Sensitivity");
      _traits.add("Drow Magic");
      _traits.add("Drow Weapon Training");
    }  
  } // End Elf() constructor.
  
}



