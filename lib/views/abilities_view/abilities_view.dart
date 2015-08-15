library abilities_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import '../../model/chargen_model/chargen_model.dart'; //???
import '../../model/ability.dart';
import 'package:paper_elements/paper_toast.dart';

@CustomTag('abilities-view')
class AbilitiesView extends PolymerElement {
  
  @published ChargenModel model;
  List<Ability> abList;
//  @published List<Ability> abList;
  //@published List<Ability> abList;// = toObservable([]);
  
  PaperToast pt;
  
  AbilitiesView.created() : super.created();
  
  @override void attached() {
    super.attached();
    @published abList = model.abList;
//    @published model.character.abilitiesList;
    //abList = model.character.abilitiesList;
    //abList = model.abList;
    //abList = model.character.abilitiesList;
    pt = $['acceptedToast'];
    
    log.info("$runtimeType::attached()");
  }

  // a sample event handler function
  void eventHandler(Event event, var detail, Element target) {
    log.info("$runtimeType::eventHandler()");
  }

  void randStats(Event event, var detail, Element target) {        
    log.info("$runtimeType::randStat()");
//    abList.forEach((Ability ab) {
//      ab.setAbilityScore(ab.roll());
//    });
    model.character.abilitiesList.forEach((Ability ab) {
      ab.setAbilityScore(ab.roll());
    });
//    model.abList.forEach((Ability ab) {
//      ab.setAbilityScore(ab.roll());
//    });
//      model.character.abilitiesList.forEach((Ability ab) {
//        ab.setAbilityScore(ab.roll());
//      });
//      abilityScore = ability.toString();
//    inputValue = abilityScore;
//      ability.setAbilityScore(int.parse(abilityScore));
    }

  void abilitiesSubmit() {
    log.info("$runtimeType::abilitiesSubmit()");
    pt.toggle();
    
//    model.character.setAbilitiesByList(model.character.ab abList); 
      // If they're updating/setting in real-time, 
      //do I need to do anything here?
    //pt.show();
  }

  
  
  void closeToast() {
    if (pt.opened == true) {
      pt.toggle();      
    } 
  }
  
}