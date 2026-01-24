import 'package:expenses_tracker/features/auth/domain/repositroy/auth_repository.dart';

class SignUp {
  final AuthRepositrory _repo;
  SignUp(this._repo);

  Future<void> call(String email, String password) {
    return _repo.signUpWithEmailAndPassword(email, password);
  }
}
