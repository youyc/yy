import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login_Screen extends StatefulWidget {
  @override
  Login_Screen_State createState() => Login_Screen_State();
}

class Login_Screen_State extends State<Login_Screen> {
  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    TextEditingController _email_controller = TextEditingController();
    TextEditingController _password_controller = TextEditingController();

    String _email = "";
    String _password = "";
    //GlobalKey<FormState> form_key = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        //Form(
        //key: form_key,
        //child: Container(
        child: Column(
          children: [
            //upperpart
            Container(
              height: _screen_height / 3,
              color: Colors.amber,
            ),
            //lowerpart
            Container(
              height: _screen_height - (_screen_height / 3),
              color: Colors.green,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 90,
                    color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: _email_controller,
                      keyboardType: TextInputType.emailAddress,
                      // autovalidate: true,
                      // validator: (String value) {
                      //   if (value.isEmpty) return "Please Enter Email";
                      // },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        labelText: 'Enter Email',
                        labelStyle:
                            TextStyle(fontSize: 22, color: Colors.black),
                        errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _password_controller,
                      obscureText: true,
                      // autovalidate: true,
                      // validator: (String value) {
                      //   if (value.isEmpty) return "Please Enter Password";
                      // },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        labelText: 'Enter Password',
                        labelStyle:
                            TextStyle(fontSize: 22, color: Colors.black),
                        errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 70,
                    color: Colors.amber,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //),
    );
  }
}
