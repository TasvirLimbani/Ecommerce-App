import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/address_model.dart';
import 'package:plant_app/User/models/plant.dart';
import 'package:plant_app/User/screens/Drawer/My_Cards.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';

class OrderAddress extends StatefulWidget {
  final PlantModel plantdata;
  const OrderAddress({Key? key, required this.plantdata}) : super(key: key);

  @override
  State<OrderAddress> createState() => _OrderAddressState();
}

class _OrderAddressState extends State<OrderAddress> {
  final TextUtils _textUtils = TextUtils();
  Set selected = {};
  Set selected1 = {};
  int currentindex = -1;
  bool vlaue = false;
  AddressModel? addressModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textUtils.bold18("Select Address", Colors.black),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: AddressDialog());
                    },
                  );
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: primaryColor),
                    child: _textUtils.bold16("Add Address", Colors.white)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<List<AddressModel>>(
                stream: DatabaseService().addresslist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final addressdata = snapshot.data;
                    return addressdata!.isEmpty
                        ? Center(
                            child:
                                _textUtils.bold14("No Address", Colors.black),
                          )
                        : ListView.builder(
                            itemCount: addressdata.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentindex = index;
                                    addressModel = addressdata[index];
                                  });
                                  log(addressModel.toString());
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: currentindex == index
                                              ? primaryColor
                                              : Colors.white,
                                          width: 2),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(left: 15),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: currentindex == index
                                                        ? primaryColor
                                                        : Colors.grey.shade600,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      _textUtils.bold14(
                                                        "${addressdata[index].address1},",
                                                        currentindex == index
                                                            ? primaryColor
                                                            : Colors
                                                                .grey.shade600,
                                                      ),
                                                      _textUtils.bold12(
                                                        "${addressdata[index].address2}, ${addressdata[index].city}, ${addressdata[index].state} - ${addressdata[index].zipcode}",
                                                        currentindex == index
                                                            ? primaryColor
                                                            : Colors
                                                                .grey.shade600,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Radio(
                                          groupValue: index,
                                          value: currentindex,
                                          onChanged: (val) {
                                            setState(() {
                                              currentindex = -1;
                                              currentindex = index;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          GestureDetector(
            onTap: () {
              currentindex == -1
                  ? null
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: _textUtils.bold18(
                              "My Cards & Wallet", Colors.white),
                          centerTitle: true,
                        ),
                        body: MyCards(
                          address: addressModel,
                          uid: widget.plantdata.marchant_id,
                          productimage: widget.plantdata.plant_Image,
                          productname: widget.plantdata.plant_Name,
                          name: widget.plantdata.marchant_name,
                          productId: widget.plantdata.uid,
                          image: widget.plantdata.marchant_image,
                          quantity: 1,
                          ammount: double.parse(widget.plantdata.plant_Price),
                          showBottombar: true,
                        ),
                      ),
                    ));
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentindex == -1
                      ? primaryColor.withOpacity(0.4)
                      : primaryColor),
              child: Center(
                child: _textUtils.bold18("Checkout", Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class AddressDialog extends StatefulWidget {
  const AddressDialog({Key? key}) : super(key: key);

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextUtils _textUtils = TextUtils();
  String sublocality = "";
  String zipCode = "";
  String state = "";
  String city = "";
  String addreess = "";
  String country = "";
  LatLng? _center;
  bool _isLoading = false;
  bool datasave = false;
  bool currentlocation = false;
  Placemark placemark = Placemark();

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

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Address",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: TextFormField(
              controller: textController1,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Address 1',
                hintText: 'Address 1',
                // hintStyle: FlutterFlowTheme.of(context).bodyText2,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF0000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF0000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: TextFormField(
              controller: textController2,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Address 2',
                hintText: 'Address 2',
                // hintStyle: FlutterFlowTheme.of(context).bodyText2,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF0000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF0000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: TextFormField(
              controller: textController3,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'City',
                // hintStyle: FlutterFlowTheme.of(context).bodyText2,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF0000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF0000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: TextFormField(
                    controller: textController4,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'State',
                      hintText: 'State',
                      // hintStyle: FlutterFlowTheme.of(context).bodyText2,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF0000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF0000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: TextFormField(
                    controller: textController5,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Zip code',
                      hintText: 'Zip code',
                      // hintStyle: FlutterFlowTheme.of(context).bodyText2,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF0000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF0000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    textController1.text = addreess;
                    textController2.text = sublocality;
                    textController3.text = city;
                    textController4.text = state;
                    textController5.text = zipCode;
                  });
                  log(textController1.text);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      _textUtils.bold14(
                        'Current',
                        Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (textController1.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: _textUtils.bold12(
                              "Enter Address 1", Colors.white),
                          backgroundColor: Colors.red),
                    );
                  } else if (textController1.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: _textUtils.bold12(
                              "Enter Address 2", Colors.white),
                          backgroundColor: Colors.red),
                    );
                  } else if (textController1.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              _textUtils.bold12("Enter City", Colors.white),
                          backgroundColor: Colors.red),
                    );
                  } else if (textController1.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              _textUtils.bold12("Enter State", Colors.white),
                          backgroundColor: Colors.red),
                    );
                  } else if (textController1.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              _textUtils.bold12("Enter Zipcode", Colors.white),
                          backgroundColor: Colors.red),
                    );
                  } else if (textController1.text.isNotEmpty &&
                      textController2.text.isNotEmpty &&
                      textController3.text.isNotEmpty &&
                      textController4.text.isNotEmpty &&
                      textController5.text.isNotEmpty) {
                    FirebaseQuery.firebaseQuery.addAddress({
                      'address1': textController1.text,
                      'address2': textController2.text,
                      'city': textController3.text,
                      'state': textController4.text,
                      'zipcode': textController5.text,
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      _textUtils.bold14('Save', Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
