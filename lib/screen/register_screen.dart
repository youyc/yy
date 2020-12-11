import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register_Screen extends StatefulWidget {
  @override
  Register_Screen_State createState() => Register_Screen_State();
}

class Register_Screen_State extends State<Register_Screen> {
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  //key for currentstate, it is used for the email & password input validator
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Form(
            key: _form_key,
            child: Container(
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
                          child: TextFormField(
                            controller: _email_controller,
                            keyboardType: TextInputType.emailAddress,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill your email'),
                              EmailValidator(errorText: 'Invalid email format'),
                            ]),
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
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _password_controller,
                            obscureText: true,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill password'),
                              MinLengthValidator(5,
                                  errorText:
                                      'Password must be longer than 4 letters'),
                            ]),
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
                              onPressed: () {
                                //if the 2 input are corect, process this
                                if (_form_key.currentState.validate()) {
                                  print(_email_controller.text);
                                  print(_password_controller.text);
                                }
                                // if the any input is failed, process this
                                else {
                                  print('failed');
                                }
                              },
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
                        GestureDetector(
                          //onTap: () => Navigator.of(context).,
                          child: Text(
                            'No account yet? Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
