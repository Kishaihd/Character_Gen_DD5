library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import 'package:polymer_expressions/filter.dart';
import '../../utils/filters.dart';
import 'package:core_elements/core_icon_button.dart';
import 'package:core_elements/core_collapse.dart';

import '../../model/entity.dart';
import '../../model/character_class.dart';
import '../../model/dice.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {
  static const String INTRO_VIEW = "INTRO_VIEW";
  static const String CHAR_VIEW = "CHAR_VIEW";
  static const String ABILITIES_VIEW = "ABILITIES_VIEW";
  static const String RACE_VIEW = "RACE_VIEW";
    static const String HUMAN = "HUMAN";
    static const String ELF = "ELF";
    static const String DWARF = "DWARF";
    static const String GNOME = "GNOME";
    static const String HALFLING = "HALFLING";
    static const String TIEFLING = "TIEFLING";
    static const String HALF_ELF = "HALF_ELF";
  static const String CLASS_VIEW = "CLASS_VIEW";
  @observable final List ABILITIES = [ // Might not even need these.
    "Strength",
    "Dexterity",
    "Constitution",
    "Intelligence",
    "Wisdom",
    "Charisma"
  ];
  
  // Getting class features from JSON
  String get dataURL => "../web/resources/data/warlock_class_features.json";
  @observable Map<String, List<List<Map<String, String>>>> dataFromJSON = toObservable({});  
  @observable List<List<Map<String, String>>> barbarianFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> bardFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> clericFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> druidFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> fighterFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> rangerFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> rogueFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> sorcererFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> warlockFeatureList = toObservable([]);
  @observable List<List<Map<String, String>>> wizardFeatureList = toObservable([]);
  
  
  @observable Entity character;
  @observable String charName;
  //CharClass bob = new Warlock();
  //Die dice = new Die(6);
  
  // initialize system log
  bool _logInitialized = initLog();
  
  @observable String bindingTest = "Binding is working...";
  @observable String bindingTest_abilities1 = "Abilities Page one. Sup.";
  @observable String bindingTest_abilities2 = "Abilities Page two. Sup.";
  @observable String bindingTest_intro = "Main page. Sup.";
  @observable bool abilitiesDone = false;
  @observable bool raceDone = false;
  @observable bool classDone = false;
  @observable bool characterCreated = false;
  
  @observable String currentView = INTRO_VIEW;
  @observable String raceChoice = HUMAN;
  @observable int tabSelected = 0;
  
  void changeView(Event e, var detail, Element target) {
    currentView = target.attributes['data-view'];
    log.info("$runtimeType::changeView()");
  }
  
  void changeRaceChoice(Event e, var detail, Element target) {
    raceChoice = target.attributes['race-view'];
    log.info("$runtimeType::changeRaceChoice()::$raceChoice");
  }
  
  void setCharName(Event e, var detail, Element target) {    
    charName = target.text;
        //document.querySelector('.raceList').text;
    log.info("$runtimeType::setCharName()::$charName");
  }
  
  void onFeatureLoaded(Event event, var detail, Element target) {
    log.info("$runtimeType::onFeatureLoaded():: ");
    dataFromJSON = detail['response'];
    barbarianFeatureList = dataFromJSON["barbarian"];
    bardFeatureList = dataFromJSON["bard"];
    clericFeatureList = dataFromJSON["cleric"];
    druidFeatureList = dataFromJSON["druid"];
    fighterFeatureList = dataFromJSON["fighter"];
    rangerFeatureList = dataFromJSON["ranger"];
    rogueFeatureList = dataFromJSON["rogue"];
    sorcererFeatureList = dataFromJSON["sorcerer"];
    warlockFeatureList = dataFromJSON["warlock"];
    wizardFeatureList = dataFromJSON["wizard"];
    
  
  }
  
  // filters and transformers can be referenced as class fields
  final Transformer asInteger = new StringToInt();

  // non-visual initialization can be done here
  AppView.created() : super.created();

  // life-cycle method called by the Polymer framework when the element is attached to the DOM
  @override void attached() {
    super.attached();
    CoreIconButton menuButton = querySelector('core-scaffold::shadow core-icon-button');
    menuButton.icon = 'folder';
    log.info("$runtimeType::attached()");
  }

  void toggle(Event event, var detail, Element target) {
    CoreCollapse c = $['collapse'];
    c.toggle();
    log.info("$runtimeType::toggleCollapse()");
  }
  
  
  // a sample event handler function
  void eventHandler(Event event, var detail, Element target) {
    log.info("$runtimeType::eventHandler()");
  }

  void submit(Event event, var detail, Element target) {
    // prevent app reload on <form> submission
    event.preventDefault();
  }

}

