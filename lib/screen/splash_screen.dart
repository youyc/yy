import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Splash_Screen extends StatefulWidget {
  @override
  Splash_Screen_State createState() => Splash_Screen_State();
}

class Splash_Screen_State extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        Navigator.of(context).pushReplacementNamed("/LoginScreen");
        print('navigation');
        //.pushReplacement("/LoginScreen", (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: _screen_height,
        width: _screen_width,
        color: Colors.blue,
        child: Column(
          children: [
            SizedBox(height: (_screen_height / 2) - 30),
            Text(
              'Hello World',
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 50),
            CollectionSlideTransition(
              repeat: false,
              children: <Widget>[
                Icon(Icons.android),
                Icon(Icons.apps),
                Icon(Icons.announcement),
                Icon(Icons.announcement),
                Icon(Icons.announcement),
                Icon(Icons.announcement),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
