library ability_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:core_elements/core_input.dart';
import 'package:paper_elements/paper_input_decorator.dart';
import '../../model/global.dart';
import '../../model/ability.dart';
//import '../../model/chargen_model/chargen_model.dart';

@CustomTag('ability-view')
class AbilityView extends PolymerElement {

//  @observable ChargenModel model; 
//  @published String abilityName; 
  @observable String abilityScore;
  
  @published Ability ability;
//  int abilityIdx;
//  List<Ability> ab;
  
  AbilityView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
//    ab = model.character.abilitiesList;
//    for (int i = 0; i < ab.length; i++) {
//      if (abilityName == ab[i].name) {      
//        abilityIdx = i;
//        ability = ab[i];
//      }
//    }  
    abilityScore = (ability.score == null ? 0 : ability.score).toString();
  }
  
  void abilityScoreChanged(oldValue) {
    log.info("$runtimeType::abilityScoreChanged()");
    // Do validation on the parsed string (inputValue)
    if (oldValue != null) {
      if (int.parse(oldValue) == int) {
        int val = int.parse(oldValue);
        if (val < 20 && val >= 0) {
          ability.setAbilityScore(val);
        }        
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