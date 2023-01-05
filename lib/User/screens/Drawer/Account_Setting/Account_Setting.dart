import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/User/Service/Firebase_Auth.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/User/screens/Drawer/Account_Setting/Send_Feedback.dart';
import 'package:plant_app/User/screens/login/login.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Toast.dart';
import 'package:plant_app/constant/editformfild.dart';
import 'package:plant_app/utils/Text_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  TextUtils _textUtils = TextUtils();
  DateFormat dateFormat = DateFormat('EEE, MMM d, ' 'y');
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<UserData>(
        stream: DatabaseService().User,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userdata = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: size.height * 0.18,
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColor.withOpacity(0.4)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(userdata!.profileUrl,
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _textUtils.bold18(userdata.name, Colors.black),
                                SizedBox(
                                  height: 5,
                                ),
                                _textUtils.bold12(
                                    "+91 ${userdata.Phone}", Colors.black54),
                                SizedBox(
                                  height: 5,
                                ),
                                _textUtils.bold12(
                                    "Join Date : ${dateFormat.format(userdata.joinTime!)}",
                                    Colors.black54),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //     bottom: -10,
                      //     right: 10,
                      //     child: Container(
                      //       width: 40,
                      //       height: 40,
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: primaryColor.withOpacity(0.6),
                      //           border:
                      //               Border.all(width: 4, color: Colors.white)),
                      //       child: Icon(Icons.edit),
                      //     )),
                    ],
                  ),
                  SizedBox(height: 15),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      // padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 15, right: 15),
                            leading: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                            ),
                            title: _textUtils.bold16("About", Colors.black),
                            subtitle: _textUtils.normal12(
                                "Learn more about Plant'App", Colors.grey),
                            trailing: const Icon(Icons.navigate_next_rounded),
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 15, right: 15),
                            leading: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Icon(
                                Icons.fingerprint,
                                color: Colors.white,
                              ),
                            ),
                            title: _textUtils.bold16("Privacy", Colors.black),
                            subtitle: _textUtils.normal12(
                                "Lock Plant'App to improve your privacy",
                                Colors.grey),
                            trailing: const Icon(Icons.navigate_next_rounded),
                          ),
                          Divider(
                            height: 0,
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeedBackScreen()));
                            },
                            contentPadding:
                                EdgeInsets.only(left: 15, right: 15),
                            leading: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ),
                            title: _textUtils.bold16(
                                "Send Feedback", Colors.black),
                            subtitle: _textUtils.normal12(
                                "Let us know how we can make Plant'App",
                                Colors.grey),
                            trailing: const Icon(Icons.navigate_next_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () async {
                        await FirebaseHelper.Auth.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                      contentPadding: EdgeInsets.only(left: 15, right: 15),
                      leading: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                      ),
                      title: _textUtils.bold16("Sign Out", Colors.black),
                      subtitle: _textUtils.normal12(
                          "Remove account from your device.", Colors.grey),
                      trailing: const Icon(Icons.navigate_next_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () async {
                        openAlertBox(userdata.password , userdata.email);
                      },
                      contentPadding: EdgeInsets.only(left: 15, right: 15),
                      leading: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      title: _textUtils.bold16("Delete Account", Colors.black),
                      subtitle: _textUtils.normal12(
                          "Your account delete permanently", Colors.grey),
                      trailing: const Icon(Icons.navigate_next_rounded),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  openAlertBox(String password,String email) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: _textUtils.bold16(
                      "Enter Your Password",
                      Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: EditTextfild(
                      controller: _passwordController,
                      hint: "Enter Password",
                      Border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_passwordController.text == password) {
                        CustomToast().successToast(
                            context: context,
                            text: "Your Account is Delete Suc");
                        await FirebaseHelper.Auth.logout();
                        await FirebaseHelper.Auth.deleteUser(email: email , password: password);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                        await FirebaseQuery.firebaseQuery.deleteUser();
                      }
                      else{
                        CustomToast().errorToast(context: context, text: "Password Is Wrong");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      ),
                      child: Text(
                        "Check Password",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
