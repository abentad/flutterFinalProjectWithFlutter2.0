import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  String _uid;
  String _email;

  String get getUid => _uid;
  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  //--------------------------on start up-------------------------------------------//
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
  ////////////////////////////////////////////////////////////////////////////////////

  //---------------------signs up user using email and password---------------------//
  Future<String> signUpUserWithEmail(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential _userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (_userCredential.user != null) {
        retVal = "success";
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }
  ////////////////////////////////////////////////////////////////////////////////////

  //----------------------logins user using email and password----------------------//
  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
  /////////////////////////////////////////////////////////////////////////////////////

  //-------------------------------login user with google----------------------------//
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
      GoogleSignInAuthentication _googleAuth = await _googleUserAccount.authentication;
      final AuthCredential _credential = GoogleAuthProvider.credential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

      UserCredential _userCredential = await _auth.signInWithCredential(_credential);
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
  ///////////////////////////////////////////////////////////////////////////////////////

  //-------------------------------Sign out-------------------------------------------//
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
  ///////////////////////////////////////////////////////////////////////////////////////

  //------------------------------------Phone Auth------------------------------------------------//

  // from medium
  var verificationId;
  Future<String> verifyPhone(String mobile) async {
    String _retVal = "error";
    var mobileToSend = mobile;
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            try {
              final UserCredential user = await _auth.signInWithCredential(phoneAuthCredential);
              final User currentUser = _auth.currentUser;
              print(user);
              if (currentUser.uid != "") {
                _uid = currentUser.uid;
                _retVal = "success";
              }
            } catch (e) {
              throw e;
            }
          },
          verificationFailed: (FirebaseAuthException exception) {
            throw exception;
          });
    } catch (e) {
      throw e;
    }
    return _retVal;
  }

  //
  Future<String> verifyOTP(String otp) async {
    String _retval = "error";
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      final User currentUser = _auth.currentUser;
      print(user);

      if (currentUser.uid != "") {
        _uid = currentUser.uid;
        _retval = "success";
      }
    } catch (e) {
      throw e;
    }
    return _retval;
  }

  ///////////////////////////////////////////////////////////////////////////////////////
}

//
//
// Future<String> signInWithPhone(String phoneNumber, BuildContext context) async {
//   String _retval = "error";
//   try {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // ANDROID ONLY!
//         // Sign the user in (or link) with the auto-generated credential
//         await _auth.signInWithCredential(credential);
//         _retval = "success";
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           _retval = 'The provided phone number is not valid.';
//         }
//         // Handle other errors
//       },
//       codeSent: (String verificationId, int resendToken) async {
//         // Update the UI - wait for the user to enter the SMS code
//         TextEditingController _smsCodeController = TextEditingController();
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) {
//             return AlertDialog(
//               title: Text("Enter the code"),
//               content: Column(
//                 children: [
//                   TextField(
//                     controller: _smsCodeController,
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   child: Text("confirm"),
//                   onPressed: () async {
//                     final code = _smsCodeController.text.trim();
//                     AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
//                     //same as above from here
//                     UserCredential result = await _auth.signInWithCredential(credential);
//                     User user = result.user;

//                     if (user != null) {
//                       _uid = user.uid;
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (builder) => HomeScreen(),
//                         ),
//                       );
//                     } else {
//                       print("error");
//                     }
//                   },
//                 ),
//               ],
//             );
//           },
//         );

//         String smsCode = 'xxxx';
//         // Create a PhoneAuthCredential with the code
//         PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
//         // Sign the user in (or link) with the credential
//         await _auth.signInWithCredential(phoneAuthCredential);
//         _retval = "success";
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-resolution timed out...
//         _retval = "Timeout";
//       },
//     );
//   } catch (e) {
//     print(e);
//   }
//   return _retval;
// }

//
//
//from medium
// Future<void> verifyPhone(String countryCode, String mobile) async {
//     var mobileToSend = mobile;
//     final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
//       this.verificationId = verId;
//     };
//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: mobileToSend,
//           codeAutoRetrievalTimeout: (String verId) {
//             //Starts the phone number verification process for the given phone number.
//             //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
//             this.verificationId = verId;
//           },
//           codeSent: smsOTPSent,
//           timeout: const Duration(
//             seconds: 120,
//           ),
//           verificationCompleted: (AuthCredential phoneAuthCredential) async {
//             try {
//               final UserCredential user = await _auth.signInWithCredential(phoneAuthCredential);
//               final User currentUser = _auth.currentUser;
//               print(user);
//               if (currentUser.uid != "") {
//                 _uid = currentUser.uid;
//               }
//             } catch (e) {
//               throw e;
//             }
//           },
//           verificationFailed: (FirebaseAuthException exception) {
//             throw exception;
//           });
//     } catch (e) {
//       throw e;
//     }
//   }

//   //
//   Future<void> verifyOTP(String otp) async {
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otp,
//       );
//       final UserCredential user = await _auth.signInWithCredential(credential);
//       final User currentUser = _auth.currentUser;
//       print(user);

//       if (currentUser.uid != "") {
//         _uid = currentUser.uid;
//       }
//     } catch (e) {
//       throw e;
//     }
//   }

//   //
//   showError(error) {
//     throw error.toString();
//   }
