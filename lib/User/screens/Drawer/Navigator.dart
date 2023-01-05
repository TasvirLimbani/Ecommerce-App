import 'package:flutter/material.dart';
import 'package:plant_app/User/screens/Drawer/Account_Setting/Account_Setting.dart';
import 'package:plant_app/User/screens/Drawer/Help_Center.dart';
import 'package:plant_app/User/screens/Drawer/My_Addresse.dart';
import 'package:plant_app/User/screens/Drawer/My_Cards.dart';
import 'package:plant_app/User/screens/Drawer/My_Cart.dart';
import 'package:plant_app/User/screens/Drawer/My_Order.dart';
import 'package:plant_app/User/screens/Drawer/My_Rewards.dart';
import 'package:plant_app/User/screens/Drawer/Notification.dart';
import 'package:plant_app/utils/Text_utils.dart';

class NavigatorScreen extends StatelessWidget {
  final String name;
  const NavigatorScreen({Key? key,required this.name}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    TextUtils _textUtils = TextUtils();
    return Scaffold(
      appBar:  AppBar(
        title: _textUtils.bold18(name, Colors.white),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if(name=="Account Setting")AccountSetting(),
          if(name=="Notifications")NotificationScreen(),
          if(name=="Your Cart") MyCart(),
          if(name=="Your Order")MyOrder(),
          if(name=="My Cards & Wallet")MyCards(),
          if(name=="My Rewards")MyRewards(),
          if(name=="My Addresses")MyAddresse(),
          if(name=="Help Center")HelpCenter(),
        ],
      ),
    );
  }
}