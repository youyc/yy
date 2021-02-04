import 'package:flutter/material.dart';
import 'package:yy/global_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:yy/screen/cat_detail_screen.dart';

class Home_Screen extends StatefulWidget {
  @override
  Home_Screen_State createState() => Home_Screen_State();
}

class Home_Screen_State extends State<Home_Screen> {
  Global_State _global_key = Global_State.instance;
  int _cat_list_size;
  int _cat_selected_index;

  void _load_cat() async {
    http.post(
      'http://icebeary.com/hope4cat/load_cat.php',
      body: {
        "email": _global_key.user_list[0]["email"],
      },
    ).then((res) {
      if (res.body == 'nodata') {
        print('no data');
      } else {
        var cats_jscode = json.decode(res.body);
        _global_key.cat_list = cats_jscode['cats'];
        _cat_list_size = _global_key.cat_list.length;
        print(_cat_list_size);
        //print(res.body);
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
    //print(_cat_list_size);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text(
            "Hope 4 Cat",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: _cat_list_size == null
            ? Container(
                // color: Colors.amber[100],
                )
            : Container(
                // color: Colors.amber[100],
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: _cat_list_size,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      int _nav_index = 0;
                      _global_key.selected_index = index;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Cat_Detail_Screen(_nav_index),
                        ),
                      );
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //   "/CatDetailScreen",
                      //   (route) => true,
                      //);
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
                            height: 270,
                            child: Column(
                              children: [
                                Container(
                                  child: Image.network(
                                    "http://icebeary.com/hope4cat_image/${_global_key.cat_list[index]['image']}",
                                    height: 170,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //book title
                                Text(
                                  "${_global_key.cat_list[index]["publisher"]}",
                                  //_global_key.cat_list[index]['cattitle'].toString(),
                                  textAlign: TextAlign.center,
                                  // overflow: TextOverflow.ellipsis,
                                  // softWrap: false,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //author
                                Text(
                                  "${_global_key.cat_list[index]["email"]}",
                                  //'Author: ${_global_key.cat_list[index]['author'].toString()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${_global_key.cat_list[index]["fee"]}",
                                  //'RM ${_global_key.cat_list[index]['price'].toString()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
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
          if (index == 0 && _global_key.navigation_bar_index != 0) {
            Navigator.of(context).pushReplacementNamed("/HomeScreen");
          } else if (index == 0 && _global_key.navigation_bar_index == 0) {
            _load_cat();
          } else if (index == 1)
            Navigator.of(context).pushReplacementNamed("/UploadCatScreen");
          else if (index == 2)
            Navigator.of(context).pushReplacementNamed("/PostedScreen");
          else if (index == 3)
            Navigator.of(context).pushReplacementNamed("/ProfileScreen");
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
