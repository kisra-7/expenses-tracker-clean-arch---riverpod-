// lib/features/expenses/presentation/pages/home_page.dart
import 'package:expenses_tracker/features/expenses/presentation/controllers/expensses_controller.dart';
import 'package:expenses_tracker/features/expenses/presentation/pages/add_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/expense_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expenseControllerProvider);
    final controller = ref.read(expenseControllerProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[300],
        child: const Icon(Icons.add, size: 25),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExpensePage()),
          );
        },
      ),
      appBar: AppBar(
        title: const Text(
          'H O M E',
          style: TextStyle(color: Colors.teal, fontSize: 30),
        ),
      ),
      body: expensesAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (expensesList) {
          if (expensesList.isEmpty) {
            return const Center(child: Text('No expenses yet'));
          }

          final total = controller.sumCosts(expensesList);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.01,
                ),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal[700],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'expensses:$total',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.4,
                    crossAxisCount: 2,
                  ),
                  itemCount: expensesList.length,
                  itemBuilder: (_, index) {
                    return ExpenseCard(
                      expense: expensesList[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
