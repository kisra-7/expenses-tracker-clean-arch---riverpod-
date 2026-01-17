import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

final incomePorvider = ChangeNotifierProvider<IncomeProvider>((ref) {
  return IncomeProvider();
});

class IncomeProvider extends ChangeNotifier {
  double income = 0;

  IncomeProvider() {
    loadIncomeData();
  }

  void loadIncomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    income = prefs.getDouble('income') ?? 0;
  }

  void updateIncome(double num) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    income = num;
    notifyListeners();
    prefs.setDouble('income', income);
  }

  double getMoneyLeft(double totalExpenses) {
    double ml = income - totalExpenses;
    return ml;
  }
}
