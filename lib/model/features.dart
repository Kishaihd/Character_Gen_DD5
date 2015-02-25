library model.features;

import 'dart:convert';


class Feature {
  int _level;
  String _name;
  String _description;

  
  Feature(String level, this._name, this._description) {
    _level = int.parse(level);
  }

  Feature.fromMap(Map<String, String> map) : this(map["level"], map["name"], map["description"]);
  
 
  @override String toString() {
    return "${_name.toUpperCase()}: ${_description} ";
  }
  
  int get level => _level;
  
}



class FeatureList {
  List<Feature> classFeatures = [];
 
  FeatureList();
  
  FeatureList.fromMap(Map<int, Object> map) {
    List<Map<String, String>> featureMaps = map["classFeatures"];

    featureMaps.forEach((Map<String, String> feature) {
      classFeatures.add(new Feature.fromMap(feature));      
    });
    
    //    map.forEach((Map<String, String> asd) {
//      
//    });
    
    
    
    
  }
  
}