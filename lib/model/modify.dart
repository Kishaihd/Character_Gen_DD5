library model.modify;

String capitalize(String word) {
  String firstLetter = word[0].toUpperCase();
  
  if (word.length > 1) {
    return "${firstLetter}${word.substring(1)}";
  }    
  return "${firstLetter}";
}

// This class will handle extraneous data modification/manipulations that come from sources
// such eats, items/equipment, conditional/combat bonuses and modifiers.

class Modify {
  int _intData;
  String _strData;
  String _attribute;
  
  Modify();
  
  void increase(int amount) {
    
  }
  
  void decrease(int amount) {
      
    }
  
  String addAttribute(String attribute) {
    
    return attribute;
  }
  
  @override toString() {
    return " ";
  }
}