import 'package:expenses_tracker/models/expense.dart';

import 'package:expenses_tracker/providers/db_provider.dart';
import 'package:expenses_tracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenssesPage extends ConsumerWidget {
  const ExpenssesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Expense> expenseList = ref.watch(dbProvider).expensesList;
    return Scaffold(
      appBar: AppBar(title: Text('EXPENSE', style: TextStyle())),
      body: Center(
        child: expenseList.isEmpty
            ? CircularProgressIndicator.adaptive()
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: expenseList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ExpenseCard(
                            expense: expenseList[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.teal[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'TOTAL: ${ref.watch(dbProvider).sumCosts().toStringAsFixed(0)} OMR',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
