import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/LoginScreen": (BuildContext context) => Login_Screen(),
        "/RegisterScreen": (BuildContext context) => Register_Screen(),
      },
      home: Splash_Screen(),
    );
  }
}
