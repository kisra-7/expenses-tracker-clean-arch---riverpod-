import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final incomePorvider = ChangeNotifierProvider<IncomeProvider>((ref) {
  return IncomeProvider();
});

class IncomeProvider extends ChangeNotifier {
  double? income;
  void updateIncome(double num) {
    income = num;
    notifyListeners();
  }

  double getMoneyLeft(double totalExpenses) {
    double ml = income! - totalExpenses;
    return ml;
  }
}
