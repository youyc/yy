import 'dart:collection';
import 'dart:io';
// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yy/global_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yy/screen/cat_detail_screen.dart';

class Profile_Screen extends StatefulWidget {
  @override
  Profile_Screen_State createState() => Profile_Screen_State();
}

class Profile_Screen_State extends State<Profile_Screen> {
  Global_State _global_key = Global_State.instance;
  int _adopted_cat_list_size;
  int _adopted_cat_selected_index;

  void _load_cat() async {
    http.post(
      'http://icebeary.com/hope4cat/load_adopted_cat.php',
      body: {
        "email": _global_key.user_list[0]["email"],
      },
    ).then((res) {
      if (res.body == 'nodata') {
        print('no data');
      } else {
        var cats_jscode = json.decode(res.body);
        _global_key.adopted_cat_list = cats_jscode['cats'];
        _adopted_cat_list_size = _global_key.adopted_cat_list.length;
        print(_adopted_cat_list_size);
        // Toast.show(
        //   "${res.body}",
        //   context,
        //   duration: 4,
        //   gravity: Toast.BOTTOM,
        // );
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load_cat();
    print(_adopted_cat_list_size);
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.deepOrange,
        //   title: Text(
        //     "Hope 4 Cat",
        //     style: TextStyle(fontSize: 30),
        //   ),
        // ),
        body: Container(
          child: Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                //upper part
                height: _screen_height / 3.4,
                color: Colors.amberAccent,
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Container(
                        //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: _screen_width / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          'assets/images/logo.png',
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          //edit name
                          Container(
                            child: Text(
                              "${_global_key.user_list[0]['name']}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          //edit email
                          Container(
                            child: Text(
                              "${_global_key.user_list[0]['email']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${_global_key.user_list[0]['phone']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/MapScreen',
                                    (Route<dynamic> route) => true);
                                // Navigator.of(context)
                                //     .pushReplacementNamed("/MapScreen");
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.amber[700],
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "My Pets",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Container(
              //       width: _screen_width / 2,
              //       child: Text(
              //         "Posted",
              //         style: TextStyle(fontSize: 18),
              //       ),
              //     ),
              //     Container(
              //       width: _screen_width / 2,
              //       child: Text(
              //         "Adopted",
              //         style: TextStyle(fontSize: 18),
              //       ),
              //     ),
              //   ],
              // ),

              //lower part
              _adopted_cat_list_size == null
                  ? Expanded(
                      child: Container(
                          // color: Colors.amber[100],
                          ),
                    )
                  : Expanded(
                      child: Container(
                        // color: Colors.amber[100],
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.59,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              int _nav_index = 3;
                              _global_key.selected_index = index;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Cat_Detail_Screen(_nav_index),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white),
                                color: Colors.amberAccent[100],
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 5,
                                //     blurRadius: 2,
                                //     offset: Offset(0, 2), // changes position of shadow
                                //   ),
                                // ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    //height: 200,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Image.network(
                                            "http://icebeary.com/hope4cat_image/${_global_key.adopted_cat_list[index]['image']}",
                                            height: 150,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 3,
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
                          itemCount: _adopted_cat_list_size,
                        ),
                      ),
                    ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  exitCode;
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                color: Colors.deepOrange[400],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          children: [
            _build_bottom_navigation_bar_item(
              index: 0,
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              title: "Home",
            ),
            _build_bottom_navigation_bar_item(
              index: 1,
              icon: Icon(
                Icons.publish,
                size: 30,
              ),
              title: "Upload",
            ),
            _build_bottom_navigation_bar_item(
              index: 2,
              icon: Icon(
                Icons.done,
                size: 30,
              ),
              title: "Posted",
            ),
            _build_bottom_navigation_bar_item(
              index: 3,
              icon: Icon(
                Icons.person_pin,
                size: 30,
              ),
              title: "Account",
            ),
          ],
        ),
      ),
    );
  }

  //customised bottom navigation bar item
  Widget _build_bottom_navigation_bar_item(
      {int index, Icon icon, String title}) {
    return GestureDetector(
      onTap: () => setState(
        () {
          _global_key.navigation_bar_index = index;
          //print(index); //check index
          if (index == 0)
            Navigator.of(context).pushReplacementNamed("/HomeScreen");
          else if (index == 1)
            Navigator.of(context).pushReplacementNamed("/UploadCatScreen");
          else if (index == 2)
            Navigator.of(context).pushReplacementNamed("/PostedScreen");
          else if (index == 3) {
            _load_cat();
          }
        },
      ),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          gradient: _global_key.navigation_bar_index == index
              ? LinearGradient(
                  colors: [
                    Colors.yellow.withOpacity(0.9),
                    Colors.yellow.withOpacity(0.2),
                    Colors.yellow.withOpacity(0.01),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
        ),
        child: Column(
          children: [
            icon,
            Text(title),
          ],
        ),
      ),
    );
  }
}
