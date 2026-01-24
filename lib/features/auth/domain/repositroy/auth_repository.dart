abstract class AuthRepositrory {
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {}

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {}

  Future<void> signInWithGoogle() async {}

  Future<void> signOut() async {}
}
