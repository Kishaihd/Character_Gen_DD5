library model.dice;

import 'dart:math' show Random;

class Die {
  static const String ERROR = "Roll Error";
  int _sides;
  int _value;  
  
  Random rand = new Random(new DateTime.now().millisecondsSinceEpoch);
  
  Die([int sides]) {
    if (sides != null) {
      _sides = sides;
    }
  }
  
  int rollDie() => rand.nextInt(_sides) + 1;

  int rollDieParameterized(int sides) => rand.nextInt(sides);
  
  String rollToString(int qty, int sides, int mod, {bool htmlOutput: true}) {
    if (qty < 1 || sides < 1) {
      return ERROR;
    }

    StringBuffer sb = new StringBuffer();

    int total = 0;
    int rollsTotal = 0;
    List<int> rolls = new List<int>(qty);

    for (int i = 0; i < qty; i++) {
      rolls[i] = rollDie();
      rollsTotal += rolls[i];
    }

    total = rollsTotal + mod;

    String modStr = (mod == 0) ? "" : " " + (mod > 0 ? "+" : "-") + " " + mod.abs().toString();

    sb.write("${qty}d${sides} $rolls$modStr = ");

    String totalStr = htmlOutput ? "<b>$total</b>" : "$total";

    sb.write(totalStr);

    return sb.toString();
  }
}

class DamageDice {
  int _numberOfDice; //1d6? 3d10?
  int _dieType; // eg 6 for a d6.
  Die die;

  DamageDice(this._numberOfDice, this._dieType) {
    die = new Die(_dieType);
  }


  int rollDamage() {
    int dmg = 0;
    for (int i = _numberOfDice; i > 0; i--) {
      dmg += die.rollDie();
    }
    return dmg;
  }


}