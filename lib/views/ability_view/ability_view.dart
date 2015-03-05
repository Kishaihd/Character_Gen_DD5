library ability_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:core_elements/core_input.dart';
import 'package:paper_elements/paper_input_decorator.dart';
import '../../model/global.dart';
import '../../model/ability.dart';

@CustomTag('ability-view')
class AbilityView extends PolymerElement {

  @published String abilityName; 
  @observable String abilityScore;
  
  @published Ability ability;
  
  AbilityView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
    
    ability = new Ability(abilityName);
    abilityScore = (ability.score == null ? 0 : ability.score).toString();
  }
  
  void abilityScoreChanged(oldValue) {
    log.info("$runtimeType::abilityScoreChanged()");
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
  
  void validate() {
    PaperInputDecorator decorator = document.getElementById('paperAbility');
    CoreInput input = document.getElementById('abilityBox');
    decorator.isInvalid = !input.validity.valid;
  }
  
  // a sample event handler function
  void randStat(Event event, var detail, Element target) {    
    log.info("$runtimeType::randStat()");
    abilityScore = ability.roll().toString();
//    inputValue = abilityScore;
    ability.setAbilityScore(int.parse(abilityScore));
  }
  
//  void setName(Event event, var detail, Element target) {
//    log.info("$runtimeType::setName()"); 
//    ability.setName(abilityName);      
//  }
  
  void keySubmit(KeyboardEvent event, var detail, Element target) {
    log.info("$runtimeType::keySubmit()");  
    if (event.keyCode == KeyCode.ENTER) {
      document.getElementById('abilityBox');
    
    //    ability.setAbilityScore(abilityScore);
    }
  }
}