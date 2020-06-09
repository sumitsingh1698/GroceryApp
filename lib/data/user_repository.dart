import 'dart:convert';

import 'package:GroceryApp/models/user_detail.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity/connectivity.dart';
import "package:firebase_auth/firebase_auth.dart";

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final UserDetail userDetail;

  UserRepository({FirebaseAuth firebaseAuth, UserDetail userDetail})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        userDetail = userDetail ?? UserDetail();

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<AuthResult> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<FirebaseUser> getUser() async {
    var user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<void> getDetails() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getUserDetail',
    );
    await callable.call().then((value) {
      print("data ${value.data['data']['values']}");
      userDetail.setUid = value.data['data']['id'];
      userDetail.setEmail = value.data['data']['values']['email'];
      userDetail.setFname = value.data['data']['values']['fname'];
      userDetail.setLname = value.data['data']['values']['lname'];
      userDetail.setCart = value.data['data']['values']['cart'];
      userDetail.setCreateDate = value.data['data']['values']['createdDate']['date'];

      userDetail.setHno = value.data['data']['values']['address']['hno'];
      userDetail.setFloor = value.data['data']['values']['address']['floor'];
      userDetail.setAddress = value.data['data']['values']['address']['address'];
      userDetail.setLandmark = value.data['data']['values']['address']['landmark'];
      userDetail.setPincode = value.data['data']['values']['address']['pincode'];

    });
  }

  Future<void> updatePersonalDetails(String email,String fname,String lname) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'upadateUserPersonalDetail',
    );
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        'email': email,
        'fname': fname,
        'lname': lname,
      },
    );
    print("update persnal success : ${result.data}");
  }
   Future<void> updateAddressDetails(String hno,String floor,String address,String landmark, String pincode) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'upadateUserAddressDetail',
    );
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
      'hno' : hno,
      'floor' : floor,
      'address' : address,
      'landmark' : landmark,
      'pincode' : pincode,
       },
    );
    print("update address success : ${result.data}");
  }
  Future<bool> checkConnectivity() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
   return true;
 } else if (connectivityResult == ConnectivityResult.wifi) {
  return true;
 }
 return false;
 }

}
