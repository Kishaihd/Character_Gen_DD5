library model.conditions;

import 'modify.dart';

class Condition {
  String _name;
  String _description;
  List<Mod> _modList;

  Condition(this._name, this._description, this._modList) {}

  Condition.fromMap(String name, Map<String, dynamic> map) {
    _name = name;
    _description = map["Desc"];
    _modList = map["modList"];
  }

  @override toString() {
    return "$_name: $_description";
  }
  
  String get name => _name;
  String get description => _description;
  List get modList => _modList;
  String get modListAsString {  // FIX THIS --------------------------------^%%
    String mods = "${_name}:\n";
    _modList.forEach((Mod mod) {
      mods += "${mod.name}: ${mod.affects} ${posOrNeg(mod.value)} ${mod.value} \n";
    });
    return mods;
  }

  // Inserts a '+' or '-' depending on the value of the mod.
  String posOrNeg(int value) {
    if (value == 0) {
      return "";
    }
    else if (value > 0) {
      return "+";
    }
    else {
      return "-";
    }
  }
}