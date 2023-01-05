import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/User/Service/Firebase_Auth.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/editformfild.dart';
import 'package:plant_app/constant/image_sourcesheet.dart';
import 'package:plant_app/utils/Text_utils.dart';
import 'package:uuid/uuid.dart';
import '../login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart'; //TODO:

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextUtils _textUtils = TextUtils();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _Usernamecontroller = TextEditingController();
  TextEditingController _Phonenumbercontroller = TextEditingController();
  TextEditingController _Passwordcontroller = TextEditingController();
  String username = "";
  String password = "";
  String usenameerror = "";
  String passworderror = "";
  bool hidepassword = true;
  String? imageFile;
  bool postUpload = false;
  DateTime dateTime = DateTime.now();
  Random random = Random();
  String dropdownValue = dropdownList.first;

  void _getImage(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) {
                if (image != null) {
                  setState(() {
                    imageFile = image.toString();
                  });
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryColor,
      body: Form(
        key: _globalKey,
        child: Stack(
          children: [
            Container(
              // margin: EdgeInsets.only(top: size.height * 0.1),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: size.width * 0.6,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Getting Started",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create an account to continued",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0, top: 30),
                  width: size.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 0, blurRadius: 10)
                      ],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: Colors.white),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Center(
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              // icon: const Icon(Icons.arrow_downward),
                              // elevation: 16,
                              style: const TextStyle(color: primaryColor , fontWeight: FontWeight.bold),
                              underline: Container(
                                height: 0,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                        
                              // isExpanded: true,
                              items: dropdownList
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: Text(
                                "Username or E-Mail",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                            EditTextfild(
                              controller: _Usernamecontroller,
                              validator: (val) {
                                if (val!.isEmpty || val == "" || val == " ") {
                                  return "Plases Enter E-mail Adderss";
                                }
                              },
                              hint: "Username",
                              onsaved: (val) {
                                username = val!;
                              },
                              prefixicon: const Icon(Icons.person),
                              // suffixicon: Icon(
                              //   Icons.done,
                              //   color: colors.green,
                              // ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: Text(
                                "Phone Number",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                            EditTextfild(
                              controller: _Phonenumbercontroller,
                              validator: (val) {
                                if (val!.isEmpty || val == "" || val == " ") {
                                  return "Plases Enter Phone Number";
                                }
                              },
                              number: 10,
                              keybordtype: TextInputType.number,
                              hint: "Phone Number",
                              prefixicon: const Icon(Icons.phone),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                "Password",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                            EditTextfild(
                              controller: _Passwordcontroller,
                              validator: (val) {
                                if (val!.isEmpty || val == "" || val == " ") {
                                  return "Plases Enter Password";
                                }
                              },
                              hint: "Password",
                              onsaved: (val) {
                                password = val!;
                              },
                              prefixicon: Icon(
                                Icons.lock_outlined,
                              ),
                              suffixicon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidepassword = !hidepassword;
                                  });
                                },
                                icon: Icon(
                                  hidepassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: primaryColor,
                                ),
                              ),
                              passwordshow: hidepassword,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        
                        Container(
                          margin: EdgeInsets.only(bottom: 0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (_globalKey.currentState!.validate()) {
                                    _globalKey.currentState!.save();

                                    if (imageFile != null) {
                                      User? user = await FirebaseHelper.Auth
                                          .RagisterwithEmailandPassword(
                                              email: username,
                                              password: password);

                                      FirebaseQuery.firebaseQuery
                                          .insertuser(user!.uid, {
                                        "email": username,
                                        "password": password,
                                        "post": 0,
                                        "profile_pic": imageFile.toString(),
                                        "name": username,
                                        "phone": _Phonenumbercontroller.text,
                                        "verified": false,
                                        "status": "Offline",
                                        "is_public": true,
                                        "show_active_status": true,
                                        "push_notification": true,
                                        "join_time": DateTime.now(),
                                        "type":dropdownValue,
                                        "address": {
                                          "latitude": 0.0,
                                          "longitude": 0.0,
                                          "country": "",
                                          "state": "",
                                          "city": "",
                                          "addreess": "",
                                          "sublocality": "",
                                          "zipCode": "",
                                        },
                                        "save_address": {
                                          "s_latitude": 0.0,
                                          "s_longitude": 0.0,
                                          "s_country": "",
                                          "s_state": "",
                                          "s_city": "",
                                          "s_addreess": "",
                                          "s_sublocality": "",
                                          "s_zipCode": "",
                                        },
                                        "rewards": {
                                          "total_reward": 4,
                                          "first": {
                                            "first_discount":
                                                "${random.nextInt(50)} % OFF",
                                            "first_open": false,
                                            "first_date": DateTime.now()
                                          },
                                          "second": {
                                            "second_discount":
                                                "${random.nextInt(50)} % OFF",
                                            "second_open": false,
                                            "second_date": DateTime.now()
                                          },
                                          "third": {
                                            "third_discount":
                                                "${random.nextInt(50)} % OFF",
                                            "third_open": false,
                                            "third_date": DateTime.now()
                                          },
                                          "fourth": {
                                            "fourth_discount":
                                                "${random.nextInt(50)} % OFF",
                                            "fourth_open": false,
                                            "fourth_date": DateTime.now()
                                          },
                                        },
                                      });
                                      if (user != null) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()),
                                                (route) => false);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Select Image Plase"),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                    //   switch (e.code) {
                                    //     case "The account already exists for that email":
                                    //       setState(() {
                                    //         usenameerror =
                                    //             "The account already exists for that email";
                                    //       });
                                    //       break;
                                    //     case "weak-password":
                                    //       Fluttertoast.showToast(
                                    //         msg: 'Your Password is Week',
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //       );
                                    //       break;
                                    //     default:
                                    //       Fluttertoast.showToast(
                                    //         msg: e.code,
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //       );
                                    //   }
                                    // }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: primaryColor),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("I have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                          (route) => false);
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.26,
              left: 0,
              right: 0,
              child: GestureDetector(
                child: Center(
                  child: imageFile == null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xFF0C9969),
                          child: SvgPicture.asset(
                              "assets/icons/camera_icon.svg",
                              width: 40,
                              height: 40,
                              color: Colors.white),
                        )
                      : Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: primaryColor),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(imageFile.toString(),
                                fit: BoxFit.cover, frameBuilder: (context,
                                    child, frame, wasSynchronouslyLoaded) {
                              return child;
                            }, loadingBuilder:
                                    (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white30,
                                  ),
                                );
                              }
                            }),
                          ),
                        ),
                ),
                onTap: () {
                  /// Get profile image
                  _getImage(context);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

List<String> dropdownList = ["User", "Marchant"];
