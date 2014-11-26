library model.Entity;

//import 'dart:io';
import 'Ability.dart';
import 'Skill.dart';
import 'Character_Class.dart';
import 'Race.dart';

class Entity {
  String _name;
  //String _race;
  CharClass _charClass;
  Race _charRace;
  String _type; // eg. Humanoid, Abberation, Construct etc.
  String _alignment;
  String _size;
  int _level;
  int _hitDie;
  int _maxHitPoints;
  int _currentHitPoints;
  int _armorClass;
  int _proficiencyBonus;
  int _movement;
  String _status;
  
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
  
  List<Skill> strSkills = [];
  List<Skill> dexSkills = [];
  List<Skill> intSkills = [];
  List<Skill> wisSkills = [];
  List<Skill> chaSkills = [];
  
  List<List> fullSkillList;
  
  // Does not include Constitution.
  List<int> abilitiesForSkills = [];
  
  bool statsCalculated = false;
  
  // Parameterized constructor.
  // Name, Character's class, Race, ability scores.
  Entity(this._name, CharClass characterClass, Race race, int strength, int dexterity, int constitution, int intelligence, int wisdom, int charisma) {
    _status = "normal";
    _level = 1;

    _charRace = race;
    _type = race.type;
    _charClass = characterClass;
    _hitDie = characterClass.hitDie;
    
    Strength.setAbility(strength);
    Dexterity.setAbility(dexterity);
    Constitution.setAbility(constitution);
    Intelligence.setAbility(intelligence);
    Wisdom.setAbility(wisdom);
    Charisma.setAbility(charisma);           
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    
    // Add racial bonuses to Abilities.
    abilities.forEach((Ability ability) {
      for (int i = 0; i < race.racialAbilities.length; i++) {
        if (ability.name == race.racialAbilities[i]) {
          ability.increaseAbility(race.racialAbilities[i]);
        }        
      }      
    });

    _maxHitPoints = (characterClass.hitDie + Constitution.mod);
    _currentHitPoints = _maxHitPoints;    
    
    strSkills = [Athletics];
    dexSkills = [Acrobatics, SleightOfHand, Stealth];
    intSkills = [Arcana, History, Investigation, Nature, Religion];
    wisSkills = [AnimalHandling, Insight, Medicine, Perception, Survival];
    chaSkills = [Deception, Intimidation, Performance, Persuasion];
    
    fullSkillList = [strSkills, dexSkills, intSkills, wisSkills, chaSkills];
    abilitiesForSkills = [Strength.score, Dexterity.score, Intelligence.score, Wisdom.score, Charisma.score];  
    
    
    
  } // End constructor.
  
  void chosenSkillProficiency(Skill skill) {
    skill.isClassSkill(_charClass.proficiencyBonus);
  }
  
  
//  void refactor() {
//  }
  
//  int calcAbilityMod(int abilityScore) {
//    return (abilityScore/2 - 5).floor();
//  }
  
  // Run after race (and class?) is/are selected.
  void skillsPlusAbilities(Race race, CharClass charClass) {
    // First loops adds all ability modifiers to skills.
    for (int i = 0; i < abilitiesForSkills.length; i++) {     
      fullSkillList[i].forEach((List<Skill> subSkillList) { 
        subSkillList.forEach((Skill skill) {
          skill.setValue(abilitiesForSkills[i]);  
        }); // End subSkillList.forEach
      }); // End fullSkillList.forEach
    } // End for loop
    
    //Second loop sets skill proficiencies.
    // Isn't there some function to find any key in a Map where it's value equals something else?    
    for (int i = 0; i < fullSkillList.length; i++) {
      fullSkillList[i].forEach((List<Skill> subSkillList) {
        subSkillList.forEach((Skill skill) {
          for (int j = 0; j < race.skillProficiencies.length; j++) {
            if (skill.name == race.skillProficiencies[j]) {
              skill.isClassSkill(charClass.proficiencyBonus);
            } // End if.
          } // End For j.
        }); // End subSkillList.forEach().
      }); // End fullSkillList.forEach().        
    }
  }


  
  
  //  void skillsPlusAbilities() {    
//    List<Map> newSkillList = [];
//    for (int i = 0; i < abilitiesForSkills.length; i++) {     
//      skillList[i].forEach((String skillName,int skillRank) { 
//        skillList[i][skillName] = skillRank + calcAbilityMod(abilitiesForSkills[i]);
//            }); 
//    }
//  } 

  
  
//  // Adds racial bonuses to abilities and skills?
//  void addRace() {
//    switch (_race) {
//      case 'human':
//        abilities.forEach((Ability ability) {
//          ability.increaseAbility(1);
//          _movement = 30;
//      });
//        
//        break;
//      case 'elf':
//        
//        break;
//      default:
//        
//    }
//    
//    
//  } // End addRace()
  
//  void chooseSkillProficiency(Skill skill) {
//    skill.increaseValue(_proficiency);
//  }
  
//  void chooseStatIncrease() {
//    print("This function is only for the command line version of this app!\n"
//          "Choose a stat to increase, nigga! (s)tr, (d)ex, (c)on, (i)nt, (w)is, (c)ha.");
//    String answer = stdin.readLineSync();
//    switch(answer) {
//      case 's':
//          
//      case 'd':
//        
//      case 'c':
//        
//      case 'i':
//        
//      case 'w':
//        
//      case 'c':
//        
//        break;
//    }
//  }
  
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
  int get HD => _charClass.hitDie;
  int get maxHP => _maxHitPoints;
  int get AC => _armorClass;
  int get proficiencyBonus => _proficiencyBonus;
  int get movement => _charRace.speed;
  String get name => _name;
  String get size => _charRace.size;
  String get race => _charRace.name;
  String get type => _type == null? "humanoid" : _type; // eg. Humanoid, Abberation, Construct etc.
  String get allignment => _alignment;
  String get status => _status;
      
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

  
} // End class Entity  







