import 'package:expenses_tracker/features/auth/presentation/pages/sign_in_page.dart';
import 'package:expenses_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:expenses_tracker/features/expenses/presentation/pages/home_page.dart';
import 'package:expenses_tracker/firebase_options.dart';
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
      home: FirebaseAuth.instance.currentUser != null
          ? HomePage()
          : SignInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
