import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/Marchant/HomeScreen.dart';
import 'package:plant_app/User/Service/Firebase_Auth.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/screens/home/home_screen.dart';
import 'package:plant_app/User/screens/signup/signup.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Toast.dart';
import 'package:plant_app/constant/editformfild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _Usernamecontroller = TextEditingController();
  TextEditingController _Passwordcontroller = TextEditingController();

  bool hidepassword = true;

  bool home = false;

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
                    height: size.height * 0.10,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: size.width * 0.6,
                    ),
                  ),
                  Text(
                    "Let's Sign You In",
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
                    "Welcome back ,You've been missed",
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
                  padding: const EdgeInsets.only(bottom: 0, top: 15),
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
                              keybordtype: TextInputType.emailAddress,

                              hint: "Username",
                              prefixicon: const Icon(Icons.person),
                              // suffixicon: Icon(
                              //   Icons.done,
                              //   color: Colors.green,
                              // ),
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text("Forgot Password?")),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.g_mobiledata),
                              label: Text("Google"),
                              onPressed: () async {
                                // FirebaseQuery.firebaseQuery.Account({
                                //   'name': userCredential.user!.email,
                                //   'image': userCredential.user!.photoURL,
                                //   'nickname': userCredential.user!.displayName,
                                //   'uid': userCredential.user!.uid,
                                // });
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (route) => false);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.facebook),
                              label: Text("Facebook"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (_globalKey.currentState!.validate()) {
                                    _globalKey.currentState!.save();
                                    try {
                                      User? user = await FirebaseHelper.Auth
                                          .LoginwithEmailandPassword(
                                              email: _Usernamecontroller.text,
                                              password:
                                                  _Passwordcontroller.text);

                                      if (user != null) {
                                        setState(() {
                                          DatabaseService()
                                              .getUser(uid: user.uid)
                                              .forEach((element) {
                                            element.type == "Marchant"
                                                ? Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MarchantHome()),
                                                        (route) => false)
                                                : Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeScreen()),
                                                        (route) => false);
                                          });
                                        });
                                        FirebaseAuth.instance.userChanges();
                                        FirebaseAuth.instance.currentUser;
                                        FirebaseAuth.instance.idTokenChanges();
                                        CustomToast().successToast(
                                            context: context,
                                            text: "Login Successfuly");
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        home = false;
                                      });
                                      print(e.code);
                                      switch (e.code) {
                                        case "user-not-found":
                                          setState(() {
                                            home = false;
                                          });
                                          CustomToast().errorToast(
                                              context: context,
                                              text:
                                                  "No user found for that email.");

                                          break;
                                        case "wrong-password":
                                          setState(() {
                                            home = false;
                                          });
                                          CustomToast().errorToast(
                                              context: context,
                                              text:
                                                  "Your email or password is incorrect");
                                          break;
                                        default:
                                          setState(() {
                                            home = false;
                                          });
                                          CustomToast().errorToast(
                                              context: context,
                                              text: "${e.message}");
                                      }
                                    }
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
                                      "Sign In",
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
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()),
                                          (route) => false);
                                    },
                                    child: Text(
                                      "Sign Up",
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
          ],
        ),
      ),
    ));
  }
}
