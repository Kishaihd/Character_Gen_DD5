library model.condition;

class Condition {
  String _name;
  String _description;
  
  
  Condition();
  
  Condition.parameterized(this._name, this._description);
  
  get name => _name;
  get description => _description;
  
  void set name(String name) { _name = name; }
  void set description(String desc) { _description = desc; }

  @override toString() {
    return "$_name: $_description";
  }
}
