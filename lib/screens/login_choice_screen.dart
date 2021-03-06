import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medebir/provider/current_user.dart';
import 'package:medebir/screens/email_login.dart';
import 'package:medebir/screens/email_signUp.dart';
import 'package:medebir/screens/home_screen.dart';
import 'package:medebir/screens/phone_signup.dart';
import 'package:provider/provider.dart';

class LoginChoiseScreen extends StatefulWidget {
  @override
  _LoginChoiseScreenState createState() => _LoginChoiseScreenState();
}

class _LoginChoiseScreenState extends State<LoginChoiseScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    void _loginUserWithGoogle(BuildContext context) async {
      CurrentUser _currentUser =
          Provider.of<CurrentUser>(context, listen: false);
      try {
        var _result = await _currentUser.loginUserWithGoogle();
        if (_result == "success") {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_result.toString()),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: deviceHeight,
          width: deviceWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.black],
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: deviceHeight * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.9)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 150.0,
                left: 50,
                right: 50,
                child: SvgPicture.asset(
                  'assets/icon.svg',
                  height: 50.0,
                  width: 50.0,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  Spacer(flex: 12),
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Millions of Books. \nFree On Medebir.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => EmailSignUpScreen()),
                        );
                      },
                      height: 50.0,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      color: Color(0xFF1db954),
                      child: Text(
                        'Sign up free',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => PhoneSignUpScreen()),
                        );
                      },
                      height: 50.0,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.phone, color: Colors.green),
                          SizedBox(width: deviceWidth * 0.15),
                          Text(
                            'Continue with Phone',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: MaterialButton(
                      onPressed: () {
                        _loginUserWithGoogle(context);
                      },
                      height: 50.0,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.google, color: Colors.red),
                          SizedBox(width: deviceWidth * 0.15),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => EmailLoginScreen()),
                      );
                    },
                    child: Text('Log in',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Color(0xff29a19c)
//Color(0xffa3f7bf)
