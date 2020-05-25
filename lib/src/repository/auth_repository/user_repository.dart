import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {

  String verificationId;
  final FirebaseAuth _firebaseAuth;
  String status = "null";

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = FirebaseAuth.instance;

  Future<void> signin(AuthCredential phoneAuthCredential) async {
    try {
      await _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult authRes) {
        print(authRes.user);
      });
      print("SignedIn");
    } catch (e) {
      print(e.toString());
    }
  }

    Future<void> signout() async {
      try {
        // signout code
        await _firebaseAuth.signOut();
      } catch (e) {
        print(e.toString());
      }
    }

    Future<bool> isSignedIn() async {
      final currentUser = await _firebaseAuth.currentUser();
      return currentUser != null;
    }

    Future<FirebaseUser> getUser() async {
      return (await _firebaseAuth.currentUser());
    }

    Future<String> submitPhoneNumber(String phonenumber) async {
      String status = "null";
      String phoneNumber = "+91 " + phonenumber;
      print(phoneNumber);

      void verificationCompleted(AuthCredential phoneAuthCredential) {
        print('verificationCompleted');
        status = "verfied";

        signin(phoneAuthCredential);
        print(phoneAuthCredential);
      }

      void verificationFailed(AuthException error) {
        status = "unverfied";
        print('verificationFailed');
         
      }

      void codeSent(String verificationId, [int code]) {
        status = "codesent";
        print('codeSent');
        this.verificationId = verificationId;
       
      }

      void codeAutoRetrievalTimeout(String verificationId) {
        status = "timeout";
        
        print('codeAutoRetrievalTimeout');
        submitPhoneNumber(phoneNumber);
        print(verificationId);
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 10),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );

      return status;
    }

    Future<void> submitOTP(String otp) async {
      String smsCode = otp;
      try {
       await signin(PhoneAuthProvider.getCredential(
           verificationId: this.verificationId, smsCode: smsCode));
      } catch (e) { print(e); }
    }
  }

