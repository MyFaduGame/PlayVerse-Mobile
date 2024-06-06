//Third Party Imports
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

//Local Imports
import 'package:playverse/utils/toast_bar.dart';

// Initialize Firebase
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
//sample
User? get user => _auth.currentUser;

// Email/Password Authentication
Future<({String? email, String? password})> signUpWithEmailPassword(
    String email, String password, String userName) async {
  try {
    final UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    developer.log(credential.toString(), name: 'credentials');
    if (credential.user != null) {
      return (email: 'success', password: 'success');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return (email: null, password: "Password is too Weak!");
    } else if (e.code == 'invalid-email') {
      return (email: "Email is Invalid!", password: null);
    } else if (e.code == 'wrong-password') {
      return (email: "Password is so Wrong!", password: null);
    } else if (e.code == 'email-already-in-use') {
      return (email: "Email is already in use!", password: null);
    } else {
      showCustomToast(e.code);
    }
  } catch (e) {
    showCustomToast(e.toString());
  }
  return (email: null, password: null);
}

//Email Password Authentication
Future<({String? email, String? password})> signInWithEmailPassword(
    String email, String password) async {
  String returnText = '';
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    developer.log("app is comming here also", name: "sample new");
    developer.log('comming here', name: "smaple");
    returnText = '';
    if (credential.user != null) {
      developer.log(credential.toString(), name: 'credentials');
      return (email: 'success', password: 'success');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      returnText = 'There is no User Regarding this Email! Please Register';
      return (email: returnText, password: null);
    } else if (e.code == 'wrong-password') {
      returnText = 'This is Wrong Password';
      return (email: null, password: returnText);
    } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      returnText = 'Invalid Login Credentials';
      return (email: returnText, password: returnText);
    } else {
      showCustomToast(e.code);
    }
  } catch (e) {
    showCustomToast(e.toString());
  }
  return (email: null, password: null);
}

// Google Authentication
Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    return await _auth.signInWithCredential(credential);
  } catch (e) {
    developer.log(e.toString(), name: 'random');
    return null;
  }
}

// Facebook Authentication -> Have to add on next Sprint
// Future<UserCredential?> signInWithFacebook() async {
//   try {
//     final LoginResult loginResult = await FacebookAuth.instance.login();
//     if (loginResult.accessToken != null) {
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(loginResult.accessToken!.token);
//       return await _auth.signInWithCredential(facebookAuthCredential);
//     }
//   } catch (e) {
//     print("Error signing in with Facebook: $e");
//   }
//   return null;
// }

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

//Apple Authentication
Future<UserCredential> signInWithApple() async {
  try {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  } catch (e) {
    return Future.error(e);
  }
}

//Sign Out
Future signOut() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await _auth.signOut();
  await googleSignIn.currentUser?.clearAuthCache();
  await googleSignIn.signOut();
  // await googleSignIn.disconnect();
  // await FirebaseAuth.instance.signOut();

  developer.log("SignOut and cleaned Prefrences", name: "SignOut");
}

String emailText = '';
Future<({String? email})> resetPassword(String email) async {
  await _auth.sendPasswordResetEmail(email: email).then((value) {
    showCustomToast("Email Sent to your mail");
    emailText = 'success';
  }).catchError((e) {
    showCustomToast(e.toString());
    emailText = 'Error';
  });
  return (email: emailText);
}
