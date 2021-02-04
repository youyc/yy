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
  TextEditingController _comment_controller = TextEditingController();
  int index;
  _Cat_Detail_Screen_State(this.index);
  Global_State _global_key = Global_State.instance;
  List list;

  List _comment_list;
  int _comment_list_size;

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
    setState(() {
      _load_comment();
    });
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
                  // height: _screen_height - (_screen_height / 3.6),
                  color: Colors.amberAccent,
                  child: Column(
                    children: [
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
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
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
                    ],
                  ),
                ),
                //forum part
                Text("forum"),
                Card(
                  child: _comments(),
                ),

                //comment part
                Container(
                  child: TextField(
                    controller: _comment_controller,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 20,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      icon: Icon(
                        Icons.chat,
                        color: Colors.blue,
                      ),
                      hintText: "Write a comment...",
                      suffixIcon: GestureDetector(
                        onTap: _comment_controller.text.isEmpty == true
                            ? null
                            : _upload_comment,
                        child: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          width: _screen_width,
          padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
          child: index != 0
              ? Container()
              : RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    setState(() {
                      _load_comment();
                    });

                    //_adopt_cat();
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

  //stop at here
  void _load_comment() async {
    String _catid = list[_global_key.selected_index]["catid"];
    http.post(
      'http://icebeary.com/hope4cat/load_comment.php',
      body: {
        "catid": _catid,
      },
    ).then((res) {
      if (res.body == 'nodata') {
        print('no data');
      } else {
        var cats_jscode = json.decode(res.body);
        _comment_list = cats_jscode['comments'];
        _comment_list_size = _comment_list.length;
        print(_comment_list_size);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _upload_comment() async {
    String _catid = list[_global_key.selected_index]["catid"];
    String _name = _global_key.user_list[0]["name"];
    String _comment = _comment_controller.text;
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Uploading Comment...");
    await pr.show();
    http.post("https://icebeary.com/hope4cat/upload_comment.php", body: {
      "catid": _catid,
      "name": _name,
      "comment": _comment,
    }).then((res) {
      print(res.body);
      if (res.body == "failed") {
        Toast.show(
          "Upload comment failed",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "Upload comment success",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        _comment_controller.clear();
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  //previous comments part
  Widget _comments() {
    return _comment_list_size == null
        ? Container(
            height: 0,
          )
        : Container(
            height: 265,
            child: ListView.builder(
              //need change
              itemCount: _comment_list_size,
              itemBuilder: (context, index) => Container(
                color: Colors.green,
                child: ListTile(
                  title: Text("${_comment_list[index]["name"]}"),
                  subtitle: Text("${_comment_list[index]["comment"]}"),
                ),
              ),
            ),
          );
  }

  Widget _forum() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          // //previous comments part
          // _comment_list_size == null
          //     ? Container()
          //     : Container(
          //         height: 200,
          //         padding: EdgeInsets.all(10),
          //         child: ListView.builder(
          //           //need change
          //           itemCount: _comment_list_size,
          //           itemBuilder: (context, index) => Container(
          //             color: Colors.green,
          //             child: ListTile(
          //               title: Text("${_comment_list[index]["name"]}"),
          //               subtitle: Text("${_comment_list[index]["comment"]}"),
          //             ),
          //           ),
          //         ),
          //       ),
          //add new comment part
          Container(
            //color: Colors.green,
            child: TextField(
              controller: _comment_controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 20,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                icon: Icon(
                  Icons.chat,
                  color: Colors.blue,
                ),
                hintText: "Write a comment...",
                suffixIcon: GestureDetector(
                  onTap: _comment_controller.text.isEmpty == true
                      ? null
                      : _upload_comment,
                  child: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
