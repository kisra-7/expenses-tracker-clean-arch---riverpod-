// lib/features/auth/presentation/pages/sign_in_page.dart
import 'package:expenses_tracker/features/auth/presentation/controlllers/auth_controllers.dart';
import 'package:expenses_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:expenses_tracker/features/expenses/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_up_page.dart';
// import your HomePage here

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});

  final emailCon = TextEditingController();
  final passCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: authAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (e, _) {
          return Center(child: Text('Error: $e'));
        },
        data: (_) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailCon,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passCon,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                InkWell(
                  onTap: () async {
                    await controller.signInWithEmailAndPassword(
                      emailCon.text.trim(),
                      passCon.text.trim(),
                    );
                    if (ref.read(firebaseAuthProvider).currentUser != null) {
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.tealAccent,
                    ),
                    child: const Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () async {
                    await controller.signInWithGoogle();
                    if (ref.read(firebaseAuthProvider).currentUser != null) {
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ),
                      );
                    }
                  },
                  child: const Text('Sign in with Google'),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dont have an account? '),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpPage()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
