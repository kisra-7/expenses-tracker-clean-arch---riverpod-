import 'package:expenses_tracker/features/auth/presentation/controlllers/auth_controllers.dart';
import 'package:expenses_tracker/features/auth/presentation/pages/sign_in_page.dart';
import 'package:expenses_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
            onPressed: () async {
              await controller.signOut();
              if (ref.read(firebaseAuthProvider).currentUser == null) {
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
            icon: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
