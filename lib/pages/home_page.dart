import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/pages/expensses_page.dart';
import 'package:expenses_tracker/pages/sign_in_page.dart';
import 'package:expenses_tracker/providers/db_provider.dart';
import 'package:expenses_tracker/providers/image_provider.dart';
import 'package:expenses_tracker/widgets/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final id = const Uuid().v4();
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePro = ref.watch(imageProvider.notifier);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Add expenses'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (FirebaseAuth.instance.currentUser == null) {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignInPage();
                    },
                  ),
                );
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  imagePro.pickImage();
                },
                icon: Icon(Icons.camera_alt_outlined),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.teal[300],
                ),
                child: ref.watch(imageProvider).selectedImage != null
                    ? Image(
                        image: FileImage(
                          ref.watch(imageProvider).selectedImage!,
                        ),
                      )
                    : Text(
                        'please select an image',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),

              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hint: Text('title'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: discriptionController,
                decoration: InputDecoration(
                  hint: Text('disciption'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: costController,
                decoration: InputDecoration(
                  hint: Text('cost'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: colorController,
                decoration: InputDecoration(
                  hint: Text('color'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hint: Text('time'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  ref
                      .watch(dbProvider.notifier)
                      .upLoadExpenseToDb(
                        Expense(
                          id: id,
                          title: titleController.text.trim(),
                          description: discriptionController.text.trim(),
                          cost: double.parse(costController.text.trim()),
                          color: colorController.text.trim(),
                          date: DateTime.now(),
                        ),
                      );
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal[300],
                  ),
                  child: Center(
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
              InkWell(
                onTap: () {
                  ref.watch(dbProvider.notifier).getDataFromDb();
                  ref.watch(dbProvider.notifier).sumCosts();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ExpenssesPage();
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: 'hey',
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal[300],
                    ),
                    child: Center(
                      child: Text(
                        'Get',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
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

/**
 * 
 * ref
                      .watch(dbProvider.notifier)
                      .upLoadExpenseToDb(
                        Expense(
                          id: id,
                          title: titleController.text.trim(),
                          description: discriptionController.text.trim(),
                          cost: double.parse(costController.text.trim()),
                          color: colorController.text.trim(),
                          date: DateTime.now(),
                        ),
                      );
 */
