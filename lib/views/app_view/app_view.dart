library app_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import 'package:polymer_expressions/filter.dart';
import '../../utils/filters.dart';

@CustomTag('app-view')
class AppView extends PolymerElement {

  static const String INTRO_VIEW = "INTRO_VIEW";
  static const String ABILITIES_VIEW = "ABILITIES_VIEW";
  static const String RACE_VIEW = "RACE_VIEW";
  static const String CLASS_VIEW = "CLASS_VIEW";
  
  // initialize system log
  bool _logInitialized = initLog();

  @observable String bindingTest = "Binding is working...";
  @observable String bindingTest_abilities = "Abilities. Sup.";
  @observable String bindingTest_intro = "Main page. Sup.";
  @observable bool abilitiesDone = false;
  @observable bool raceDone = false;
  @observable bool classDone = false;
  @observable bool characterCreated = false;
  
  @observable String currentView = INTRO_VIEW;
  @observable int tabSelected = 0;
  
  void changeView(Event e, var detail, Element target) {
        currentView = target.attributes['data-view'];
    }
  
  // filters and transformers can be referenced as class fields
  final Transformer asInteger = new StringToInt();

  // non-visual initialization can be done here
  AppView.created() : super.created();

  // life-cycle method called by the Polymer framework when the element is attached to the DOM
  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
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

