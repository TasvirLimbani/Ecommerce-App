import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';

class MyAddresse extends StatefulWidget {
  const MyAddresse({Key? key}) : super(key: key);

  @override
  State<MyAddresse> createState() => _MyAddresseState();
}

class _MyAddresseState extends State<MyAddresse> with TickerProviderStateMixin{
  Placemark placemark = Placemark();
  bool datasave = false;
  bool currentlocation = false;
  String sublocality = "";
  String zipCode = "";
  String state = "";
  String city = "";
  String addreess = "";
  String country = "";
  late AnimationController _maleController;
  late Animation<Offset> _LeftAnimation;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  LatLng? _center;
  bool _isLoading = false;

  Position? currentLocation;
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    setState(() {
      _isLoading = true;
    });
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation!.latitude, currentLocation!.longitude);
    });

    print('center ${_center!.latitude} ${_center!.longitude}');

    markers.add(Marker(
      markerId: MarkerId(1.toString()),
      position: LatLng(_center!.latitude, _center!.longitude),
      infoWindow: InfoWindow(
        title: 'Your Location',
        snippet: '${_center!.latitude} and ${_center!.longitude}',
      ),
    ));
    List<Placemark> res =
        // await placemarkFromCoordinates(44.500000,	-89.500000);
        await placemarkFromCoordinates(_center!.latitude, _center!.longitude);
    setState(() {
      placemark = res[0];
    });
    setState(() {
      datasave = true;
      currentlocation = true;
      country = placemark.country!;
      addreess =
          "${placemark.street}, ${placemark.thoroughfare}, ${placemark.subLocality}";
      city = "${placemark.locality}";
      state = "${placemark.administrativeArea}";
      zipCode = "${placemark.postalCode}";
      sublocality = "${placemark.subLocality}";
    });
    FirebaseQuery.firebaseQuery.updateUser({
      "address": {
        "latitude": _center!.latitude,
        "longitude": _center!.longitude,
        "country": country,
        "state": state,
        "city": city,
        "addreess": addreess,
        "sublocality": sublocality,
        "zipCode": zipCode,
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  final Completer<GoogleMapController> _controller = Completer();
  int mapIndex = 1;
  Set<Marker> markers = {};
  List<LatLng> polylineCoordinates = [];
  final TextUtils _textUtils = TextUtils();

  @override
  void initState() {
    super.initState();
    _determinePosition();
    locateUser();
    getUserLocation();
     _maleController =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat();
    _LeftAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
            parent: _maleController, curve: Curves.fastOutSlowIn));
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _maleController.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(children: [
            // SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              height: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: _center == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                        markers: markers,
                        mapType: MapType.values[mapIndex],
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_center!.latitude, _center!.longitude),
                          zoom: 14.4746,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        zoomControlsEnabled: false,
                        polylines: {
                          Polyline(
                              polylineId: const PolylineId("route"),
                              points: polylineCoordinates,
                              color: Colors.red,
                              width: 5,
                              onTap: () {}),
                        },
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.my_location,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      _textUtils.bold16(country, Colors.black),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.my_location,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      _textUtils.bold16(state, Colors.black),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.my_location,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      _textUtils.bold16(city, Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              // height: 40,
              width: size.width,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: primaryColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  const Icon(Icons.where_to_vote_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  _textUtils.bold16(addreess, Colors.black),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      const Icon(Icons.pin_drop_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      _textUtils.bold16(sublocality, Colors.black),
                    ],
                  ),
                ),
                Container(
                  // height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      const Icon(Icons.password),
                      const SizedBox(
                        width: 10,
                      ),
                      _textUtils.bold16(zipCode, Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseQuery.firebaseQuery.updateUser({
                    "save_address": {
                      "s_latitude": _center!.latitude,
                      "s_longitude": _center!.longitude,
                      "s_country": country,
                      "s_state": state,
                      "s_city": city,
                      "s_addreess": addreess,
                      "s_sublocality": sublocality,
                      "s_zipCode": zipCode,
                    }
                  });
                },
                child: _textUtils.bold14("Save Address", Colors.white)),
                const SizedBox(height: 10,),
            StreamBuilder<UserData>(
                stream: DatabaseService().User,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return data!.s_state.isEmpty
                        ? Container()
                        : Card(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              child: Column(children: [
                                const SizedBox(height: 10,),
                                _textUtils.bold14("========== Save Address ==========", Colors.grey),
                                const SizedBox(height: 10,),
                                _textUtils.bold16(
                                    data.s_addreess, Colors.black),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,

                                      children: [
                                        _textUtils.bold16(
                                    "${data.s_sublocality} - ", Colors.black),
                                    // SizedBox(width: 10,),
                                    _textUtils.bold16(
                                    data.s_zipCode, Colors.black),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 3),
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //         width: 2, color: primaryColor),
                                      //     borderRadius:
                                      //         BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.my_location,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          _textUtils.bold16(
                                              data.s_city, Colors.black),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 3),
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //         width: 2, color: primaryColor),
                                      //     borderRadius:
                                      //         BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.my_location,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          _textUtils.bold16(
                                              data.s_state, Colors.black),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 3),
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //         width: 2, color: primaryColor),
                                      //     borderRadius:
                                      //         BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.my_location,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          _textUtils.bold16(
                                              data.s_country, Colors.black),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                              ]),
                            ),
                          );
                  }
                  return Container();
                }),
          Expanded(child: Container()),
             SlideTransition(
                          position: _LeftAnimation,
                          child: Row(
                            children: [
                              SizedBox(width: 10),

                              _textUtils.bold12("Your Location is Store in firebase for your safety....".toUpperCase(),Colors.grey.shade400),
                            ],
                          ),
                        ),
         
          ]);
  }
}
