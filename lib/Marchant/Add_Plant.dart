import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Toast.dart';
import 'package:plant_app/constant/image_sourcesheet.dart';
import 'package:plant_app/utils/Text_utils.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mrpcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quanitycontroller = TextEditingController();
  TextEditingController detailscontroller = TextEditingController();
  TextEditingController netquanitycontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  TextEditingController manufacturercontroller = TextEditingController();
  TextUtils _textUtils = TextUtils();
  String imageFile = "";
  String imageFile1 = "";
  String imageFile2 = "";
  String imageFile3 = "";
  bool _imageload = false;
  bool sun = false;
  bool small = false;
  bool air = false;
  bool water = false;
  bool uploadPlant = false;
  List imagelist = [];

  void _getImage(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ImageSourceSheet(
              name: 'Add_Plant',
              onImageSelected: (image) {
                if (image != null) {
                  setState(() {
                    imageFile = image.toString();
                    imagelist.add(imageFile);
                  });
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  void _getImage1(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ImageSourceSheet(
              name: 'Add_Plant',
              onImageSelected: (image) {
                if (image != null) {
                  setState(() {
                    imageFile1 = image.toString();
                    imagelist.add(imageFile1);
                  });
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  void _getImage2(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ImageSourceSheet(
              name: 'Add_Plant',
              onImageSelected: (image) {
                if (image != null) {
                  setState(() {
                    imageFile2 = image.toString();
                    imagelist.add(imageFile2);
                  });
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  void _getImage3(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ImageSourceSheet(
              name: 'Add_Plant',
              onImageSelected: (image) {
                if (image != null) {
                  setState(() {
                    imageFile3 = image.toString();
                    imagelist.add(imageFile3);
                  });
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  bool bostProducts = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // _getImage();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //  _getImage(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService().User,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userdata = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: size.height * 0.34,
                      width: size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _getImage(context);
                                },
                                child: Container(
                                  height: size.height * 0.16,
                                  width: size.width / 2.5,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 3),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: imageFile.isEmpty
                                        ? Image.network(
                                            "https://static.thenounproject.com/png/187803-200.png",
                                          )
                                        : Image.network(imageFile.toString(),
                                            fit: BoxFit.cover, frameBuilder:
                                                (context, child, frame,
                                                    wasSynchronouslyLoaded) {
                                            return child;
                                          }, loadingBuilder: (context, child,
                                                loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryColor
                                                      .withOpacity(0.4),
                                                ),
                                              );
                                            }
                                          }),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _getImage1(context);
                                },
                                child: Container(
                                  height: size.height * 0.16,
                                  width: size.width / 2.5,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 3),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: imageFile1.isEmpty
                                        ? Image.network(
                                            "https://static.thenounproject.com/png/187803-200.png",
                                          )
                                        : Image.network(imageFile1.toString(),
                                            fit: BoxFit.cover, frameBuilder:
                                                (context, child, frame,
                                                    wasSynchronouslyLoaded) {
                                            return child;
                                          }, loadingBuilder: (context, child,
                                                loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryColor
                                                      .withOpacity(0.4),
                                                ),
                                              );
                                            }
                                          }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _getImage2(context);
                                },
                                child: Container(
                                  height: size.height * 0.16,
                                  width: size.width / 2.5,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 3),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: imageFile2.isEmpty
                                        ? Image.network(
                                            "https://static.thenounproject.com/png/187803-200.png",
                                          )
                                        : Image.network(imageFile2.toString(),
                                            fit: BoxFit.cover, frameBuilder:
                                                (context, child, frame,
                                                    wasSynchronouslyLoaded) {
                                            return child;
                                          }, loadingBuilder: (context, child,
                                                loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryColor
                                                      .withOpacity(0.4),
                                                ),
                                              );
                                            }
                                          }),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _getImage3(context);
                                },
                                child: Container(
                                  height: size.height * 0.16,
                                  width: size.width / 2.5,
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 3),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: imageFile3.isEmpty
                                        ? Image.network(
                                            "https://static.thenounproject.com/png/187803-200.png",
                                          )
                                        : Image.network(imageFile3.toString(),
                                            fit: BoxFit.cover, frameBuilder:
                                                (context, child, frame,
                                                    wasSynchronouslyLoaded) {
                                            return child;
                                          }, loadingBuilder: (context, child,
                                                loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryColor
                                                      .withOpacity(0.4),
                                                ),
                                              );
                                            }
                                          }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: namecontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Plant Name",
                                  labelText: "Plant Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 10,),
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: mrpcontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Plant Mrp",
                                  labelText: "Plant MRP",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: pricecontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Plant Selling Price",
                                  labelText: "Selling Price",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 10,),
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: quanitycontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Plant Quantity",
                                  labelText: "Plant Quantity",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: weightcontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Plant Weight Price",
                                  labelText: "Plant Weight",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 10,),
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: netquanitycontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Plant Net Quantity",
                                  labelText: "Plant Net Quantity",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: countrycontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Contry Name",
                                  labelText: "Contry Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 10,),
                            Container(
                              width: size.width / 2.3,
                              height: 45,
                              child: TextFormField(
                                controller: manufacturercontroller,
                                decoration: InputDecoration(
                                  hintText: "Enter Manufacturer Name",
                                  labelText: "Manufacturer Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  // checkColor: Colors.white,
                                  // fillColor: MaterialStateProperty.resolveWith(pri),
                                  value: sun,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      sun = value!;
                                    });
                                  },
                                ),
                                _textUtils.bold16("Sun", Colors.black)
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  // checkColor: Colors.white,
                                  // fillColor: MaterialStateProperty.resolveWith(pri),
                                  value: small,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      small = value!;
                                    });
                                  },
                                ),
                                _textUtils.bold16("Small", Colors.black)
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  // checkColor: Colors.white,
                                  // fillColor: MaterialStateProperty.resolveWith(pri),
                                  value: air,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      air = value!;
                                    });
                                  },
                                ),
                                _textUtils.bold16("Air", Colors.black)
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  // checkColor: Colors.white,
                                  // fillColor: MaterialStateProperty.resolveWith(pri),
                                  value: water,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      water = value!;
                                    });
                                  },
                                ),
                                _textUtils.bold16("Water", Colors.black)
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          height: 160,
                          child: TextFormField(
                            controller: detailscontroller,
                            textInputAction: TextInputAction.go,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: primaryColor),
                            maxLines: 10,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                hintText: "Plant Details.....",
                                labelText: "Plant Details",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        ListTile(
                          title: _textUtils.bold16(
                              "Boost Your Product", Colors.black),
                          trailing: !Platform.isAndroid
                              ? Switch(
                                  value: bostProducts,
                                  onChanged: (val) {
                                    setState(() {
                                      bostProducts = val;
                                    });
                                  })
                              : CupertinoSwitch(
                                  value: bostProducts,
                                  onChanged: (val) {
                                    setState(() {
                                      bostProducts = val;
                                    });
                                  }),
                        ),
                      ],
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: uploadPlant
                            ? null
                            : () async {
                                setState(() {
                                  uploadPlant = true;
                                });
                                if (imageFile.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Select Image Please"),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    uploadPlant = false;
                                  });
                                } else if (namecontroller.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Enter Plant Name"),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    uploadPlant = false;
                                  });
                                } else if (mrpcontroller.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Enter Plant MRP"),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    uploadPlant = false;
                                  });
                                } else if (pricecontroller.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Enter Plant Price"),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    uploadPlant = false;
                                  });
                                } else if (quanitycontroller.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Enter Plant Quantity"),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    uploadPlant = false;
                                  });
                                } else if (detailscontroller.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Enter Plant Details"),
                                    backgroundColor: Colors.red,
                                  ));
                                  setState(() {
                                    uploadPlant = false;
                                  });
                                } else {
                                  setState(() {
                                    uploadPlant = true;
                                  });
                                  Timer(Duration(seconds: 3), () async {
                                    await FirebaseQuery.firebaseQuery
                                        .uploadPlant({
                                      'plant_image': imagelist,
                                      'plant_name': namecontroller.text,
                                      'plant_mrp': mrpcontroller.text,
                                      'plant_price': pricecontroller.text,
                                      'plant_quantity': quanitycontroller.text,
                                      'plant_sun': sun,
                                      'plant_small': small,
                                      'plant_air': air,
                                      'plant_water': water,
                                      'plant_detail': detailscontroller.text,
                                      'plant_date': DateTime.now(),
                                      'net_quantity': netquanitycontroller.text,
                                      'weight': weightcontroller.text,
                                      'country': countrycontroller.text,
                                      'manufacturer':
                                          manufacturercontroller.text,
                                      'marchant_id': userdata!.uid,
                                      'marchant_name': userdata.name,
                                      "boost": bostProducts,
                                      "marchant_image":userdata.profileUrl,
                                    });
                                    CustomToast().successToast(
                                        context: context,
                                        text: "Plant Upload Successfully");
                                    setState(() {
                                      uploadPlant = false;
                                    });
                                    imagelist.clear();
                                    namecontroller.clear();
                                    pricecontroller.clear();
                                    mrpcontroller.clear();
                                    detailscontroller.clear();
                                    quanitycontroller.clear();
                                    netquanitycontroller.clear();
                                    countrycontroller.clear();
                                    manufacturercontroller.clear();
                                    weightcontroller.clear();
                                    imageFile = "";
                                    imageFile1 = "";
                                    imageFile2 = "";
                                    imageFile3 = "";
                                    sun = false;
                                    air = false;
                                    small = false;
                                    water = false;
                                    bostProducts = false;
                                  });
                                }
                              },
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: uploadPlant
                                ? primaryColor.withOpacity(0.4)
                                : primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: uploadPlant
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white60,
                                          strokeWidth: 2,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    _textUtils.bold16(
                                        "Sending To QC...", Colors.white)
                                  ],
                                )
                              : Center(
                                  child: _textUtils.bold16(
                                      "Send To QC", Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
