

library feature_view;

import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/filter.dart';
import 'package:polymer/polymer.dart';
import '../../model/global.dart';
import '../../model/features.dart';

@CustomTag('feature-view')
class FeatureView extends PolymerElement {
  
  @published List featureList; 
  @published String featureLevel;
  @published String featureName;
  @published String featureDesc;

  Feature feature;
  
  FeatureView.created() : super.created();

  @override void attached() {
    super.attached();
    log.info("$runtimeType::attached()");
    
    feature = new Feature();
    
  }
  
  void showFeature(Event event, var detail, Element target) {
    log.info("$runtimeType::showFeature()");
     
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