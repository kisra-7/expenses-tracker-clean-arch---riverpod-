import 'package:expenses_tracker/features/auth/data/data%20source/remote_firebase_auth.dart';
import 'package:expenses_tracker/features/auth/domain/repositroy/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepositrory {
  final RemoteFirebaseAuth _remote;

  AuthRepositoryImpl(this._remote);

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _remote.signInWithEmail(email, password);
  }

  @override
  Future<void> signInWithGoogle() {
    return _remote.signInWithGoogle();
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) {
    return _remote.signUpWithEmail(email, password);
  }

  @override
  Future<void> signOut() async {
    return _remote.signOut();
  }
}
