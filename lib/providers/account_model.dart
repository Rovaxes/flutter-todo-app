import 'package:flutter/material.dart';

class AccountModel extends ChangeNotifier {
  int _level = 0;
  double _expierenceCurrent = 0;
  double _expierenceTotal = 100;

  int get level => _level;
  double get expierenceCurrent => _expierenceCurrent;
  double get expierenceTotal => _expierenceTotal;

  /// Removes all items from the cart.
  void removeAll() {
    notifyListeners();
  }

  void gainExpierence(double expierence, Function levelUpCallback) {
    _expierenceCurrent += expierence;

    // Level Up Check
    if (_expierenceCurrent >= _expierenceTotal) {
      levelUpCallback();
      _level += 1;
      _expierenceCurrent -= _expierenceTotal;

      _expierenceTotal += 50;
    }

    notifyListeners();
  }
}
