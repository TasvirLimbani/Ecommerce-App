import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/Marchant/Drawer/Navigation.dart';
import 'package:plant_app/User/Service/Firebase_Auth.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/User/screens/Drawer/Navigator.dart';
import 'package:plant_app/User/screens/login/login.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/image_sourcesheet.dart';
import 'package:plant_app/utils/Text_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

bool androidSwitch = false;
bool iosSwitch = false;

class MarchantDrawer extends StatefulWidget {
  const MarchantDrawer({Key? key}) : super(key: key);

  @override
  State<MarchantDrawer> createState() => _MarchantDrawerState();
}

class _MarchantDrawerState extends State<MarchantDrawer> {
  TextUtils _textUtils = TextUtils();
  String? imageFile;
  bool _imageload = false;

  void _getImage(BuildContext context) async {
    setState(() {
      _imageload = true;
    });
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) {
                if (image != null) {
                  setState(() async {
                    await FirebaseQuery.firebaseQuery
                        .updateUser({"profile_pic": image.toString()});
                    imageFile = image.toString();
                    _imageload = false;
                  });
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
    setState(() {
      _imageload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: StreamBuilder<UserData>(
          stream: DatabaseService().User,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userdata = snapshot.data;
              return Column(children: [
                DrawerHeader(
                  decoration:
                      BoxDecoration(color: primaryColor.withOpacity(0.3)),
                  padding: EdgeInsets.zero,
                  child: Container(
                    // color: primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: _imageload
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white30,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.network(
                                            userdata!.profileUrl,
                                            fit: BoxFit.cover, frameBuilder:
                                                (context, child, frame,
                                                    wasSynchronouslyLoaded) {
                                          return child;
                                        }, loadingBuilder: (context, child,
                                                loadingProgress) {
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
                              Positioned(
                                bottom: 0,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    _getImage(context);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    // padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        color: primaryColor),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _textUtils.bold16(
                              "${userdata!.email}@gmail.com", Colors.black),
                          const SizedBox(
                            height: 5,
                          ),
                          _textUtils.bold12(
                              timeago.format(userdata.joinTime!), Colors.grey),
                          // SizedBox(height: 5,),
                        ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          )),
                      title: _textUtils.bold16("Account Setting", Colors.black),
                      trailing: const Icon(Icons.navigate_next_rounded),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MarchantNavigatorScreen(
                                name: "Account Setting")));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                          )),
                      title: _textUtils.bold16("Notifications", Colors.black),
                      trailing: const Icon(Icons.navigate_next_rounded),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MarchantNavigatorScreen(
                                name: "Notifications")));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    // ListTile(
                    //   leading: Container(
                    //       padding: const EdgeInsets.all(3),
                    //       decoration: BoxDecoration(
                    //           color: primaryColor,
                    //           borderRadius: BorderRadius.circular(5)),
                    //       child: const Icon(
                    //         Icons.shopping_cart,
                    //         color: Colors.white,
                    //       )),
                    //   title: _textUtils.bold16("Your Cart", Colors.black),
                    //   trailing: const Icon(Icons.navigate_next_rounded),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) =>
                    //             const NavigatorScreen(name: "Your Cart")));
                    //   },
                    // ),
                    // const Divider(
                    //   height: 0,
                    // ),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.storefront,
                            color: Colors.white,
                          )),
                      title: _textUtils.bold16("All Orders", Colors.black),
                      trailing: const Icon(Icons.navigate_next_rounded),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MarchantNavigatorScreen(
                                name: "All Orders")));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.payments_outlined,
                            color: Colors.white,
                          )),
                      title:
                          _textUtils.bold16("My Cards & Wallet", Colors.black),
                      trailing: const Icon(Icons.navigate_next_rounded),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MarchantNavigatorScreen(
                                name: "My Cards & Wallet")));
                      },
                    ),
                    // const Divider(
                    //   height: 0,
                    // ),
                    // ListTile(
                    //   leading: Container(
                    //       padding: const EdgeInsets.all(3),
                    //       decoration: BoxDecoration(
                    //           color: primaryColor,
                    //           borderRadius: BorderRadius.circular(5)),
                    //       child: const Icon(
                    //         Icons.redeem,
                    //         color: Colors.white,
                    //       )),
                    //   title: _textUtils.bold16("My Rewards", Colors.black),
                    //   trailing: const Icon(Icons.navigate_next_rounded),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) =>
                    //             const NavigatorScreen(name: "My Rewards")));
                    //   },
                    // ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.white,
                          )),
                      title: _textUtils.bold16("My Addresses", Colors.black),
                      trailing: const Icon(Icons.navigate_next_rounded),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MarchantNavigatorScreen(
                                name: "My Addresses")));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(
                            Icons.contact_support,
                            color: Colors.white,
                          )),
                      title: _textUtils.bold16("Help Center", Colors.black),
                      trailing: const Icon(Icons.navigate_next_rounded),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MarchantNavigatorScreen(
                                name: "Help Center")));
                      },
                    ),
                  ],
                )),
                ListTile(
                  tileColor: primaryColor,
                  leading: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                  title: _textUtils.bold16("LOGOUT", Colors.white),
                  onTap: () async {
                    await FirebaseHelper.Auth.logout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  },
                ),
              ]);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
