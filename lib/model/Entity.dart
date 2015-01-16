library model.entity;


import 'ability.dart';
import 'skill.dart';
import 'character_class.dart';
import 'race.dart';

class Entity {
  // Living attributes
  String _name;
  CharClass _charClass;
  Race _charRace;
  String _type; // eg. Humanoid, Abberation, Construct etc.
  String _alignment;
  String _size;
  int _movement;
  
  // Patron attributes
  String _deity;
  String _patron;
  
  // Game attributes
  int _level;
  int _hitDie;
  int _maxHitPoints;
  int _currentHitPoints;
  final int BASE_AC = 10;
  int _armorClass;
  int _proficiencyBonus;
  String _status;
  
  // Equipment attributes
  int _armor = 0;
  int _shield = 0;
  
  Ability Strength = new Ability("Strength");
  Ability Dexterity = new Ability("Dexterity");
  Ability Constitution = new Ability("Constitution");
  Ability Intelligence = new Ability("Intelligence");
  Ability Wisdom = new Ability("Wisdom");
  Ability Charisma = new Ability("Charisma");
  
  List<Ability> abilities;
  
  // Strength skill.
  Skill Athletics;
  // Dexterity skills.
  Skill Acrobatics;
  Skill SleightOfHand;
  Skill Stealth;
  //Intelligence skills.
  Skill Arcana;
  Skill History;
  Skill Investigation;
  Skill Nature;
  Skill Religion;
  // Wisdom skills.
  Skill AnimalHandling;
  Skill Insight;
  Skill Medicine;
  Skill Perception;
  Skill Survival;
  // Charisma skills.
  Skill Deception;
  Skill Intimidation;
  Skill Performance;
  Skill Persuasion;
  
  // Skill Lists by corresponding Ability
  List<Skill> strSkills = [];
  List<Skill> dexSkills = [];
  List<Skill> intSkills = [];
  List<Skill> wisSkills = [];
  List<Skill> chaSkills = [];
  
  // Master Skill list
  List<List> fullSkillList;
  
  // Does not include Constitution.
  List<int> abilitiesForSkills = [];
  
  bool statsCalculated = false;
  
  // Parameterized constructor.
  // Name, Character's class, Race, ability scores.
  Entity(this._name, Race race, CharClass characterClass, int strength, int dexterity, int constitution, int intelligence, int wisdom, int charisma) {
    _status = "Normal";
    _level = 1;

    _charRace = race;
    _type = race.type;
    _size = race.size;
    _charClass = characterClass;
    _hitDie = characterClass.hitDie;
    _movement = race.speed;
    _proficiencyBonus = characterClass.proficiencyBonus;
    _alignment = "Neutral Good"; // Default. Set after creation.
    
    // Put rolled stats into their respective abilities.
    Strength.setAbility(strength);
    Dexterity.setAbility(dexterity);
    Constitution.setAbility(constitution);
    Intelligence.setAbility(intelligence);
    Wisdom.setAbility(wisdom);
    Charisma.setAbility(charisma);           
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    
    // Now add Racial ability modifiers.
    addRacialAbilities(_charRace, abilities);
    
    // Calc HP.
    _maxHitPoints = (characterClass.hitDie + Constitution.mod);
    _currentHitPoints = _maxHitPoints;    
    
    // 
    Athletics = new Skill("Athletics", Strength);
    Acrobatics = new Skill("Acrobatics", Dexterity);
    SleightOfHand = new Skill("SleightOfHand", Dexterity);
    Stealth = new Skill("Stealth", Dexterity);
    Arcana = new Skill("Arcana", Intelligence);
    History = new Skill("History", Intelligence);
    Investigation = new Skill("Investigation", Intelligence);
    Nature = new Skill("Nature", Intelligence);
    Religion = new Skill("Religion", Intelligence);
    AnimalHandling = new Skill("AnimalHandling", Wisdom);
    Insight = new Skill("Insight", Wisdom);
    Medicine = new Skill("Medicine", Wisdom);
    Perception = new Skill("Perception", Wisdom);
    Survival = new Skill("Survival", Wisdom);
    Deception = new Skill("Deception", Charisma);
    Intimidation = new Skill("Intimidation", Charisma);
    Performance = new Skill("Performance", Charisma);
    Persuasion = new Skill("Persuasion", Charisma);
    
    strSkills = [Athletics];
    dexSkills = [Acrobatics, SleightOfHand, Stealth];
    intSkills = [Arcana, History, Investigation, Nature, Religion];
    wisSkills = [AnimalHandling, Insight, Medicine, Perception, Survival];
    chaSkills = [Deception, Intimidation, Performance, Persuasion];
    
    fullSkillList = [strSkills, dexSkills, intSkills, wisSkills, chaSkills];
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];  
       
    skillsPlusAbilities(_charRace, _charClass);    

    _armorClass = calcArmorClass();
    
  } // End constructor.
  
    
  int calcArmorClass() {
    return (BASE_AC + Dexterity.mod + _armor);   
  }
  
  String showAcSources() {
    String armorBonuses = "Base: $BASE_AC\n Dexterity: ${Dexterity.mod}\n Armor: ";
    /*
     * Armor
     * Dex
     * Dodge
     * 
     * 
     * if (tempBonus == true)
     */
    return armorBonuses;
  }
  
  // Add racial bonuses to Abilities.
  void addRacialAbilities(Race race, List<Ability> abilities) {
    abilities.forEach((Ability ability) {
      for (int i = 0; i < race.racialAbilities.length; i++) {
        if (ability.name == race.racialAbilities[i]) {
          ability.increaseAbility(race.racialAbilities[i]);
        } // End if        
      } // End for     
    }); // End .forEach
  } // End addRacialAbilities()
  
  String getDeityPatron() {
    if (_deity == null && _patron == null) {
      return "None";
    }
    else if (_deity == null) {
      return _patron;
    }
    else {
      return _deity;
    }
  }
  
  @override String toString() {
    return 
        "Name: $_name   Race: ${_charRace.name}   Class: ${_charClass.name}  Level: $_level"
        "\nAlignment: $_alignment   Size: $_size   Hit Die: d${_hitDie}"
        "\nHP: $_maxHitPoints   Armor Class: $_armorClass   Speed: $_movement"
        "\nProficiency Bonus: $_proficiencyBonus   Status: $_status"
        "\nDeity/Patron: $getDeityPatron()";
  }
  
  void chooseSkillProficiency(Skill skill) {
    skill.isClassSkill(_charClass.proficiencyBonus);
  }
  
//  void refactor() {
//  }
  
  // First loops through and adds all ability modifiers to skills.
  void skillsPlusAbilities(Race race, CharClass charClass) {
    for (int idx = 0; idx < abilitiesForSkills.length; idx++) {
      fullSkillList[idx].forEach((Skill skill) {
          skill.setValue(abilitiesForSkills[idx]);
      }); // End fullSkillList.forEach
    } // End for idx loop
  } // End skillsPlusAbilities()
  
 
//  void increaseStat(String stat, int bonus) {
//    stat = stat.toLowerCase();
//        int thisSkill; 
//        bool foundSkill;
//        int skillIdx = 0;
//        do {
//          if (skillIdx >= skillList.length) {
//            break;
//          }
//          foundSkill = (skillList[skillIdx].containsKey(stat));
//          thisSkill = skillList[skillIdx][stat];
//          skillIdx++;
//        } while (foundSkill == false);
//      
//        if (foundSkill == false) {
//          print("Skill not found!");
//        }
//        else {
//          skillIdx--;
//          skillList[skillIdx][stat] += bonus;
//        }
//  }
  
  void takeDamage(int dmg) {
    _currentHitPoints -= dmg;
  }
  
  void heal(int healing) {
    if (_currentHitPoints == _maxHitPoints) {
      // Nothing
    }
    else {
      _currentHitPoints += healing;
      if (_currentHitPoints > _maxHitPoints) {
        _currentHitPoints = _maxHitPoints;
      } 
    }       
  }
  
  void changeStatus(String newStatus) {
    _status = newStatus;
  // Throw in some if (_status == _____) 
    // statements to add mechanics and maybe flavor text.    
  }
  
  // Getters
  int get strength => Strength.score;
  int get dexterity => Dexterity.score;
  int get constitution => Constitution.score;
  int get intelligence => Intelligence.score;
  int get wisdom => Wisdom.score;
  int get charisma => Charisma.score;
  int get currentHP => _currentHitPoints;
  int get level => _level;
  String get HitDie => "d${_charClass.hitDie}";
  int get maxHP => _maxHitPoints;
  int get AC => _armorClass;
  int get proficiencyBonus => _proficiencyBonus;
  int get movement => _charRace.speed;
  String get name => _name;
  String get size => _charRace.size;
  String get raceName => _charRace.name;
  String get className => _charClass.name;
  String get creatureType => _type == null ? "humanoid" : _type; // eg. Humanoid, Abberation, Construct etc.
  String get allignment => _alignment;
  String get status => _status;
  String get deity => getDeityPatron(); // _deity == null ? _patron : _deity;
  String get patron => getDeityPatron(); // _patron == null ? _deity : _patron;
  
//  // "Generic" getter that returns any single skill and value.
//  int getSkill(String skillName) {
//    skillName = skillName.toLowerCase();
//    int thisSkill; 
//    bool foundSkill;
//    int skillIdx = 0;
//    do {
//      if (skillIdx >= skillList.length) {
//        break;
//      }
//      foundSkill = (skillList[skillIdx].containsKey(skillName));
//      thisSkill = skillList[skillIdx][skillName];
//      skillIdx++;
//    } while (foundSkill == false);
//  
//    if (foundSkill == false) {
//      print("Skill not found!");
//      return 0;
//    }
//    else {
//      print("$skillName: $thisSkill");        
//      return thisSkill;
//    }      
//  }
  
  // Setters
//  void set strength(int str) { _strength = str;}
//  void set dexterity(int dex) {_dexterity = dex;}
//  void set constitution(int con) { _constitution = con;}
//  void set intelligence(int intl) { _intelligence = intl;}
//  void set wisdom(int wis) { _wisdom = wis;}
//  void set charisma(int cha) { _charisma = cha;}
  void set currentHP(int hp) { _currentHitPoints = hp;}
//  void set size(String size) { _size = size;}
  void set level(int lvl) { _level = lvl;}
//  void set HD(int hd) { _hitDie = hd;}
//  void set maxHP(int hpMax) {_maxHitPoints = hpMax;}
  //void set AC(int ac) { _armorClass = ac;} // Calculated automatically.
  //void set proficiencyBonus(int prof) { _proficiency = prof;}
  //void set movement => _movement
  void set name(String name) { _name = name;}
//  void set race(String race) { _race = race;}
//  void set type(String type) { _type = type;} // eg. Humanoid, Abberation, Construct etc.
  void set allignment(String allignment) { _alignment = allignment;}
  void set status(String status) { _status = status;}
  void set deity(String deity) {_deity = deity;}
  void set patron(String patron) {_patron = patron;}
  
} // End class Entity  







