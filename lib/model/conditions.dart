library model.conditions;

import 'modify.dart';

class Condition {
  String _name;
  String _description;
  Map<String, int> _modList;

  Condition(this._name, this._description, this._modList) {}

  Condition.fromMap(String name, Map<String, dynamic> map) {
    _name = name;
    _description = map["Desc"];
    _modList = map["modList"];
  }

  String get name => _name;
  String get description => _description;
  List get modList => _modList;
}