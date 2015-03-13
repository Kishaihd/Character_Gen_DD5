library chargen_model;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import '../ability.dart';
import '../character_class.dart';
import '../dice.dart';
import '../entity.dart';
import '../equipment.dart';
import '../features.dart';
import '../modify.dart';
import '../race.dart';
import '../skill.dart';
import '../weapon.dart';

@CustomTag('chargen-model')
class ChargenModel extends PolymerElement {  
  
  @observable Entity character;  
  
  // Getting class features from JSON
  String get dataURL => "../resources/data/class_features.json";
  @observable Map<String, List<List<Map<String, String>>>> dataFromJSON = toObservable({});  
  @observable List<FeatureList> listOfFeatureLists = toObservable([]);
  
  ChargenModel.created() : super.created();
  
  @override void attached() {    
    character = new Entity();
    super.attached();
    log.info("$runtimeType::attached()");
  }
  
  // a sample event handler function
  void eventHandler(Event event, var detail, Element target) {
    log.info("$runtimeType::eventHandler()");
  }
  
  void onFeatureLoaded(Event event, var detail, Element target) {
      log.info("$runtimeType::onFeatureLoaded()");
      dataFromJSON = detail['response'];
      dataFromJSON.forEach((String name, List<List<Map<String, String>>> featureList) {
        listOfFeatureLists.add(new FeatureList.fromList(name, featureList));
      });
//      listOfFeatureLists.add(new FeatureList.fromList("Barbarian", dataFromJSON["barbarian"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Bard", dataFromJSON["bard"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Cleric", dataFromJSON["cleric"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Druid", dataFromJSON["druid"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Fighter", dataFromJSON["fighter"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Ranger", dataFromJSON["ranger"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Rogue", dataFromJSON["rogue"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Sorcerer", dataFromJSON["sorcerer"]));
//      listOfFeatureLists.add(new FeatureList.fromList("Warlock", dataFromJSON["warlock"]));
//    barbarianFeatureList = new FeatureList.fromList("Barbarian", dataFromJSON["barbarian"]);
//    bardFeatureList = new FeatureList.fromList("Bard", dataFromJSON["bard"]);
//    clericFeatureList = new FeatureList.fromList("Cleric", dataFromJSON["cleric"]);
//    druidFeatureList = new FeatureList.fromList("Druid", dataFromJSON["druid"]);
//    fighterFeatureList = new FeatureList.fromList("Fighter", dataFromJSON["fighter"]);
//    rangerFeatureList = new FeatureList.fromList("Ranger", dataFromJSON["ranger"]);
//    rogueFeatureList = new FeatureList.fromList("Rogue", dataFromJSON["rogue"]);
//    sorcererFeatureList = new FeatureList.fromList("Sorcerer", dataFromJSON["sorcerer"]);
//    warlockFeatureList = new FeatureList.fromList("Warlock", dataFromJSON["warlock"]);
//    wizardFeatureList = new FeatureList.fromList("Wizard", dataFromJSON["wizard"]);
      
    
    }

  Entity get charCreate => character;
  List<Ability> get abList => character.abilitiesList;
}