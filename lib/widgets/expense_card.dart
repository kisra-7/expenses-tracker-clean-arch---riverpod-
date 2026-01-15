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
    return InkWell(
      onLongPress: () {
        ref.watch(dbProvider.notifier).deleteExpenseFromDb(index);
      },
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Color(expense.color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref.watch(dbProvider).expensesList[index].title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '${ref.watch(dbProvider).expensesList[index].cost.toStringAsFixed(0)} OMR',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
