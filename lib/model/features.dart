library model.features;

import 'dart:convert';


class Feature {
  int _level;
  String _feature;
  String _description;
  
  
  Feature(this._level, this._feature, this._description) {
    
  }
  
  Feature.fromMap(int level, Map<String, String> map) : this(level, map["feature"], map["description"]);
  
 
  @override String toString() {
    return "${_feature.toUpperCase()}: ${_description} ";
  }
  
  int get level => _level;
  String get name => _feature;
  String get desccription => _description;  
  
  void set level(int lvl) {
    _level = lvl;
  }
}



class FeatureList {
  String _className;
  //Feature newFeature;
  List<List<Feature>> classFeatures = [];
 
  FeatureList(this._className, this.classFeatures);

//  FeatureList.fromMap(Map<String, List<List<Map<String, String>>>> allFeatures) {
//    allFeatures.forEach((String className) {
//      
//    });
//  }
  
  FeatureList.fromList(String className, List<List<Map<String, String>>> fullList) { 
    _className = className;
    //List<Map<String, String>> featuresByLevel;
    for (int i = 0; i < fullList.length; i++) {
      fullList[i].forEach((Map featuresByLevel) {
        featuresByLevel.forEach((String key, String value) {
          classFeatures[i].add(new Feature(i, key, value));          
        });
      });
    }
  }    
  
  
  List featuresAtLevel(int charLevel) {    
    return classFeatures[charLevel - 1];
  }

  List get featuresList => classFeatures;
  
  // Necessary?
  void set className(String className) {
    _className = className;
  }
  
  
  
}












