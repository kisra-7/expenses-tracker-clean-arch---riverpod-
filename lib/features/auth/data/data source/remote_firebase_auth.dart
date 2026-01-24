import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RemoteFirebaseAuth {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  RemoteFirebaseAuth(this._auth, this._googleSignIn);

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      // ignore: unnecessary_nullable_for_final_variable_declarations
      final GoogleSignInAccount? googleAccount = await _googleSignIn
          .authenticate();

      if (googleAccount == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          googleAccount.authentication;
      final cred = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      await _auth.signInWithCredential(cred);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
