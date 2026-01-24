import 'package:expenses_tracker/features/auth/domain/repositroy/auth_repository.dart';

class SignOut {
  final AuthRepositrory _repo;
  SignOut(this._repo);

  Future<void> call() => _repo.signOut();
}
