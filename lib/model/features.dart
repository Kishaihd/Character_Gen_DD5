library model.features;

import 'dart:convert';


class Feature {
  int _level;
  String _feature;
  String _description;
  
  
  Feature(this._feature, this._description) {
    
  }
  
  Feature.fromMap(Map<String, String> map) : this(map["feature"], map["description"]);
  
 
  @override String toString() {
    return "${_feature.toUpperCase()}: ${_description} ";
  }
  
  int get level => _level;
  String get featureName => _feature;
  String get featureDesc => _description;  
  
  void set level(int lvl) {
    _level = lvl;
  }
}



class FeatureList {
  String _className;
  List<List<Feature>> classFeatures = [];
 
  FeatureList(this._className, this.classFeatures);

//  FeatureList.fromMap(Map<String, List<List<Map<String, String>>>> allFeatures) {
//    allFeatures.forEach((String className) {
//      
//    });
//  }
  
  FeatureList.fromList(String className, List<List<Map<String, String>>> list) : this(className) {
    List<Map<String, String>> featuresByLevel;
    list.forEach(() {
      
    });

//    featureMaps.forEach((Map<String, String> feature) {
//      classFeatures.add(new Feature.fromMap(feature));      
//    });
    
    //    map.forEach((Map<String, String> asd) {
//      
//    });   
    
    
  }
  
  List featuresAtLevel(int charLevel) {
    return classFeatures[charLevel];
  }

  List get featresList => classFeatures;
  
  void set className(String className) {
    _className = className;
  }
  
  
  
}












