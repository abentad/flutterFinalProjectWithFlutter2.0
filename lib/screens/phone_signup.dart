import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medebir/provider/current_user.dart';
import 'package:medebir/screens/home_screen.dart';
import 'package:medebir/screens/phone_otp_verify_screen.dart';
import 'package:provider/provider.dart';

class PhoneSignUpScreen extends StatefulWidget {
  @override
  _PhoneSignUpScreenState createState() => _PhoneSignUpScreenState();
}

class _PhoneSignUpScreenState extends State<PhoneSignUpScreen> {
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phone',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: 20.0),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[600],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
                      //
                      String _resultString = await _currentUser.verifyPhone(_phoneController.text.trim().toString());
                      if (_resultString == "success") {
                        Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => HomeScreen()), (route) => false);
                      } else if (_resultString == "error") {
                        Navigator.of(context)
                            .pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => PhoneVerificationScreen()), (route) => false);
                      }
                      //
                    },
                    height: 45.0,
                    minWidth: 150.0,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
