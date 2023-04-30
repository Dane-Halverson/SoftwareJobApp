

import 'dart:math';

class CostEstimator {

  static String esitmateRent({required double costOfLiving, required double rent}) {
    double total = costOfLiving+rent;
    return 'Renting: \$${total.toStringAsFixed(2)} per month';
  }

  static String esitmateHouse({required double housePrice, required double costOfLiving}) {
    String house = housePrice.toStringAsFixed(2);
    String living = costOfLiving.toStringAsFixed(2);
    return 'House: \$$living per month + \$$house';
  }

  static String esitmateHouse15Year({required double housePrice, required double costOfLiving, double rate = 0.062}) {
    double ratePerMonth = rate/12;
    int payments = 15*12;
    double top = ratePerMonth * pow(1 + ratePerMonth, payments);
    double bottom = pow(1 + ratePerMonth, payments) - 1;
    double mortgagePerMonth = housePrice*(top/bottom);
    double total = mortgagePerMonth + costOfLiving;
    return 'House (15 year mortgage): \$${total.toStringAsFixed(2)} per month';
  }

  static String esitmateHouse30Year({required double housePrice, required double costOfLiving, double rate = 0.0682}) {
    double ratePerMonth = rate/12;
    int payments = 30*12;
    double top = ratePerMonth * pow(1 + ratePerMonth, payments);
    double bottom = pow(1 + ratePerMonth, payments) - 1;
    double mortgagePerMonth = housePrice*(top/bottom);
    double total = mortgagePerMonth + costOfLiving;
    return 'House (30 year mortgage): \$${total.toStringAsFixed(2)} per month';
  }

}