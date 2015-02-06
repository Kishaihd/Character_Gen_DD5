library ability_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import '../../model/ability.dart';

@CustomTag('ability-view')
class AbilityView extends PolymerElement {

  @published Ability ability; 
  @observable String inputValue;
  
  AbilityView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
    
    inputValue = ability.score.toString();
  }
  
  void inputValueChanged(oldValue) {
    log.info("$runtimeType::inputValueChanged()");
    // Do validation on the parsed string (inputValue)
    // if it passes, set the ability.score to that value. 
    // otherwise... eat a butt.
    // 
  }

  // a sample event handler function
  void randStat(Event event, var detail, Element target) {
    
    log.info("$runtimeType::randStat()");
    
    inputValue = ability.roll().toString();
  }
}