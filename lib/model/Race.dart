library model.race; // Why doesn't think work?

import 'trait.dart';

class Race {
  String _name;
  String _type;
  Map<String, int> _racialAbilities;
  String _size;
  int _landSpeed;
  int _swimSpeed = 0;
  int _flySpeed = 0;
  List<String> _languages;
  bool _canChooseLanguage = false;
  String _subrace;
  Map<String, int> _vision;
  List<Trait> _traits;
  List<String> _skillProficiencies;
  List<String> _weaponProficiencies;
  List<String> _armorProficiencies;
  List<String> _toolProficiencies;
  
  Race([String subrace]) {
    if (subrace != null) {
      _subrace = subrace;      
    }
  }

  bool canFly() {
    return _flySpeed > 0 ? true : false;
  }

  Trait ExtraLanguage = new Trait.fromParam("Extra Language", "You can speak, read, and write one extra language o f your choice.");

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
  int get racialLandSpeed => _landSpeed;
  int get racialSwimSpeed => _swimSpeed;
  int get racialFlySpeed => _flySpeed;
  List<String> get languages => (_languages.isEmpty ? "None" :  _languages);
  bool get canChooseLanguage => _canChooseLanguage;
  String get subrace => (_subrace == null ? "None" : _subrace);
  List<Trait> get traits => (_traits.isEmpty ? "None" :  _traits);
  
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
    _landSpeed = 30;
    _languages = ["Common", "Infernal"];
    _vision = {"Darkvision" : 60};

    Trait HellishResistance = new Trait.fromParam("Hellish Resistance", "");
    Trait InfernalLegacy = new Trait.fromParam("Infernal Legacy", "");
    _traits = [HellishResistance, InfernalLegacy];
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
    _landSpeed = 30;
    _canChooseLanguage = true;
    _languages = ["Common"];
    _vision = {"Common" : 0};

    _traits = [ExtraLanguage];
  }
  
  void bonusLanguage(String language) {
    _languages.add(language);
  }  
}

class Elf extends Race {
  
  Elf([String subrace = null]) : super(subrace) {
    _racialAbilities = {"Dexterity": 2};
    _type = "Humanoid"; // Right?
    _size = "Medium";
    _landSpeed = 30;
  
    if (subrace == null) {
      setSubrace("high elf");
    }
  }
  
  void setSubrace(String raceName) {
    _languages = ["Common", "Elvish"];
    Trait KeenSenses = new Trait.fromParam("Keen Senses", "You have proficiency in the Perception skill.");
    Trait FeyAncestry = new Trait.fromParam("Fey Ancestry", "You have advantage on saving throws against being charmed, and magic can’t put you to sleep.");
    Trait Trance = new Trait.fromParam("Trance", """Elves don’t need to sleep. Instead, they meditate deeply, remaining semiconscious, for 4 hours a day. (The Common word for such meditation is “trance.”) While meditating, you can dream after a fashion; such dreams are actually mental exercises that have become reflexive through years o f practice. After resting in this way, you gain the same benefit that a human does from 8 hours of sleep.""");
    _traits = [KeenSenses, FeyAncestry, Trance];
    _vision = {"Darkvision" : 60};

    // Drow is only exception.
    Trait ElfWpnTraining = new Trait.fromParam("Elf Weapon Training", "You have proficiency with the longsword, shortsword, shortbow, and longbow.");

    String e = subrace.toLowerCase();
    switch(e) {
      case 'high elf' :
        _name = "High Elf";
        _racialAbilities.putIfAbsent("Intelligence", () => 1);
        Trait Cantrip = new Trait.fromParam("Cantrip", "You know one cantrip o f your choice from the wizard spell list. Intelligence is your spellcasting ability for it.");
        _traits.add(ElfWpnTraining);
        _traits.add(Cantrip);
        _traits.add(ExtraLanguage);
        break;
      case 'wood elf' :
        _name = "Wood Elf";
        _racialAbilities.putIfAbsent("Wisdom", () => 1);
        Trait FleetOfFoot = new Trait.fromParam("Fleet of Foot", "Your base walking speed increases to 35 feet.");
        Trait MaskOfTheWild = new Trait.fromParam("Mask Of The Wild", "You can attempt to hide even when you are only lightly obscured by foliage, heavy rain, falling snow, mist, and other natural phenomena.");
        _traits.add(ElfWpnTraining);
        _traits.add(FleetOfFoot);
        _landSpeed += 5;
        _traits.add(MaskOfTheWild);
        break;
      case 'dark elf' :
        _name = "Dark Elf";
        _racialAbilities.putIfAbsent("Charisma", () => 1);
        _vision = {"Superior Darkvision" : 120};
        Trait DrowWpnTraining = new Trait.fromParam("Drow Weapon Training", "You have proficiency with rapiers, shortswords, and hand crossbows.");
        Trait SunlightSensitivity = new Trait.fromParam("Sunlight Sensitivity", "You have disadvantage on attack rolls and on Wisdom (Perception) checks that rely on sight when you, the target o f your attack, or whatever you are trying to perceive is in direct sunlight.");
        Trait DrowMagic = new Trait.fromParam("Drow Magic", "You know the dancing lights cantrip. When you reach 3rd level, you can cast the faerie fire spell once per day. When you reach 5th level, you can also cast the darkness spell once per day. Charisma is your spellcasting ability for these spells.");
        _traits.add(DrowWpnTraining);
        _traits.add(SunlightSensitivity);
        _traits.add(DrowMagic);
        break;
      default:
        break;
    }
  } // End setSubrace().
  
}



