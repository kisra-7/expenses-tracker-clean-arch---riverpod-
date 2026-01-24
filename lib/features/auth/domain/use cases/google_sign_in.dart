import 'package:expenses_tracker/features/auth/domain/repositroy/auth_repository.dart';

class RemoteGoogleSignIn {
  final AuthRepositrory _repo;
  RemoteGoogleSignIn(this._repo);

  Future<void> call() {
    return _repo.signInWithGoogle();
  }
}
