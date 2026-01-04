import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseCard extends ConsumerWidget {
  final Expense expense;
  final int index;
  const ExpenseCard({super.key, required this.expense, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(expense.id),
      onDismissed: (direction) {
        ref.watch(dbProvider.notifier).deleteExpenseFromDb(index);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: Color(expense.color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              expense.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(expense.description, style: TextStyle(color: Colors.white)),
            Text(
              expense.cost.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
