import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _googleAuth = GoogleSignIn();
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> googleSignIn() async {
    try {
      final googleUser = await _googleAuth.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken == null) return;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _googleAuth.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isUserAuth() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user != null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
