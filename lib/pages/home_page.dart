import 'package:expenses_tracker/pages/add_expense_page.dart';
import 'package:expenses_tracker/providers/db_provider.dart';
import 'package:expenses_tracker/providers/income_provider.dart';
import 'package:expenses_tracker/widgets/expense_card.dart';
import 'package:expenses_tracker/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(dbProvider.notifier).getDataFromDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddExpensePage();
                  },
                ),
              );
            },
            icon: Icon(Icons.add, size: 35),
          ),
        ],
        title: Text(
          'H O M E',
          style: TextStyle(color: Colors.teal, fontSize: 30),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.teal[700],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'expensses:${ref.watch(dbProvider.notifier).sumCosts()}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.grey[50],
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                Text(
                  ref.watch(incomePorvider).income != null
                      ? 'Money Left:${ref.watch(incomePorvider.notifier).getMoneyLeft(ref.watch(dbProvider).sumCosts())}'
                      : 'No Income Info',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
              itemCount: ref.watch(dbProvider).expensesList.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpenseCard(
                  expense: ref.watch(dbProvider).expensesList[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
