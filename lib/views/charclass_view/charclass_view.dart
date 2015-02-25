

library ability_view;

import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/filter.dart';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
//import '../../model/  .dart';

@CustomTag('charclass-view')
class CharClassView extends PolymerElement {
  
  @published String abilityName; 
  @observable int inputValue;
  
  CharClassView.created() : super.created();

 // HttpRequest.getString(url)
  
//  HttpRequest.getString(CHORD_LIST_PATH)
//        .then((String fileContents) {
//          List<Map> mapList = JSON.decode(fileContents);
//          chordList = toObservable(mapList.map((Map chordMap) => new Chord.fromMap(chordMap)).toList(growable: false));
//        })
//        .catchError((Error error) => print(error));
  
  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
    
  }
  
  
  
  
//  void setName(Event event, var detail, Element target) {
//    log.info("$runtimeType::setName()"); 
//    ability.setName(abilityName);      
//  }
//  
//  void keySubmit(KeyboardEvent event, var detail, Element target) {
//    log.info("$runtimeType::keySubmit()");  
//    if (event.keyCode == KeyCode.ENTER) {
//        ability.setAbilityScore(inputValue);
//    }
//  }
}