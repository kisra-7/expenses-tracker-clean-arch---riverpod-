// lib/features/auth/presentation/pages/sign_up_page.dart
import 'package:expenses_tracker/features/auth/presentation/controlllers/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import your HomePage here

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});

  final emailCon = TextEditingController();
  final passCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    ref.listen(authControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }

      final wasLoading = prev?.isLoading ?? false;
      final isSuccessNow = wasLoading && next.hasValue && !next.hasError;

      if (isSuccessNow && context.mounted) {
        // Navigator.pushReplacement(...HomePage)
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: authAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (e, _) => Center(child: Text('Error: $e')),
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
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                ElevatedButton(
                  onPressed: () => controller.signUpWithEmailAndPassword(
                    emailCon.text.trim(),
                    passCon.text.trim(),
                  ),
                  child: const Text('Sign UP'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
