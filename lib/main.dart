import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medebir/provider/current_user.dart';
import 'package:medebir/screens/root_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //for status bar color change
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   // status bar color
  //   statusBarColor: Colors.black,
  //   statusBarIconBrightness: Brightness.light,
  //   statusBarBrightness: Brightness.light,
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
        ),
        themeMode: ThemeMode.dark,
        home: RootScreen(),
      ),
    );
  }
}
