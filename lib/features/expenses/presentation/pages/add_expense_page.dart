// lib/features/expenses/presentation/pages/add_expense_page.dart
import 'package:expenses_tracker/features/expenses/domain/entitiy/expense_entitiy.dart';
import 'package:expenses_tracker/features/expenses/presentation/controllers/color_controller.dart';
import 'package:expenses_tracker/features/expenses/presentation/controllers/expensses_controller.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddExpensePage extends ConsumerWidget {
  AddExpensePage({super.key});

  final id = const Uuid().v4();
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();
  final costController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(expenseColorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add expenses')),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: discriptionController,
                decoration: InputDecoration(
                  hintText: 'description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: costController,
                decoration: InputDecoration(
                  hintText: 'cost',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Card(
                elevation: 20,
                child: ColorPicker(
                  onColorChanged: (color) {
                    ref.read(expenseColorProvider.notifier).changeColor(color);
                  },
                ),
              ),

              const SizedBox(height: 20),

              InkWell(
                onTap: () async {
                  if (titleController.text.trim().isEmpty ||
                      discriptionController.text.trim().isEmpty ||
                      costController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please Enter All The Fields'),
                      ),
                    );
                    return;
                  }

                  await ref
                      .read(expenseControllerProvider.notifier)
                      .addExpense(
                        ExpenseEntity(
                          id: id,
                          title: titleController.text.trim(),
                          description: discriptionController.text.trim(),
                          cost: double.parse(costController.text.trim()),
                          color: selectedColor.value,
                          date: DateTime.now(),
                        ),
                      );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(child: Text('Expense added')),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal[300],
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
