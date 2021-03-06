import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  String _uid;
  String _email;

  String get getUid => _uid;
  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String onStartUp() {
    String retval = "error";
    try {
      User _firebaseUser = _auth.currentUser;
      _uid = _firebaseUser.uid;
      _email = _firebaseUser.email;
      retval = "success";
    } catch (e) {
      print(e);
    }
    return retval;
  }

  //signs up user using email and password
  Future<String> signUpUserWithEmail(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (_userCredential.user != null) {
        retVal = "success";
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }

  //logins user using email and password
  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_userCredential.user != null) {
        _uid = _userCredential.user.uid;
        _email = _userCredential.user.email;
        retVal = "success";
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }

  //login user with google
  Future<String> loginUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      GoogleSignInAccount _googleUserAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUserAccount.authentication;
      final AuthCredential _credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

      UserCredential _userCredential =
          await _auth.signInWithCredential(_credential);
      if (_userCredential.user != null) {
        _uid = _userCredential.user.uid;
        _email = _userCredential.user.email;
        retVal = "success";
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retval = "error";
    try {
      await _auth.signOut();
      _uid = null;
      _email = null;
      retval = "success";
    } catch (e) {
      print(e);
    }
    return retval;
  }
}
