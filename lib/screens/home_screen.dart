import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medebir/provider/current_user.dart';
import 'package:medebir/screens/root_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(icon: FaIcon(FontAwesomeIcons.bookmark), onPressed: () {}),
          IconButton(icon: FaIcon(FontAwesomeIcons.bell), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              onPressed: () async {
                CurrentUser _currentUser =
                    Provider.of<CurrentUser>(context, listen: false);
                String _resultString = await _currentUser.signOut();
                if (_resultString == "success") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => RootScreen()),
                    (route) => false,
                  );
                }
              },
              minWidth: double.infinity,
              height: 50.0,
              child: Text("Sign Out", style: TextStyle(color: Colors.white)),
              color: Colors.green,
            ),
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            //bottom Navigation bar
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 3),
                        blurRadius: 10.0),
                  ],
                ),
                padding: const EdgeInsets.only(bottom: 15, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.home, color: Colors.greenAccent, size: 28.0),
                        Text('Home'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.search, color: Colors.white, size: 28.0),
                        Text('Home'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite, color: Colors.white, size: 28.0),
                        Text('Home'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.settings, color: Colors.white, size: 28.0),
                        Text('Home'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //
            // Positioned(
            //   top: 0.0,
            //   child: Container(
            //     height: 20.0,
            //     width: double.infinity,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Icon(Icons.menu),
            //         TextField(),
            //         FaIcon(FontAwesomeIcons.bookmark),
            //         FaIcon(FontAwesomeIcons.bell),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

//
