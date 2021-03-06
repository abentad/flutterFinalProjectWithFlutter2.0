import 'package:flutter/material.dart';
import 'package:medebir/provider/current_user.dart';
import 'package:medebir/screens/home_screen.dart';
import 'package:medebir/screens/login_choice_screen.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  loggedIn,
  notLoggedIn,
}

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //get the state, check current user, set AuthStatus based on state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = _currentUser.onStartUp();
    if (_returnString == "success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        _retVal = LoginChoiseScreen();
        break;
      case AuthStatus.loggedIn:
        _retVal = HomeScreen();
        break;
      default:
    }
    return _retVal;
  }
}
