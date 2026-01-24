import 'package:expenses_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);

class AuthController extends AsyncNotifier {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final signIn = ref.read(signInUseCaseProvider);
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await signIn(email, password);
      return;
    });
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    final signUp = ref.read(signUpUseCaseProvider);
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await signUp(email, password);
      return;
    });
  }

  Future<void> signInWithGoogle() async {
    final signInGoogle = ref.read(remoteGooglesignInUseCaseProvider);
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await signInGoogle();
      return;
    });
  }

  Future<void> signOut() async {
    final signOut = ref.read(signOutUseCaseProvider);
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await signOut();
      return;
    });
  }
}
