library ability_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import '../../model/ability.dart';

@CustomTag('ability-view')
class AbilityView extends PolymerElement {

  @published String abilityName; 
  @observable int inputValue;
  Ability ability;
  
  AbilityView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
    
    ability = new Ability(abilityName);
    inputValue = ability.score == null ? 0 : ability.score;
  }
  
  void inputValueChanged(oldValue) {
    log.info("$runtimeType::inputValueChanged()");
    // Do validation on the parsed string (inputValue)
    if (oldValue != null) {
      if (oldValue == int) {
        ability.setAbilityScore(oldValue);
      }
    }
    // if it passes, set the ability.score to that value. 
    // otherwise... eat a butt.
    // 
  }

  // a sample event handler function
  void randStat(Event event, var detail, Element target) {
    
    log.info("$runtimeType::randStat()");
    
    inputValue = ability.roll();
  }
  
  void setName(Event event, var detail, Element target) {
    log.info("$runtimeType::setName()"); 
    ability.setName(abilityName);      
  }
  
  void keySubmit(KeyboardEvent event, var detail, Element target) {
    log.info("$runtimeType::keySubmit()");  
    if (event.keyCode == KeyCode.ENTER) {
        ability.setAbilityScore(inputValue);
    }
  }
}