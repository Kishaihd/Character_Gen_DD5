library race_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:core_elements/core_input.dart';
import 'package:paper_elements/paper_input_decorator.dart';
import '../../model/global.dart';
import '../../model/race.dart';
//import '../../model/chargen_model/model.dart' as model;

@CustomTag('race-view')
class RaceView extends PolymerElement {

//  @observable String abilityScore;

  @published Race race;
  @published String raceName;

  RaceView.created() : super.created();

  @override void attached() {
    super.attached();
    raceName = race.name;
    log.info("$runtimeType::attached()");
//    abilityScore = (ability.score == null ? 0 : ability.score).toString();
  }

  void raceChanged(oldValue) {
    log.info("$runtimeType::abilityScoreChanged()");
    // Remove old values.
    // Add new values.
  }

  void validate() {
    PaperInputDecorator decorator = document.getElementById('paperAbility');
    CoreInput input = document.getElementById('abilityBox');
    decorator.isInvalid = !input.validity.valid;
  }


  void keySubmit(KeyboardEvent event, var detail, Element target) {
    log.info("$runtimeType::keySubmit()");
    if (event.keyCode == KeyCode.ENTER) {
      document.getElementById('abilityBox');

      //    ability.setAbilityScore(abilityScore);
    }
  }
}