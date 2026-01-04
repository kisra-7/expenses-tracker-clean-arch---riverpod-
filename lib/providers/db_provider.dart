import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final dbProvider = ChangeNotifierProvider<DbProvider>((ref) {
  return DbProvider();
});

class DbProvider extends ChangeNotifier {
  List<Expense> expensesList = [];
  Color color = Colors.teal;

  Future upLoadExpenseToDb(Expense expense) async {
    FirebaseFirestore.instance.collection('expensses').add({
      'title': expense.title,
      'description': expense.description,
      'color': expense.color,
      'cost': expense.cost,
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'date': expense.date,
      'id': expense.id,
    });
  }

  double sumCosts() {
    double total = 0;
    for (Expense expense in expensesList) {
      total = total + expense.cost;
    }
    return total;
  }

  Future getDataFromDb() async {
    try {
      final snapShot = await FirebaseFirestore.instance
          .collection('expensses')
          .where('creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      // ignore: avoid_print
      print(FirebaseAuth.instance.currentUser!.uid);

      expensesList = snapShot.docs.map((doc) {
        return Expense.fromFirestore(doc.data(), doc.id);
      }).toList();
      notifyListeners();
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future deleteExpenseFromDb(int index) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('expensses')
        .where('creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    FirebaseFirestore.instance
        .collection('expensses')
        .doc(snapShot.docs[index].id)
        .delete();
    getDataFromDb();
  }

  void changeColor(Color selectedColor) {
    color = selectedColor;
    notifyListeners();
  }
}
