import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medebir/provider/current_user.dart';
import 'package:medebir/screens/home_screen.dart';
import 'package:medebir/screens/login_choice_screen.dart';
import 'package:provider/provider.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  hintText: "OTP",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              MaterialButton(
                onPressed: () async {
                  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
                  //
                  String _resultString = await _currentUser.verifyOTP(_otpController.text.trim().toString());
                  if (_resultString == "success") {
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => HomeScreen()), (route) => false);
                  } else if (_resultString == "error") {
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => LoginChoiseScreen()), (route) => false);
                  }
                },
                child: Text('verify'),
                minWidth: double.infinity,
                color: Colors.teal,
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
