import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static late User _user;

  User get user => _user;

  static Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      if (userCredential.user == null) {
        print('ERROR AUTH');
        return;
      }

      _user = userCredential.user!;
      log("Signed in anonymously as user: ${_user.uid}");
    } catch (e) {
      print("Failed to sign in anonymously: $e");
    }
  }
}
