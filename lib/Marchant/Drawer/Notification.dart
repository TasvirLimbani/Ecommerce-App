import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/constant/Toast.dart';
import 'package:plant_app/utils/Text_utils.dart';

class MarchntNotificationScreen extends StatefulWidget {
  const MarchntNotificationScreen({Key? key}) : super(key: key);

  @override
  State<MarchntNotificationScreen> createState() => _MarchntNotificationScreenState();
}

class _MarchntNotificationScreenState extends State<MarchntNotificationScreen> {
  TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DatabaseService().User,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userdata = snapshot.data;
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: _textUtils.bold16("Show Notification", Colors.black),
                    trailing: Platform.isAndroid
                        ? Switch(
                            value: userdata!.push_notification,
                            onChanged: (val) {
                              setState(() {
                                userdata.push_notification = val;
                                FirebaseQuery.firebaseQuery.updateUser({
                                  "push_notification": val,
                                });
                                CustomToast().successToast(
                                    context: context,
                                    text: val
                                        ? "Notification ON Successfully"
                                        : "Notification OFF Successfully");
                              });
                            })
                        : CupertinoSwitch(
                            value: userdata!.push_notification,
                            onChanged: (val) {
                              setState(() {
                                userdata.push_notification = val;
                                FirebaseQuery.firebaseQuery.updateUser({
                                  "push_notification": val,
                                });
                                CustomToast().successToast(
                                    context: context,
                                    text: val
                                        ? "Notification ON Successfully"
                                        : "Notification OFF Successfully");
                              });
                            }),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title:
                        _textUtils.bold16("Show Activity Status", Colors.black),
                    trailing: Platform.isAndroid
                        ? Switch(
                            value: userdata.show_active_status,
                            onChanged: (val) {
                              setState(() {
                                userdata.show_active_status = val;
                                FirebaseQuery.firebaseQuery.updateUser({
                                  "show_active_status": val,
                                });
                                CustomToast().successToast(
                                    context: context,
                                    text: val
                                        ? "Active Status ON Successfully"
                                        : "Active Status OFF Successfully");
                              });
                            })
                        : CupertinoSwitch(
                            value: userdata.show_active_status,
                            onChanged: (val) {
                              setState(() {
                                userdata.show_active_status = val;
                                FirebaseQuery.firebaseQuery.updateUser({
                                  "show_active_status": val,
                                });
                                CustomToast().successToast(
                                    context: context,
                                    text: val
                                        ? "Active Status ON Successfully"
                                        : "Active Status OFF Successfully");
                              });
                            }),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: _textUtils.bold16("Private account", Colors.black),
                    trailing: Platform.isAndroid
                        ? Switch(
                            value: userdata.is_public,
                            onChanged: (val) {
                              setState(() {
                                userdata.is_public = val;
                                FirebaseQuery.firebaseQuery.updateUser({
                                  "is_public": val,
                                });
                                CustomToast().successToast(
                                    context: context,
                                    text: val
                                        ? "Your Account Is PRIVATE"
                                        : "Your Account Is PUBLIC");
                              });
                            })
                        : CupertinoSwitch(
                            value: userdata.is_public,
                            onChanged: (val) {
                              setState(() {
                                userdata.is_public = val;
                                FirebaseQuery.firebaseQuery.updateUser({
                                  "is_public": val,
                                });
                                CustomToast().successToast(
                                    context: context,
                                    text: val
                                        ? "Your Account Is PRIVATE"
                                        : "Your Account Is PUBLIC");
                              });
                            }),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
