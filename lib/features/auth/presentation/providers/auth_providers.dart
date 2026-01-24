import 'package:expenses_tracker/features/auth/data/data%20source/remote_firebase_auth.dart';
import 'package:expenses_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expenses_tracker/features/auth/domain/repositroy/auth_repository.dart';
import 'package:expenses_tracker/features/auth/domain/use%20cases/google_sign_in.dart';
import 'package:expenses_tracker/features/auth/domain/use%20cases/sign_in.dart';
import 'package:expenses_tracker/features/auth/domain/use%20cases/sign_out.dart';
import 'package:expenses_tracker/features/auth/domain/use%20cases/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);
final googleSignInProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn.instance,
);

final remoteFirebaseAuthProvider = Provider<RemoteFirebaseAuth>((ref) {
  return RemoteFirebaseAuth(
    ref.read(firebaseAuthProvider),
    ref.read(googleSignInProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepositrory>((ref) {
  return AuthRepositoryImpl(ref.read(remoteFirebaseAuthProvider));
});

final signInUseCaseProvider = Provider<SignIn>((ref) {
  return SignIn(ref.read(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUp>((ref) {
  return SignUp(ref.read(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider((ref) {
  return SignOut(ref.read(authRepositoryProvider));
});

final remoteGooglesignInUseCaseProvider = Provider<RemoteGoogleSignIn>((ref) {
  return RemoteGoogleSignIn(ref.read(authRepositoryProvider));
});
