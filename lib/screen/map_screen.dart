import 'package:yy/global_state.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_Screen extends StatefulWidget {
  @override
  Map_Screen_State createState() => Map_Screen_State();
}

class Map_Screen_State extends State<Map_Screen> {
  Global_State _global_key = Global_State.instance;
  String _latitude = null;
  String _longitude = null;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center = LatLng(6.4676929, 100.5067673);
  LatLng _lastMapPosition = _center;
  Set<Marker> _markers = {};
  //MapType _currentMapType = MapType.normal;
  var _addressLine;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() async {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "$_lastMapPosition",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        draggable: true,
      ));
      _latitude = _lastMapPosition.latitude.toStringAsFixed(6);
      _longitude = _lastMapPosition.longitude.toStringAsFixed(6);
      _getUserLocation();
    });
  }

  //translate latitude and longitude into address
  _getUserLocation() async {
    _markers.forEach((value) async {
      final coordinates =
          Coordinates(value.position.latitude, value.position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var address = addresses.first;
      _addressLine = address.addressLine;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onAddMarkerButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: screen_height / 2,
                      width: screen_width - 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 17.0,
                        ),
                        mapType: MapType.normal,
                        markers: _markers,
                        onCameraMove: _onCameraMove,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                          child: FloatingActionButton(
                            onPressed: _onAddMarkerButtonPressed,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.blueGrey[700],
                            child: const Icon(Icons.add_location, size: 30.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    width: (screen_width / 2) - 20,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          color: Colors.deepPurple,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Latitude",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          color: Colors.deepPurple[400],
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${_lastMapPosition.latitude.toStringAsFixed(6)}",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: (screen_width / 2) - 20,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          color: Colors.deepPurple,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Longitude",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          color: Colors.deepPurple[400],
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${_lastMapPosition.longitude.toStringAsFixed(6)}",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
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
            Container(
              margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 100,
                    color: Colors.deepPurple,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: screen_width - 130,
                    color: Colors.deepPurple[400],
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      '${_addressLine}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 30, 0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  _global_key.latitude = _latitude;
                  _global_key.longitude = _longitude;
                  print(_global_key.latitude);
                  print(_global_key.longitude);
                  Navigator.pop(context);
                },
                child: Text(
                  "Confirm Location",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                color: Colors.deepOrange[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
