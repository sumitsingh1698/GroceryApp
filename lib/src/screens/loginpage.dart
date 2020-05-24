import 'package:GroceryApp/src/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  bool _notVerfied = false;

  FirebaseUser _firebaseUser;
  String _status;

  AuthCredential _phoneAuthCredential;
  String _verificationId;
  int _code;

  @override
  void initState() {
    super.initState();
    _getFirebaseUser();
  }

  Future<void> _getFirebaseUser() async {
    this._firebaseUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      _status =
          (_firebaseUser == null) ? 'Not Logged In\n' : 'Already LoggedIn\n';
    });
  }

  Future<void> _submitPhoneNumber() async {
    String phoneNumber = "+91 " + _phoneNumberController.text.toString().trim();
    print(phoneNumber);

    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      AuthService().signin(phoneAuthCredential);
      print(phoneAuthCredential);
    }

    void verificationFailed(AuthException error) {
      print('verificationFailed');
      print(error.message);
      setState(() {
        _status += '$error\n';
      });
      print(error);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);
      // this._code = code;
      // print(code.toString());
      // setState(() {
      //   _status += 'Code Sent\n';
      // });
      setState(() {
        _notVerfied = true;
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      _submitPhoneNumber();
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
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
  }

  void _submitOTP() async {
    /// get the `smsCode` from the user
    String smsCode = _otpController.text.toString().trim();

    AuthService().signin(PhoneAuthProvider.getCredential(
        verificationId: this._verificationId, smsCode: smsCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Spacer(),
             
            ],
          ),
          SizedBox(height: 10),
          _notVerfied
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          hintText: 'OTP',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Spacer(),
                    // Expanded(
                    //   flex: 1,
                    //   child: MaterialButton(
                    //     onPressed: _submitOTP,
                    //     child: Text('Submit'),
                    //     color: Theme.of(context).accentColor,
                    //   ),
                    // ),
                  ],
                )
              : Container(),
          SizedBox(height: 20),
          MaterialButton(
            onPressed: () {
              if (_notVerfied == false) {
                print("here");
                _submitPhoneNumber();
              } else {
                print("there");
                _submitOTP();
              }
            },
            child: Text('Login'),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
