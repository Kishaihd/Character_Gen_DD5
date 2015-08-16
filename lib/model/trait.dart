library model.traits;

class Trait {
  String _name;
  String _description;

  Trait.fromParam(String n, String d) {
    _name = n;
    _description = d;
  }

  String get name => _name;
  String get description => _description;
}