library model.entity;


import 'ability.dart';
import 'character_class.dart';
import 'equipment.dart';
import 'features.dart';
import 'modify.dart';
import 'race.dart';
import 'skill.dart';
import 'speed.dart';

class Entity {
  // Living attributes
  String _name;
  CharClass _charClass;
  Race _charRace;
  FeatureList _classFeatures;
  String _type; // eg. Humanoid, Abberation, Construct etc.
  String _alignment;
  String _size;
//  int _movement;
  Speed _movement;
  
  // Patron attributes
  String _deity;
  String _patron;
  
  // Game attributes
  final int BASE_AC = 10;
  int _level;
  int _hitDie;
  int _maxHitPoints;
  int _currentHitPoints;
  int _armorClass;  
  int _proficiencyBonus;
  String _status;
  
  // Equipment attributes
  Armor _armor;
  Weapon _weapon;
  List<Item> itemList = [];
  List<Weapon> weaponList = [];
  Map<String, Armor> armorList = {}; // Location, Armor
  
  
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
  
  bool _charCreationIsCreated = false;
  
  Entity() {
    _status = "Normal";
    _level = 1;

    _alignment = ""; // Default. Set after creation.
    
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    
    Athletics = new Skill.fromBlank("Athletics");
    Acrobatics = new Skill.fromBlank("Acrobatics");
    SleightOfHand = new Skill.fromBlank("SleightOfHand");
    Stealth = new Skill.fromBlank("Stealth");
    Arcana = new Skill.fromBlank("Arcana");
    History = new Skill.fromBlank("History");
    Investigation = new Skill.fromBlank("Investigation");
    Nature = new Skill.fromBlank("Nature");
    Religion = new Skill.fromBlank("Religion");
    AnimalHandling = new Skill.fromBlank("AnimalHandling");
    Insight = new Skill.fromBlank("Insight");
    Medicine = new Skill.fromBlank("Medicine");
    Perception = new Skill.fromBlank("Perception");
    Survival = new Skill.fromBlank("Survival");
    Deception = new Skill.fromBlank("Deception");
    Intimidation = new Skill.fromBlank("Intimidation");
    Performance = new Skill.fromBlank("Performance");
    Persuasion = new Skill.fromBlank("Persuasion");
    
    strSkills = [Athletics];
    dexSkills = [Acrobatics, SleightOfHand, Stealth];
    intSkills = [Arcana, History, Investigation, Nature, Religion];
    wisSkills = [AnimalHandling, Insight, Medicine, Perception, Survival];
    chaSkills = [Deception, Intimidation, Performance, Persuasion];
    
    fullSkillList = [strSkills, dexSkills, intSkills, wisSkills, chaSkills];

    _armorClass = 10;
        
  }
  
  
  // Parameterized constructor.
  // Name, Character's class, Race, ability scores.
  Entity.parameterized(this._name, Race race, CharClass characterClass, int strength, int dexterity, int constitution, int intelligence, int wisdom, int charisma) {
    _status = "Normal";
    _level = 1;

    _charRace = race;
    _type = race.type;
    _size = race.size;
    _charClass = characterClass;
    _hitDie = characterClass.hitDie;
    _movement.addLandMod("Racial", race.landSpeed);
    _movement.addSwimMod("Racial", race.swimSpeed);
    _movement.addFlyMod("Racial", race.flySpeed);
    _proficiencyBonus = characterClass.proficiencyBonus;
    _alignment = "Neutral Good"; // Default. Set after creation.
    
    // Put rolled stats into their respective abilities.
    Strength.setAbilityScore(strength);
    Dexterity.setAbilityScore(dexterity);
    Constitution.setAbilityScore(constitution);
    Intelligence.setAbilityScore(intelligence);
    Wisdom.setAbilityScore(wisdom);
    Charisma.setAbilityScore(charisma);           
//    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    
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
  
  
  //Map<String, Map> itemList = {};
  void equipWeapon([Weapon weapon = null]) {
    if (weapon != null) {
      weaponList.add(weapon);
    }
    else {
      // You haven't a weapon to equip, fool!
    }
  }
  
  void equipArmor([Armor armor = null]) {
    if (armor != null) {
      armorList.putIfAbsent(armor.location, () => armor);
      calcArmorClass(armor);
    }
    else {
      // Nothing
    }
  }
  
  void setAbilitiesForSkills() {
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];  

  }
  
  int calcArmorClass([Armor armor]) {
    if (armor != null) {
      _armorClass = (BASE_AC + Dexterity.mod + (armor.armorBonus == null ? 0 : armor.armorBonus));       
    }
    else {
      _armorClass = (BASE_AC + Dexterity.mod);       
    }
    return _armorClass;    
  }
  
  String showAcSources() {
    String armorBonuses;
    
    String baseArmor = "Base: $BASE_AC";
    String dex = "\nDexterity: ${Dexterity.mod}";
    String armor = "\nArmor: ";
    if (armorList["torso"].armorBonus == null) {
      armor += "0";
    }
    else {
      armor += "${armorList["torso"].armorBonus}";            
    }
    /*
     * Armor
     * Dex
     * Dodge
     * 
     * 
     * if (tempBonus == true)
     */
    armorBonuses = baseArmor + dex + armor;
    
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
  
  @override String toString() {
    StringBuffer sb = new StringBuffer();
    
    sb.writeln("Name: ${capitalize(name)}   Race: ${capitalize(raceName)}   Class: ${capitalize(className)}  Level: $level");
    sb.writeln("Alignment: ${capitalize(alignment)}   Size: ${capitalize(size)}   Hit Die: ${hitDie}");
    sb.writeln("HP: $_maxHitPoints   Armor Class: $_armorClass   Speed: $_movement");
    sb.writeln("Proficiency Bonus: $_proficiencyBonus   Status: ${capitalize(status)}");
    sb.writeln(statBlock());
    sb.writeln("Deity: ${capitalize(deity)} Patron: ${capitalize(patron)}");
    sb.writeln("____________________");
    sb.writeln("Armor: ${armorList["torso"]}"); // {armorList["torso"].name}
    sb.writeln("____________________");
    sb.write("Weapon(s): ");
    weaponList.forEach(sb.write);
    
    return sb.toString();
  }
  
  String statBlock() {
    StringBuffer sb = new StringBuffer();
    
    abilities.forEach((Ability ability) {
      sb.writeln("${ability.name}: ${ability.score}");
    });
    
    return sb.toString();
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
  List<Ability> get abilitiesList => abilities;
  int get currentHP => _currentHitPoints;
  int get level => _level;
  String get hitDie => "d${_charClass.hitDie}";
  int get maxHP => _maxHitPoints;
  int get AC => _armorClass;
  int get proficiencyBonus => _proficiencyBonus;
  int get landMovement => _movement.landSpeed;
  int get swimMovement => _movement.swimSpeed;
  int get flyMovement => _movement.flySpeed;
  String get name => _name;
  String get size => _charRace.size;
  String get raceName => _charRace.name;
  String get className => _charClass.name;
  String get creatureType => _type == null ? "humanoid" : _type; // eg. Humanoid, Abberation, Construct etc.
  String get alignment => _alignment;
  String get status => _status;
  String get deity => _deity == null ? "None" : _deity;
  String get patron => _patron == null ? "None" : _patron;
  bool get isCompleted => _charCreationIsCreated;
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
  void set size(String size) { _size = size;}
  void set level(int lvl) { _level = lvl;}
  void set HD(int hd) {
    _hitDie = hd;    
  }
//  void set maxHP(int hpMax) {_maxHitPoints = hpMax;}
  //void set AC(int ac) { _armorClass = ac;} // Calculated automatically.
  //void set proficiencyBonus(int prof) { _proficiency = prof;}
  //void set movement => _movement
  void set name(String name) { _name = name;}
  void set characterClass(CharClass charClass) {
    _charClass = charClass;
    _proficiencyBonus = charClass.proficiencyBonus;
    _hitDie = charClass.hitDie;
  }
  void set race(Race race) {
    _charRace = race;
    _movement = race.speed;
    _size = race.size;
    _type = race.type;    
  }
  void set allignment(String allignment) { _alignment = allignment;}
  void setAbilitiesByList(List<Ability> incomingList) {
    if (incomingList[0].name == "Strength") {
      setEachAbility(incomingList[0], incomingList[1], incomingList[2], incomingList[3], incomingList[4], incomingList[5]);       
    }
//    incomingList.forEach((Ability newAb) {
//        abilities.forEach((Ability ab) {
//          if (ab.name == newAb.name) {
//            ab.setAbilityScore(newAb.score);
//          }
//        });
//      });
      abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
      abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];
  }
  
  void setEachAbility(Ability str, Ability dex, Ability con, Ability int, Ability wis, Ability cha) {
    Strength.setAbilityScore(str.score);
    Dexterity.setAbilityScore(dex.score);
    Constitution.setAbilityScore(con.score);
    Intelligence.setAbilityScore(int.score);
    Wisdom.setAbilityScore(wis.score);
    Charisma.setAbilityScore(cha.score);
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];
  }
//  void set type(String type) { _type = type;} // eg. Humanoid, Abberation, Construct etc.
  void set status(String status) { _status = status;}
  void set deity(String deity) {_deity = deity;}
  void set patron(String patron) {_patron = patron;}
  void calcHpAtLevelOne() {
    if (Constitution.score > 0 && _hitDie > 0) {
      _maxHitPoints = Constitution.mod + _hitDie;
    }
  }

  void set isCompleted(bool isDone) {
    _charCreationIsCreated = isDone;
  }
  
} // End class Entity  







