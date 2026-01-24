import 'package:expenses_tracker/features/auth/domain/repositroy/auth_repository.dart';

class SignIn {
  final AuthRepositrory _repo;
  SignIn(this._repo);

  Future<void> call(String email, String password) {
    return _repo.signInWithEmailAndPassword(email, password);
  }
}
