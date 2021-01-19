import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yy/global_state.dart';

class Cat_Detail_Screen extends StatefulWidget {
  int index;
  Cat_Detail_Screen(this.index);
  @override
  _Cat_Detail_Screen_State createState() => _Cat_Detail_Screen_State(index);
}

class _Cat_Detail_Screen_State extends State<Cat_Detail_Screen> {
  int index;
  _Cat_Detail_Screen_State(this.index);
  Global_State _global_key = Global_State.instance;
  List list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (index == 0) {
      list = _global_key.cat_list;
      print("size ${_global_key.cat_list.length}");
    } else if (index == 2) {
      list = _global_key.posted_cat_list;
      print("size ${_global_key.posted_cat_list.length}");
    } else if (index == 3) {
      list = _global_key.adopted_cat_list;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                //upperpart
                Container(
                  height: _screen_height / 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        //color: Colors.amber,
                        height: 150,
                        width: 210,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                            "http://icebeary.com/hope4cat_image/${list[_global_key.selected_index]['image']}"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                //lowerpart
                Container(
                  //height: _screen_height - (_screen_height / 3.6),
                  color: Colors.amberAccent,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        //height: 90,
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text("Publisher"),
                              ),
                              Text(
                                  "${list[_global_key.selected_index]["publisher"]}"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        //height: 90,
                        // color: Colors.green,
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text("Cat Gender"),
                            ),
                            Text(
                                "${list[_global_key.selected_index]["gender"]}"),
                          ],
                        ),
                      ),
                      Container(
                        //height: 90,
                        // color: Colors.green,
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text("Fee"),
                            ),
                            Text("${list[_global_key.selected_index]["fee"]}"),
                          ],
                        ),
                      ),
                      Container(
                        //height: 35,
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text("Location"),
                            ),
                            Text("Location"),
                          ],
                        ),
                      ),
                      Container(
                        //height: 200,
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text("Description"),
                            ),
                            Text(
                                "${list[_global_key.selected_index]["description"]}"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 0, 35, 25),
                        child: Container(
                          child: SizedBox(
                            height: 100,
                            width: 130,
                            child: index != 0
                                ? Container()
                                : RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () {
                                      _adopt_cat();
                                    },
                                    child: Text(
                                      "Adopt",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.deepOrange[400],
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
        ),
      ),
    );
  }

  _adopt_cat() async {
    String _email = _global_key.user_list[0]["email"];
    String _catid = list[_global_key.selected_index]["catid"];
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Adopting Cat...");
    await pr.show();
    http.post("https://icebeary.com/hope4cat/adopt_cat.php", body: {
      "email": _email,
      "catid": _catid,
    }).then((res) {
      print(res.body);
      if (res.body == "failed") {
        Toast.show(
          "Adopting failed",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "Adopting success",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        Navigator.of(context).pop();
        // user_list_size = _global_key.user_list.length;
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }
}
