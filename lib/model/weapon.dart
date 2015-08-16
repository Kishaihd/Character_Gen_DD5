import 'equipment.dart';
import 'modify.dart';

Map<String, dynamic> weaponProperties = {
  "Ammunition" : "Must have ammunition to attack with this weapon; Can recover half ammo at end of battle if one minute is spent; Can use ammo as an improvised weapon.",
  "Finesse" : "Can use Strength OR Dexterity for attacks and damage. Must use same ability for both"
};

class Weapon extends Item {
  int _damageDie;
  int _numDice;
  String _dmgType;
  int _magicDmg;
  String _magicDmgType;
//  List<String> _properties;

  Weapon(String name, String type, String size, int value, int weight, int dmgDie, int numDice, String dmgType, String description, [bool enchanted = false, int magicBonusValue = 0]) : super(name, type, size, value, weight, description, enchanted, magicBonusValue) {
    _damageDie = dmgDie;
    _numDice = numDice;
    _dmgType = dmgType;
    //_properties = properties;
    //_properties = [];
  }

  void enchant(int bonusValue) {
    _enchanted = true;
    _description = _description == null ? "Enchanted Weapon" : "Enchanted " + _description;
    _magicBonusValue = bonusValue;
  }

  @override toString() => "${capitalize(name)} - Deals ${_numDice}d${_damageDie} ${capitalize(dmgType)} damage.";

  int get damageDie => _damageDie;

  int get numDice => _numDice;

  String get dmgType => _dmgType;

  int get magicDmg => _magicDmg == null ? 0 : _magicDmg;

  String get magicDmgType => _magicDmgType == null ? 0 : _magicDmgType;

  String get properties {
    String props = "";
    _properties.forEach((String prop) => props += prop + " ");
    return props;
  }

}

// Should I have a list somewhere of all the weapons? Mebe?
class Scimitar implements Weapon {
  Scimitar() {
    _name = "Scimitar";
    _type = "Melee";
    _size = "Medium";
    _value = 25;
    _weight = 3;
    _damageDie = 6;
    _numDice = 1;
    _dmgType = "Slashing";
    _description = "";
    _properties.add("Light");
    _properties.add("Finesse");
  }
}

