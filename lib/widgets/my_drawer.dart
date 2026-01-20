import 'package:expenses_tracker/pages/sign_in_page.dart';
import 'package:expenses_tracker/providers/income_provider.dart';
import 'package:expenses_tracker/widgets/theme_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDrawer extends ConsumerWidget {
  MyDrawer({super.key});
  final TextEditingController incomeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      surfaceTintColor: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: incomeController,
                decoration: InputDecoration(
                  hintText: 'Please enter your income',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.001),
            InkWell(
              onTap: () {
                ref
                    .watch(incomePorvider.notifier)
                    .updateIncome(double.parse(incomeController.text.trim()));
                // ignore: avoid_print
                print(ref.watch(incomePorvider).income);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal[300],
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal[300],
                ),
                child: Center(
                  child: Text(
                    'S E T T I N G S',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            FirebaseAuth.instance.signOut();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignInPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'confirm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      title: Text(
                        'Logging out..',
                        style: TextStyle(fontSize: 20),
                      ),
                      content: Text('Are you sure you want to log out?'),
                    );
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal[300],
                ),
                child: Center(
                  child: Text(
                    'L O G  O U T',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ThemeCard(),
          ],
        ),
      ),
    );
  }
}
