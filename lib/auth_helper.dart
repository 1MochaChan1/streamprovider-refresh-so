import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Auth Helper Class
///
/// This class is used for handling Authentication operations. It is optional as
/// I like to keep similar operations at one place.
/// I am using Google Sign In because it's easy but it will work with any other
/// auth method Firebase Provides.

class AuthHelper {
  static final GoogleSignIn _gSignIn = GoogleSignIn();

  /// This is some redundant code to demonstrate how you can programmatically
  /// add values in the controller to update the StreamProvider.
  /// Although you would wanna create the controller at a place where you may
  /// be able to dispose it later.

  // Creating a StreamController that has a Stream which will return the `User?`
  static final StreamController<User?> currUserController =
      StreamController<User?>();

  // This function is called in the main method to make sure the stream of my
  // stream controller is listening to the changes when the auth state changes
  static init() async {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      currUserController.sink.add(event);
    });
  }

  // This is an optional method that you can use to add a User object programmatically
  // This value can be null.
  static clearUserProgrammatically({User? user}) {
    if (!currUserController.isClosed && !currUserController.isPaused) {
      currUserController.sink.add(user);
    }
  }

  static Future<UserCredential> googleSignIn() async {
    final GoogleSignInAccount? gUser = await _gSignIn.signIn();
    final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
    final gCreds = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);
    return await FirebaseAuth.instance.signInWithCredential(gCreds);
  }

  static Future<void> googleSignout() async {
    await _gSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
