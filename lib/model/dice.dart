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
  
  int rollDie([int sides]) {
    if (sides == null) {
      return rand.nextInt(_sides) + 1;  
    }
    else {
      return rand.nextInt(sides) + 1;      
    }
  }
  
  int rollDndAbility([int number_of_dice]) {
    int theRoll = 0;
    int numOfDice;
    
    if (number_of_dice == null) {
      numOfDice = 3;
    }
    for (int i = 0; i < numOfDice; i++) {
      theRoll += rollDie(6);
    }    
    return theRoll;  
  }
  
    String rollToString(int qty, int sides, int mod, {bool htmlOutput: true}) {
      if (qty < 1 || sides < 1) {
        return ERROR;
      }

      StringBuffer sb = new StringBuffer();

      int total = 0;
      int rollsTotal = 0;
      List<int> rolls = new List<int>(qty);

      for (int i = 0; i < qty; i++) {
        rolls[i] = rollDie(sides);
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
