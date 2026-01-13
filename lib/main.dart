import 'package:expenses_tracker/firebase_options.dart';
import 'package:expenses_tracker/pages/add_expense_page.dart';
import 'package:expenses_tracker/pages/home_page.dart';
import 'package:expenses_tracker/pages/sign_in_page.dart';
import 'package:expenses_tracker/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeProvider).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: FirebaseAuth.instance.currentUser == null
          ? SignInPage()
          : AddExpensePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
